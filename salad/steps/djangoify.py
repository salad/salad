from lettuce import step, world
from salad.logger import logger

try:
    from lettuce.django import django_url

    @step(r'(?:visit|access|open) the django url "(.*)"')
    def go_to_the_url(step, url):
        world.response = world.browser.visit(django_url(url))
except:
    try:
        # Only complain if it seems likely that using django was intended.
        import django
        logger.warn("Django steps not imported.")
    except:
        pass
