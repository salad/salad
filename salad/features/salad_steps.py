# Imports and SALAD_PATH just for testing within salad.
from os.path import abspath, join, dirname
from sys import path

SALAD_ROOT = abspath(join(dirname(__file__), "../", "../"))
path.insert(0, SALAD_ROOT)

from salad.steps.everything import *
from salad.tests import TEST_SERVER_PORT


@step(r'visit the salad test url "(.*)"')
def go_to_the_salad_test_url(step, url):
    try:
        go_to_the_url(step, "http://localhost:%s/%s" % (TEST_SERVER_PORT, url))
    except:
        go_to_the_url(step, "http://localhost:%s/%s" % (TEST_SERVER_PORT, url))
