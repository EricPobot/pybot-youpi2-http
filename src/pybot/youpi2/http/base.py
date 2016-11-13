# -*- coding: utf-8 -*-

from pkg_resources import resource_filename
import os

from bottle import Bottle, TEMPLATE_PATH, template, static_file, HTTPError

from pybot.core.log import LogMixin, INFO

__author__ = 'Eric Pascual'

STATIC_PATH = []


class YoupiBottleApp(Bottle, LogMixin):
    def __init__(self, name=None, arm=None, panel=None, log_level=INFO,
                 template_path="data/templates/", static_path="data/static/",
                 resources_search_path=None):
        LogMixin.__init__(self, name=name, level=log_level)
        self.log_info('log level set to %s', self.log_effective_level_as_string)

        if resources_search_path:
            self.log_info('processing resource search path :')
            for pkg in resources_search_path:
                self.log_info('+ ' + pkg)
                path = resource_filename(pkg, template_path)
                self.log_info('  + template path : %s', path)
                if path not in TEMPLATE_PATH:
                    if not os.path.isdir(path):
                        raise ValueError('path not found: ' + path)
                    TEMPLATE_PATH.insert(0, path)
                    self.log_info("    added to bottle.TEMPLATE_PATH")
                else:
                    self.log_info("    already in bottle.TEMPLATE_PATH")

                path = resource_filename(pkg, static_path)
                if path not in STATIC_PATH:
                    self.log_info('  + static path : %s', path)
                    if not os.path.isdir(path):
                        raise ValueError('path not found: ' + path)
                    STATIC_PATH.insert(0, path)
                    self.log_info("    added to STATIC_PATH")
                else:
                    self.log_info("    already in STATIC_PATH")

        Bottle.__init__(self)

        self.arm = arm
        self.panel = panel

        self.route('/help', 'GET', callback=self.get_help)
        self.route('/static/<filepath:path>', 'GET', callback=self.serve_static)

    def get_help(self):
        return {'routes': [r.method + ' ' + r.rule for r in self.routes]}

    def get_context(self, **kwargs):
        return {}

    def render_template(self, name, **kwargs):
        return template(name, self.get_context(**kwargs))

    def serve_static(self, filepath):
        self.log_debug('requesting static file: %s', filepath)

        last_path = STATIC_PATH[-1]
        for path in STATIC_PATH:
            try:
                self.log_debug('-> found in ' + path)
                return static_file(filepath, root=path)
            except HTTPError:
                if path == last_path:
                    self.log_error('static file not found: %s', filepath)
                    raise

