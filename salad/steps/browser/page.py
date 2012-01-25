from lettuce import step, world
from salad.tests.util import assert_equals_with_negate
# Verify page-level attributes (title, size, etc)


@step(r'should( not)? see that the page is titled "(.*)"')
def should_be_titled(step, negate, title):
    assert_equals_with_negate(world.browser.title, title, negate)


@step(r'should( not)? see that the url is "(.*)"')
def should_have_the_url(step, negate, url):
    assert_equals_with_negate(world.browser.url, url, negate)


@step(r'should( not)? see that the page html is "(.*)"')
def should_have_html(step, negate, html):
    assert_equals_with_negate(world.browser.html, html, negate)
