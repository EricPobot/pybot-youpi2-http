# -*- coding: utf-8 -*-

from bottle import template, static_file

from pybot.youpi2.http.base import YoupiBottleApp, STATIC_PATH
from pybot.youpi2.http.__version__ import version

__author__ = 'Eric Pascual'


class UIApp(YoupiBottleApp):
    def __init__(self, *args, **kwargs):
        super(UIApp, self).__init__(*args, **kwargs)

        self.route('/static/<filepath:path>', 'GET', callback=self.serve_static)

        self.route('/', callback=self.home)
        self.route('/index', callback=self.home)
        self.route('/home', callback=self.home)
        self.route('/about', callback=self.about)
        self.route('/control/motor', callback=self.ctrl_motor)
        self.route('/control/joint', callback=self.ctrl_joint)
        self.route('/control/ik', callback=self.ctrl_ok)

    def _context(self, **kwargs):
        context = {
            'title': 'Youpi 2.0',
            'version': version
        }
        context.update(kwargs)
        return context

    def _render_template(self, name, **kwargs):
        return template(name, self._context(**kwargs))

    def serve_static(self, filepath):
        self.log_debug('requesting static file: %s', filepath)
        return static_file(filepath, root=STATIC_PATH)

    def home(self):
        return self._render_template('ui_home')

    def about(self):
        return self._render_template('ui_about')

    def ctrl_motor(self):
        return self._render_template('ui_ctrl_motor')

    def ctrl_joint(self):
        return self._render_template('ui_ctrl_joint')

    def ctrl_ok(self):
        return self._render_template('ui_ctrl_ik')
