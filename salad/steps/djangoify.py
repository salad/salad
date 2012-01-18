import logging
from lettuce import step, world

try:
    from lettuce.django import django_url

    @step(r'access the django url "(.*)"')
    def go_to_the_url(step, url):
        world.response = world.browser.visit(django_url(url))
except:
    logging.warn("Django steps not imported.")
