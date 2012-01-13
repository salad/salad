import time

from lettuce import step, world
from nose.tools import assert_equals


@step(r'access the url "(.*)"')
def go_to_the_url(step, url):
    world.response = world.browser.visit(url)


@step(r'fill in "(.*)" with "(.*)"')
def fill_in(step, field, value):
    world.browser.fill(field, value)


@step(r'click on the element named "(.*)"')
def click_on_by_name(step, name):
    world.browser.find_by_name(name).first.click()


@step(r'click the link called "(.*)"')
def should_click_a_link_called(step, text):
    world.browser.find_link_by_text(text).first.click()


@step(r'should see "(.*)"')
def should_see(step, text):
    assert text in world.browser.html


@step(r'should not see "(.*)"')
def should_not_see(step, text):
    assert not text in world.browser.html


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


@step(r'the value of "(.*)" should be "(.*)"')
def field_should_have_a_value(step, field, value):
    field = world.browser.find_by_name(field)
    assert_equals(field.value, value)


@step(r'I click the button labeled "(.*)"')
def click_the_button_labeled(step, label):
    # btn = world.browser.find_link_by_text(label)
    btn = world.browser.find_by_css(".submit_button")
    btn.click()


@step(r'look around')
def look_around(step):
    pass


@step(r'wait (\d+) seconds?')
def wait(step, seconds):
    time.sleep(int(seconds))


@step(r'Then I should fail because "(.*)"')
def should_fail(step, because):
    assert because == True
