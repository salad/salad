from lettuce import before
from salad.logger import logger

try:
    logger.info("Loading the terrain file...")

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
    try:
        # Only complain if it seems likely that using django was intended.
        import django
        logger.info("Django terrains not imported.")
    except:
        pass
