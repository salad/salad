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


@step(r'switch(?: back) to the parent frame')
def back_to_the_parent_frame(step):
    world.browser.driver.switch_to_frame(None)


@step(r'switch to the iframe "(.*)"')
def switch_to_iframe(step, iframe_id):
    world.browser.driver.switch_to_frame(iframe_id)
