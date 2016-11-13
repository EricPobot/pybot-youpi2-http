# -*- coding: utf-8 -*-

from pybot.youpi2.http.base import YoupiBottleApp
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

    def get_context(self, **kwargs):
        context = {
            'title': 'Youpi 2.0',
            'version': version
        }
        context.update(kwargs)
        return context

    def home(self):
        return self.render_template('ui_home')

    def about(self):
        return self.render_template('ui_about')

    def ctrl_motor(self):
        return self.render_template('ui_ctrl_motor')

    def ctrl_joint(self):
        return self.render_template('ui_ctrl_joint')

    def ctrl_ok(self):
        return self.render_template('ui_ctrl_ik')
