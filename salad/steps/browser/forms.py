from lettuce import step, world
from nose.tools import assert_equals

# Interact with form elements


@step(r'fill in "(.*)" with "(.*)"')
def fill_in(step, field, value):
    world.browser.fill(field, value)


@step(r'hit enter in "(.*)"')
def hit_enter_in(step, field):
    world.browser.type(field, "\n")


@step(r'the value of "(.*)" should be "(.*)"')
def field_should_have_a_value(step, field, value):
    field = world.browser.find_by_name(field)
    assert_equals(field.value, value)
