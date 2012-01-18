# Imports and SALAD_PATH just for testing within salad.
from os.path import abspath, join, dirname
from sys import path

SALAD_ROOT = abspath(join(dirname(__file__), "../", "../"))
path.insert(0, SALAD_ROOT)

from salad.steps.everything import *
