#/usr/bin/env python
import os
from setuptools import setup, find_packages
from salad import VERSION

ROOT_DIR = os.path.dirname(__file__)
SOURCE_DIR = os.path.join(ROOT_DIR)

requirements = ["nose", "splinter", "lettuce"]
try: import argparse
except ImportError: requirements.append('argparse')

setup(
    name="salad",
    description="A nice mix of great BDD ingredients",
    author="Jana Rekittke",
    author_email="jana@rekittke.name ",
    url="https://github.com/salad/salad",
    version=VERSION,
    install_requires=requirements,
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
