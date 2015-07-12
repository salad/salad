# -*- coding: utf-8 -*-

from lettuce import step, world

from salad.tests.util import (
    assert_equals_with_negate,
    wait_for_completion,
    assert_with_negate
)

# Verify page-level attributes (title, size, html)


@step(r'should( not)? see that the page (is titled|title contains) "([^"]*)"'
      '(?: within (\d+) seconds)?$')
def should_be_titled(step, negate, partial, title, wait_time):
    def assert_title_equals(negate, partial, title):
        if 'contains' in partial:
            assert_with_negate(title in world.browser.title, negate)
        else:
            assert_equals_with_negate(world.browser.title, title, negate)
        return True

    wait_for_completion(wait_time, assert_title_equals, negate, partial, title)


@step(r'should( not)? see that the url (is|contains) "([^"]*)"'
      '(?: within (\d+) seconds)?$')
def should_have_the_url(step, negate, partial, url, wait_time):
    def assert_url_equals(negate, partial, url):
        if partial == 'is':
            assert_equals_with_negate(world.browser.url, url, negate)
        else:
            assert_with_negate(url in world.browser.url, negate)
        return True

    wait_for_completion(wait_time, assert_url_equals, negate, partial, url)


@step(r'should( not)? see that the page html (is|contains) "([^"]*)"'
      '(?: within (\d+) seconds)?$')
def should_have_html(step, negate, partial, html, wait_time):
    def assert_page_html_is(negate, partial, html):
        if partial == 'is':
            assert_equals_with_negate(world.browser.html, html, negate)
        else:
            assert_with_negate(html in world.browser.html, negate)
        return True

    wait_for_completion(wait_time, assert_page_html_is, negate, partial, html)


# TODO use proper iframe handling here
@step(r'switch(?: back) to the parent frame$')
def back_to_the_parent_frame(step):
    world.browser.driver.switch_to_frame(None)


@step(r'switch to the iframe "([^"]*)"$')
def switch_to_iframe(step, iframe_id):
    world.browser.driver.switch_to_frame(iframe_id)
