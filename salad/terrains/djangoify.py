from lettuce import before, world, after
from salad.logger import logger

try:
    from django.core.management import call_command
    from django.conf import settings
    from django.test.simple  import DjangoTestSuiteRunner
    from django.core import mail
    try:
        from south.management.commands import patch_for_test_db_setup
        USE_SOUTH = getattr(settings, "SOUTH_TESTS_MIGRATE", False)
    except:
        USE_SOUTH = False

    @before.all
    def setup_database():
        logger.info("Setting up a test database ...\n")

        if settings.DATABASES["default"]["ENGINE"] != "django.db.backends.sqlite3":
            from django.db import connection
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
        logger.info("Destroying test database ...\n")
        world.test_runner.teardown_test_environment()

    @after.each_feature
    def reset_data(scenario):
        logger.info("Flushing...")
        call_command('flush', interactive=False, verbosity=0)

    @before.each_feature
    def empty_outbox(scenario):
        logger.info("Emptying outbox...")
        mail.outbox = []


except:
    logger.warn("Django terrains not imported.")
