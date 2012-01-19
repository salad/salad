from os.path import abspath, join, dirname
from subprocess import Popen
from sys import path

from lettuce import before, world, after
from salad.tests import TEST_SERVER_PORT
from salad.terrains.everything import *
from salad.logger import logger

# Imports and SALAD_PATH just for testing within salad.
SALAD_ROOT = abspath(join(dirname(__file__), "../", "../"))
path.insert(0, SALAD_ROOT)


@before.all
def setup_subprocesses():
    world.subprocesses = []


@before.all
def setup_test_server():
    file_server_command = "python -m SimpleHTTPServer %s" % (TEST_SERVER_PORT)
    test_dir = abspath(join(SALAD_ROOT, "salad", "tests", "html"))
    world.subprocesses.append(Popen(file_server_command, shell=True, cwd=test_dir))


@after.all
def teardown_test_server(total):
    for s in world.subprocesses:
        try:
            s.terminate()
        except:
            try:
                s.kill()
            except Exception, e:
                logger.error(e)
