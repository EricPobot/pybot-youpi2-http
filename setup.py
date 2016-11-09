from setuptools import setup, find_packages

setup(
    name='pybot-youpi2-http',
    setup_requires=['setuptools_scm'],
    use_scm_version={
        'write_to': 'src/pybot/youpi2/http/__version__.py'
    },
    namespace_packages=['pybot', 'pybot.youpi2'],
    packages=find_packages("src"),
    package_dir={'': 'src'},
    package_data={'pybot.youpi2.http': [
        # stylesheets
        'data/static/css/bootstrap-slate.min.css',
        'data/static/css/bootstrap-toc.min.css',
        # fonts
        'data/static/css/youpi.css',
        'data/static/fonts/*.ttf',
        # Javascript
        'data/static/js/*.min.js',
        'data/static/js/fr.js',
        'data/static/js/youpi*.js',
        # graphics
        'data/static/img/*',
        # templates
        'data/templates/*.tpl'
    ]},
    url='',
    license='',
    author='Eric Pascual',
    author_email='eric@pobot.org',
    install_requires=['pybot-youpi2-app', 'bottle>=0.12.9'],
    extras_require={
        'systemd': ['pybot-systemd']
    },
    download_url='https://github.com/Pobot/PyBot',
    description='Youpi2 embedded HTTP server',
    entry_points={
        'console_scripts': [
            'youpi2-http-server = pybot.youpi2.http.webapp:main',
            'youpi2-http-doc = pybot.youpi2.http.docsrvr:main',
            # systemd related
            "youpi2-http-doc-systemd-install = pybot.youpi2.http.setup.systemd:install_service [systemd]",
            "youpi2-http-doc-systemd-remove = pybot.youpi2.http.setup.systemd:remove_service [systemd]",
        ]
    }
)
