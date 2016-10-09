# -*- coding: utf-8 -*-

import bottle
import time
import threading
from Queue import Queue, Empty

from pybot.youpi2.app import YoupiApplication

from __version__ import version
from base import YoupiBottleApp, TEMPLATE_PATH, STATIC_PATH
from apps.api import RestAPIApp
from apps.ui import UIApp

__author__ = 'Eric Pascual'


class HTTPServerApp(YoupiApplication):
    NAME = 'http'
    TITLE = "HTTP Server"
    VERSION = version

    DEFAULT_LISTEN_PORT = 8080

    server = None
    server_thread = None
    first_loop = True

    display_queue = None
    display_queue_worker = None

    def add_custom_arguments(self, parser):
        parser.add_argument('--port', type=int, default=self.DEFAULT_LISTEN_PORT)

    def setup(self, port=DEFAULT_LISTEN_PORT, **kwargs):
        self.display_queue = Queue()
        self.display_queue_worker = threading.Thread(target=self.process_display_requests)

        # create the Bottle server using a sub-classed version of WSGIServer
        self.server = InterruptibleWSGIServer(port=port)

        # start it by executing the run() method in a thread
        def bottle_run():
            self.log_info("Bottle v%s server starting up (using %s)...", bottle.__version__, self.server)
            self.log_info('template path: %s', TEMPLATE_PATH)
            self.log_info('static path: %s', STATIC_PATH)

            app = YoupiBottleApp(arm=self.arm, panel=self.pnl, name='app-root')
            ui_app = UIApp(arm=self.arm, panel=self.pnl, name='app-ui')
            api_app = RestAPIApp(arm=self.arm, panel=self.pnl, name='app-api')

            app.add_hook('before_request', self.before_request)
            app.add_hook('after_request', self.after_request)

            app.merge(ui_app.routes)
            app.mount('/api/v1/', api_app)

            self.log_info("Listening on http://%s:%d/" % (self.server.host, self.server.port))

            bottle.run(app=app, server=self.server)

            self.log_info('Bottle server terminated')

        self.server_thread = threading.Thread(target=bottle_run)

    def before_request(self):
        self.post_display_request(self.pnl.write_at, bottle.request.remote_addr, line=2)

        method = bottle.request.method
        self.post_display_request(self.pnl.write_at, ' ' + method, line=2, col=self.pnl.width - len(method))
        qry = bottle.request.query_string
        if qry:
            s = bottle.request.path + '?' + qry
        else:
            s = bottle.request.path
        self.post_display_request(self.pnl.write_at, s[:20].ljust(20), line=3)
        self.post_display_request(self.pnl.center_text_at, 'Processing...', line=4)

    def after_request(self):
        resp = bottle.response
        w = self.pnl.width
        part1 = ("status=%s" % resp.status_code).ljust(w)
        try:
            part2 = "size=%d" % resp.content_length
        except:
            part2 = ""
        self.post_display_request(self.pnl.write_at, part1[:w - len(part2)] + part2, line=4)

    def process_display_requests(self):
        self.log_info('display requests worker started')
        while not self.terminated:
            try:
                req = self.display_queue.get(True, 0.01)
                self.log_debug('processing display request: %s', req)
                try:
                    req.execute()
                except Exception as e:
                    self.log_error('error while processing: %s', req)
                    self.log_error(e)
                else:
                    self.log_debug('.. done')

            except Empty:
                pass

        self.log_info('display requests worker terminated')

    def post_display_request(self, meth, *args, **kwargs):
        req = DisplayRequest(meth, args, kwargs)
        self.display_queue.put(req)
        self.log_debug('display request added to queue: %s', req)

    def loop(self):
        if self.first_loop:
            self.server_thread.start()
            self.first_loop = False
            self.pnl.center_text_at('Ready', 3)

            self.display_queue_worker.start()

        else:
            # nothing to do here since the server is running in a thread.
            # we sleep a bit in order not to hog the CPU by an empty body
            try:
                time.sleep(0.1)
            except KeyboardInterrupt:
                self.log_info('!! interrupted')
                return True

    def teardown(self, exit_code):
        if self.display_queue_worker:
            self.display_queue_worker.join(1)

        self.pnl.center_text_at('', 2)
        self.pnl.center_text_at('Terminating...', 3)
        self.pnl.center_text_at('', 3)

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

        class FixedHandler(WSGIRequestHandler):
            def address_string(self):   # Prevent reverse DNS lookups
                return self.client_address[0]

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


class DisplayRequest(object):
    def __init__(self, pnl_meth, args, kwargs):
        self.pnl_meth = pnl_meth
        self.meth_args = args
        self.meth_kwargs = kwargs

    def __str__(self):
        return '%s(%s, %s)' % (
            self.pnl_meth.__name__,
            ', '.join((repr(a) for a in self.meth_args)),
            ', '.join(("%s=%s" % (k, repr(v)) for k, v in self.meth_kwargs.iteritems()))
        )

    def execute(self):
        self.pnl_meth(*self.meth_args, **self.meth_kwargs)


def main():
    HTTPServerApp().main()
