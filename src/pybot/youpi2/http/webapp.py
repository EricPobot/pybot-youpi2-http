# -*- coding: utf-8 -*-

import bottle
import time
import threading

from pybot.youpi2.app import YoupiApplication

from __version__ import version
from base import YoupiBottleApp
from apps.api import RestAPIApp
from apps.ui import UIApp

__author__ = 'Eric Pascual'


class WebServerApp(YoupiApplication):
    NAME = 'http'
    TITLE = "Web Server"
    VERSION = version

    server = None
    server_thread = None
    first_loop = True

    def add_custom_arguments(self, parser):
        parser.add_argument('--port', type=int, default=8080)

    def setup(self, port=8080, **kwargs):
        # create the Bottle server using a sub-classed version of WSGIServer
        self.server = InterruptibleWSGIServer(port=port)

        # start it by executing the run() method in a thread
        def bottle_run():
            self.log_info("Bottle v%s server starting up (using %s)...", bottle.__version__, self.server)
            self.log_info("Listening on http://%s:%d/" % (self.server.host, self.server.port))

            app = YoupiBottleApp(arm=self.arm, panel=self.pnl, name='app-root')
            ui_app = UIApp(arm=self.arm, panel=self.pnl, name='app-ui')
            api_app = RestAPIApp(arm=self.arm, panel=self.pnl, name='app-api')

            app.merge(ui_app.routes)
            app.mount('/api/v1/', api_app)

            bottle.run(app=app, server=self.server)

            self.log_info('Bottle server terminated')

        self.server_thread = threading.Thread(target=bottle_run)

    def loop(self):
        if self.first_loop:
            self.server_thread.start()
            self.first_loop = False

        else:
            # nothing to do here since the server is running in a thread.
            # we sleep a bit in order not to hog the CPU by an empty body
            try:
                time.sleep(0.1)
            except KeyboardInterrupt:
                self.log_info('!! interrupted')
                return True

    def teardown(self, exit_code):
        self.pnl.center_text_at('Terminating...', 3)

        if self.server:
            self.log_info('sending shutdown signal to server')
            self.server.shutdown()

            if self.server_thread:
                self.log_info('waiting for thread termination')
                self.server_thread.join(5)
                self.server_thread = None

            self.server = None

        self.log_info('server shutdown complete')


class InterruptibleWSGIServer(bottle.WSGIRefServer):
    srv = None

    def __init__(self, *args, **kwargs):
        super(InterruptibleWSGIServer, self).__init__(host='0.0.0.0', *args, **kwargs)

    def run(self, app):
        from wsgiref.simple_server import WSGIRequestHandler, WSGIServer
        from wsgiref.simple_server import make_server
        import socket

        panel = app.panel

        class FixedHandler(WSGIRequestHandler):
            def address_string(self):   # Prevent reverse DNS lookups
                return self.client_address[0]

            def log_request(self, code='-', size='-'):
                method, url, protocol = self.requestline.split()

                panel.write_at(self.client_address[0], line=2)
                panel.write_at(' ' + method, line=2, col=panel.width - len(method))

                panel.write_at(url[:20].ljust(20), line=3)

                panel.center_text_at("code=%s size=%s" % (code, size), line=4)

                return WSGIRequestHandler.log_request(self, code=code, size=size)

            def log_message(self, msg_format, *args):
                app.log_info("[%s] %s", self.client_address[0], msg_format % args)

        FixedHandler.quiet = self.quiet

        handler_cls = self.options.get('handler_class', FixedHandler)
        server_cls = self.options.get('server_class', WSGIServer)

        if ':' in self.host:    # Fix wsgiref for IPv6 addresses.
            if getattr(server_cls, 'address_family') == socket.AF_INET:
                class server_cls(server_cls):
                    address_family = socket.AF_INET6

        self.srv = make_server(self.host, self.port, app, server_cls, handler_cls)
        self.srv.serve_forever()

    def shutdown(self):
        if self.srv:
            self.srv.shutdown()


def main():
    WebServerApp().main()
