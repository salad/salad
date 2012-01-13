import logging
from lettuce import before, world, after

from django.db import connection
from django.core.management import call_command
from django.conf import settings
from django.test.simple  import DjangoTestSuiteRunner
try:
    from south.management.commands import patch_for_test_db_setup
    USE_SOUTH = True
except:
    USE_SOUTH = False


@before.all
def setup_database():
    logging.info("Setting up a test database ...\n")

    if settings.DATABASES["default"]["ENGINE"] != "django.db.backends.sqlite3":
        database_name = settings.DATABASES["default"]["NAME"]
        cursor = connection.cursor()
        cursor.execute("DROP DATABASE %s" % database_name)
        cursor.execute("CREATE DATABASE %s" % database_name)
        connection.close()
    else:
        # connection.settings_dict["NAME"] = ":memory:"
        pass

    if USE_SOUTH:
        patch_for_test_db_setup()

    world.test_runner = DjangoTestSuiteRunner(interactive=False)
    world.test_runner.setup_test_environment()

    call_command('syncdb', interactive=False, verbosity=0)
    call_command('flush', interactive=False, verbosity=0)


@after.all
def teardown_database(total):
    logging.info("Destroying test database ...\n")
    world.test_runner.teardown_test_environment()


@after.each_feature
def reset_data(scenario):
    logging.info("Flushing...")
    call_command('flush', interactive=False, verbosity=0)
