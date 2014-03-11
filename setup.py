#/usr/bin/env python
import os
from setuptools import setup, find_packages
from salad import VERSION

ROOT_DIR = os.path.dirname(__file__)
SOURCE_DIR = os.path.join(ROOT_DIR)

requirements = ["nose==1.3.0", "splinter>=0.4.9", "lettuce>=0.2.19"]
try: import argparse
except ImportError: requirements.append('argparse')

setup(
    name="salad",
    description="A nice mix of great BDD ingredients",
    author="Lieferheld QA",
    author_email="qa@deliveryhero.com",
    url="https://github.com/beanqueen/salad",
    version=VERSION,
#    download_url = ['https://github.com/gabrielfalcao/lettuce/tarball/fork', ],
    install_requires=requirements,
#    dependency_links = ['https://github.com/gabrielfalcao/lettuce/tarball/fork#egg=lettuce-0.2.19', ],
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
