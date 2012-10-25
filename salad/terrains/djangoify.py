from lettuce import before, world, after
from salad.logger import logger

try:
    logger.info("Loading the terrain file...")

    @before.all
    def setup_database():
        from django.core.management import call_command
        from django.conf import settings
        from django.test.simple import DjangoTestSuiteRunner

        try:
            from south.management.commands import patch_for_test_db_setup
            USE_SOUTH = getattr(settings, "SOUTH_TESTS_MIGRATE", False)
        except:
            USE_SOUTH = False

        logger.info("Setting up a test database...")

        if USE_SOUTH:
            patch_for_test_db_setup()

        world.test_runner = DjangoTestSuiteRunner(interactive=False)
        DjangoTestSuiteRunner.setup_test_environment(world.test_runner)
        world.created_db = DjangoTestSuiteRunner.setup_databases(world.test_runner)

        call_command('syncdb', interactive=False, verbosity=0)
        if USE_SOUTH:
            call_command('migrate', interactive=False, verbosity=0)
        call_command('loaddata', 'all', verbosity=0)

    @after.all
    def teardown_database(actual_server):
        from django.test.simple import DjangoTestSuiteRunner
        logger.info("Destroying the test database ...")

        DjangoTestSuiteRunner.teardown_databases(world.test_runner, world.created_db)
        DjangoTestSuiteRunner.teardown_test_environment(world.test_runner)

    @before.each_scenario
    def reset_data(scenario):
        from django.core.management import call_command

        # Clean up django.
        logger.info("Flushing the test database...")
        call_command('flush', interactive=False, verbosity=0)
        call_command('loaddata', 'all', verbosity=0)

    @before.each_feature
    def empty_outbox(scenario):
        from django.core import mail
        logger.info("Emptying outbox...")
        mail.outbox = []

except:
    from traceback import print_exc
    print_exc()
    try:
        # Only complain if it seems likely that using django was intended.
        import django
        logger.info("Django terrains not imported.")
    except:
        pass
