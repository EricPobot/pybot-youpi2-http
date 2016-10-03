# -*- coding: utf-8 -*-

from pkg_resources import resource_filename

from bottle import Bottle, TEMPLATE_PATH

from pybot.core.log import LogMixin, INFO

__author__ = 'Eric Pascual'

my_package = '.'.join(__name__.split('.')[:-1])

TEMPLATE_PATH.insert(0, resource_filename(my_package, "data/templates/"))
STATIC_PATH = resource_filename(my_package, "data/static/")


class YoupiBottleApp(Bottle, LogMixin):
    def __init__(self, name=None, arm=None, panel=None, log_level=INFO):
        Bottle.__init__(self)
        LogMixin.__init__(self, name=name, level=log_level)

        self.arm = arm
        self.panel = panel

        self.route('/help', 'GET', callback=self.get_help)

    def get_help(self):
        return {'routes': [r.method + ' ' + r.rule for r in self.routes]}
