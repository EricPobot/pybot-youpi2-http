# -*- coding: utf-8 -*-

from pkg_resources import resource_filename
import os
import inspect

from bottle import Bottle, TEMPLATE_PATH

from pybot.core.log import LogMixin, INFO

__author__ = 'Eric Pascual'


class YoupiBottleApp(Bottle, LogMixin):
    def __init__(self, name=None, arm=None, panel=None, log_level=INFO,
                 template_path="data/templates/", static_path="data/static/",
                 resources_packages=None):
        LogMixin.__init__(self, name=name, level=log_level)

        if not resources_packages:
            fqn = inspect.getmodule(self).__name__
            resources_packages = ['.'.join(fqn.split('.')[:-1])]

        for pkg in resources_packages:
            path = resource_filename(pkg, template_path)
            if path not in TEMPLATE_PATH:
                if not os.path.isdir(path):
                    raise ValueError('path not found: ' + path)
                TEMPLATE_PATH.insert(0, path)
                self.log_info("%s added to bottle.TEMPLATE_PATH", path)

        self.static_path = resource_filename(resources_packages, static_path)
        if not os.path.isdir(self.static_path):
            raise ValueError('path not found: ' + self.static_path)

        Bottle.__init__(self)

        self.arm = arm
        self.panel = panel

        self.route('/help', 'GET', callback=self.get_help)

    def get_help(self):
        return {'routes': [r.method + ' ' + r.rule for r in self.routes]}
