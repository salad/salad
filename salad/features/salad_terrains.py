import time
from os import remove
from os.path import abspath, join, dirname
from subprocess import Popen
from sys import path

# Imports and SALAD_PATH just for testing within salad.
SALAD_ROOT = abspath(join(dirname(__file__), "../", "../"))
path.insert(0, SALAD_ROOT)

from lettuce import before, world, after
from salad.tests import TEST_SERVER_PORT
from salad.terrains.everything import *
from salad.logger import logger


@before.all
def setup_subprocesses():
    world.subprocesses = []


@before.all
def setup_test_server():
    file_server_command = "python -m SimpleHTTPServer %s" % (TEST_SERVER_PORT)
    test_dir = abspath(join(SALAD_ROOT, "salad", "tests", "html"))
    world.silent_output = file('/dev/null', 'a+')
    world.tempfile = file('/dev/null', 'a+')

    world.subprocesses.append(Popen(file_server_command,
                                    shell=True,
                                    cwd=test_dir,
                                    stderr=world.silent_output,
                                    stdout=world.silent_output
                                ))
    time.sleep(3)  # Wait for server to spin up


@after.all
def teardown_test_server(total):
    world.silent_output.close()
    for s in world.subprocesses:
        try:
            s.terminate()
        except:
            try:
                s.kill()
            except OSError:
                # Ignore an exception for process already killed.
                pass


@before.all
def create_tempfile():
    world.tempfile = file('/tmp/temp_lettuce_test', 'a+')
    world.tempfile.close()


@after.all
def remove_tempfile(total):
    remove("/tmp/temp_lettuce_test")
