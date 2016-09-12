from setuptools import setup, find_packages

setup(
    name='pybot-youpi2-restapi',
    setup_requires=['setuptools_scm'],
    use_scm_version={
        'write_to': 'src/pybot/youpi2/restapi/__version__.py'
    },
    namespace_packages=['pybot', 'pybot.youpi2'],
    packages=find_packages("src"),
    package_dir={'': 'src'},
    # package_data={'pybot.youpi2.restapi': ['data/*']},
    url='',
    license='',
    author='Eric Pascual',
    author_email='eric@pobot.org',
    install_requires=['pybot-youpi2>=0.23', 'pybot-lcd-fuse>=0.20.1'],
    download_url='https://github.com/Pobot/PyBot',
    description='Youpi2 REST API server',
    entry_points={
        'console_scripts': [
            'youpi2-restapi = pybot.youpi2.restapi.app:main',
        ]
    }
)
