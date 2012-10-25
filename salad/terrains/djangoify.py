from lettuce import before, world, after
from salad.logger import logger

old_database_name = None

try:
    logger = getLogger(__name__)
    logger.info("Loading the terrain file...")

    from django.core.management import call_command
    from django.conf import settings
    from django.test.simple import DjangoTestSuiteRunner
    from django.core import mail
    try:
        from south.management.commands import patch_for_test_db_setup
        USE_SOUTH = getattr(settings, "SOUTH_TESTS_MIGRATE", False)
    except:
        USE_SOUTH = False

    @before.runserver
    def setup_database(actual_server):
        logger.info("Setting up a test database...")

        if USE_SOUTH:
            patch_for_test_db_setup()

        world.test_runner = DjangoTestSuiteRunner(interactive=False)
        DjangoTestSuiteRunner.setup_test_environment(world.test_runner)
        world.created_db = DjangoTestSuiteRunner.setup_databases(world.test_runner)

        call_command('syncdb', interactive=False, verbosity=0)
        call_command('migrate', interactive=False, verbosity=0)
        call_command('loaddata', 'all', verbosity=0)

    @after.runserver
    def teardown_database(actual_server):
        logger.info("Destroying the test database ...")

        DjangoTestSuiteRunner.teardown_databases(world.test_runner, world.created_db)
        DjangoTestSuiteRunner.teardown_test_environment(world.test_runner)

    @before.each_scenario
    def reset_data(scenario):
        # Clean up django.
        logger.info("Flushing the test database...")
        call_command('flush', interactive=False, verbosity=0)
        call_command('loaddata', 'all', verbosity=0)

    @before.each_feature
    def empty_outbox(scenario):
        logger.info("Emptying outbox...")
        mail.outbox = []

except:
    try:
        # Only complain if it seems likely that using django was intended.
        import django
        logger.warn("Django terrains not imported.")
    except:
        pass
