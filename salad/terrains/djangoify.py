from lettuce import before
from salad.logger import logger

logger.info("Loading the terrain file...")
try:
    from django.core import mail
    from django.core.management import call_command

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
        logger.info("Django terrains not imported.")
    except:
        pass
