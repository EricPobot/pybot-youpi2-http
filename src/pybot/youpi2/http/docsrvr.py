# -*- coding: utf-8 -*-

from pkg_resources import resource_filename

from bottle import route, run, static_file, view

from __version__ import version

__author__ = 'Eric Pascual'

my_package = '.'.join(__name__.split('.')[:-1])
STATIC_PATH = resource_filename(my_package, "data/static")


def _context(**kwargs):
    context = {
        'title': 'Youpi 2.0',
        'version': version
    }
    context.update(kwargs)
    return context


@route("/static/<filepath:path>")
def serve_static(filepath):
    return static_file(filepath, root=STATIC_PATH)


@route("/")
@route("/home")
@route("/index")
@view('home')
def home():
    return _context()


@route("/about")
@view('about')
def about():
    return _context()


@route("/detail/origins")
@view("detail_origins")
def origins():
    return _context()


@route("/detail/works")
@view("detail_works")
def works():
    return _context()


@route("/detail/tech")
@view("detail_technics")
def technics():
    return _context()


@route("/detail/demos")
@view("detail_demos")
def technics():
    return _context()


def main():
    run(host="0.0.0.0", port=80)
