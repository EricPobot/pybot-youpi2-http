# -*- coding: utf-8 -*-

from pybot.youpi2.http.base import YoupiBottleApp
from pybot.youpi2.http.__version__ import version

__author__ = 'Eric Pascual'


class UIApp(YoupiBottleApp):
    def __init__(self, *args, **kwargs):
        super(UIApp, self).__init__(*args, **kwargs)

        self.route('/', 'GET', callback=self.home)
        self.route('/index', 'GET', callback=self.home)
        self.route('/home', 'GET', callback=self.home)

    def home(self):
        return "Youpi version %s says : hello" % version

