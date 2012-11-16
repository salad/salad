#/usr/bin/env python
import os
from setuptools import setup, find_packages
from salad import VERSION

ROOT_DIR = os.path.dirname(__file__)
SOURCE_DIR = os.path.join(ROOT_DIR)

setup(
    name="salad",
    description="A nice mix of great BDD ingredients",
    author="Steven Skoczen",
    author_email="steven.skoczen@wk.com",
    url="https://github.com/wieden-kennedy/salad",
    version=VERSION,
    download_url = ['https://github.com/skoczen/lettuce/tarball/fork', ],
    install_requires=["nose", "splinter", "zope.testbrowser", "lettuce>=0.2.10.1"],
    dependency_links = ['https://github.com/skoczen/lettuce/tarball/fork#egg=lettuce-0.2.10.1', ],
    packages=find_packages(),
    zip_safe=False,
    include_package_data=True,
    classifiers=[
        "Programming Language :: Python",
        "License :: OSI Approved :: BSD License",
        "Operating System :: OS Independent",
        "Development Status :: 4 - Beta",
        "Environment :: Web Environment",
        "Intended Audience :: Developers",
        "Topic :: Internet :: WWW/HTTP",
        "Topic :: Software Development :: Libraries :: Python Modules",
    ],
    entry_points={
        'console_scripts': ['salad = salad.cli:main'],
    },
)
