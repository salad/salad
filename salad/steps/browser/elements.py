from lettuce import step, world
from salad.tests.util import assert_equals_with_negate, assert_with_negate
from salad.logger import logger

# Find and verify that elements exist, have the expected content and attributes (text, classes, ids)
#


@step(r'should( not)? see "(.*)" somewhere in (?:the|this) page')
def should_see_in_the_page(step, negator, text):
    assert_with_negate(text in world.browser.html, negator)


@step(r'should( not)? see "(.*)"$')
def should_see(step, negator, text):
    logger.warn("'should see (text)' has been deprecated in favor of 'should see (text) somewhere in the page'.")
    logger.warn("'should see' will be removed in v0.5 of salad, please update your code!")
    should_see_in_the_page(step, negator, text)


@step(r'should see a link called "(.*)"')
def should_see_a_link_called(step, text):
    assert len(world.browser.find_link_by_text(text)) > 0


@step(r'should not see a link called "(.*)"')
def should_not_see_a_link_called(step, text):
    assert len(world.browser.find_link_by_text(text)) == 0


@step(r'should see a link to "(.*)"')
def should_see_a_link_to(step, link):
    assert len(world.browser.find_link_by_href(link)) > 0


@step(r'should not see a link to "(.*)"')
def should_not_see_a_link_to(step, link):
    assert len(world.browser.find_link_by_href(link)) == 0


@step(r'the element with the CSS selector of "(.*)" should be visible')
def element_visible(step, css):
    ele = world.browser.find_by_css(css)
    assert ele.visible == True


@step(r'the element with the CSS selector of "(.*)" should not be visible')
def element_invisible(step, css):
    ele = world.browser.find_by_css(css)
    assert ele.visible == False
