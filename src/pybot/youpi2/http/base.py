# -*- coding: utf-8 -*-

from bottle import Bottle

from pybot.core.log import LogMixin

__author__ = 'Eric Pascual'


class YoupiBottleApp(Bottle, LogMixin):
    def __init__(self, name=None, arm=None, panel=None):
        Bottle.__init__(self)
        LogMixin.__init__(self, name=name)

        self.arm = arm
        self.panel = panel

        self.route('/help', 'GET', callback=self.get_help)

    def get_help(self):
        return {'routes': [r.method + ' ' + r.rule for r in self.routes]}
