from lettuce import step, world
from nose.tools import assert_equals

# Browse from page to page


@step(r'access the url "(.*)"')
def go_to_the_url(step, url):
    world.response = world.browser.visit(url)
