from lettuce import step, world
from nose.tools import assert_equals

# Click on things, mouse over, move the mouse around.


@step(r'click on the element named "(.*)"')
def click_on_by_name(step, name):
    world.browser.find_by_name(name).first.click()


@step(r'click the link called "(.*)"')
def should_click_a_link_called(step, text):
    world.browser.find_link_by_text(text).first.click()


@step(r'I click the button labeled "(.*)"')
def click_the_button_labeled(step, label):
    # btn = world.browser.find_link_by_text(label)
    btn = world.browser.find_by_css(".submit_button")
    btn.click()
