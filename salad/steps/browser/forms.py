from time import sleep
from string import ascii_letters
from random import choice, randint
from lettuce import step, world
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.remote.errorhandler import StaleElementReferenceException
from salad.steps.browser.finders import (PICK_EXPRESSION, ELEMENT_FINDERS,
                                         ELEMENT_THING_STRING,
                                         _get_visible_element)
from salad.tests.util import (assert_equals_with_negate, assert_with_negate,
                              assert_value, store_with_case_option,
                              transform_for_upper_lower_comparison)

# What's happening here? We're generating steps for every possible permuation of the element finder

world.stored_values = dict()


def _generate_content(type_of_fill, length):
    if type_of_fill == 'email':
        return _generate_random_string(length) + '@mailinator.com'
    elif type_of_fill == 'string':
        return _generate_random_string(length)
    elif type_of_fill == 'name':
        name = _generate_random_string(length)
        if length <= 3:
            return name
        index = randint(1, len(name)-2)
        return name[:index] + ' ' + name[index+1:]


def _generate_random_string(length):
    lst = [choice(ascii_letters) for n in xrange(length)]
    return "".join(lst)


for finder_string, finder_function in ELEMENT_FINDERS.iteritems():

    def _type_generator(finder_string, finder_function):
        @step(r'(slowly )?type "([^"]*)" into the%s %s %s' % (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, slowly, text, pick, find_pattern):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            if slowly and slowly != "":
                _type_slowly(ele, text)
            else:
                ele.value = text

        return _this_step

    globals()["form_type_%s" % (finder_function,)] = _type_generator(finder_string, finder_function)

    def _select_generator(finder_string, finder_function):
        @step(r'select the option (named|with the value)? "([^"]*)" (?:from|in) the%s %s %s' % (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, named_or_with_value, field_value, pick, find_pattern):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            if named_or_with_value == "named":
                # this does not work properly, it will click the first match
                # to field_value by default. it does not select the element we
                # are actually looking for.
                option = world.browser.find_option_by_text(field_value)
            else:
                option = ele.find_by_value(field_value)

            option.click()

        return _this_step

    globals()["form_select_%s" % (finder_function,)] = _select_generator(finder_string, finder_function)

    def _fill_generator(finder_string, finder_function):
        @step(r'fill in the%s %s %s with "([^"]*)"' % (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, pick, find_pattern, text):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            try:
                ele.value = text
            except:
                ele._control.value = text

        return _this_step

    globals()["form_fill_%s" % (finder_function,)] = _fill_generator(finder_string, finder_function)

    def _fill_with_stored_generator(finder_string, finder_function):
        @step(r'fill in the%s %s %s with the stored value of "([^"]*)"' % (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, pick, find_pattern, name):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            assert(world.stored_values[name])
            ele.value = world.stored_values[name]

        return _this_step

    globals()["form_fill_with_stored_%s" % (finder_function,)] = _fill_with_stored_generator(finder_string, finder_function)

    def _attach_generator(finder_string, finder_function):
        @step(r'attach "([^"]*)" onto the%s %s %s' % (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, file_name, pick, find_pattern):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            ele.value = file_name

        return _this_step

    globals()["form_attach_%s" % (finder_function,)] = _attach_generator(finder_string, finder_function)

    def _focus_generator(finder_string, finder_function):
        @step(r'focus on the%s %s %s' % (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, pick, find_pattern):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            ele.focus()

        return _this_step

    globals()["form_focus_%s" % (finder_function,)] = _focus_generator(finder_string, finder_function)

    def _blur_generator(finder_string, finder_function):
        @step(r'(?:blur|move) from the%s %s %s' % (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, pick, find_pattern):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            ele.blur()

        return _this_step

    globals()["form_blur_%s" % (finder_function,)] = _blur_generator(finder_string, finder_function)

    def _value_generator(finder_string, finder_function):
        @step(r'should( not)? see that the (value|text|html|outer html) of the%s %s %s (is|contains) "([^"]*)"$' % (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, negate, attribute, pick, find_pattern, type_of_match, value):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            assert_value(type_of_match, value, getattr(ele, attribute.replace(' ', '_')), negate)

        return _this_step

    globals()["form_value_%s" % (finder_function,)] = _value_generator(finder_string, finder_function)

    def _see_stored_value_generator(finder_string, finder_function):
        @step(r'should( not)? see that the (value|text|html|outer html) of the%s %s %s (is|contains) the stored( lowercase| uppercase| case independent)? value of "([^"]*)"' % (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, negate, attribute, pick, find_pattern, type_of_match, upper_lower, name):
            current = getattr(
                _get_visible_element(finder_function, pick, find_pattern),
                attribute.replace(' ', '_'))

            assert world.stored_values[name]
            stored = world.stored_values[name]

            if upper_lower:
                stored, current = transform_for_upper_lower_comparison(stored, current, upper_lower)

            assert_value(type_of_match, stored, current, negate)

        return _this_step

    globals()["form_stored_value_%s" % (finder_function,)] = _see_stored_value_generator(finder_string, finder_function)

    def _key_generator(finder_string, finder_function):
        @step(r'hit the ([^"]*) key in the%s %s %s' % (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, key_string, pick, find_pattern):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            key = transform_key_string(key_string)
            ele.type(key)

        return _this_step

    globals()["form_key_%s" % (finder_function,)] = _key_generator(finder_string, finder_function)

    def _remember_generator(finder_string, finder_function):
        @step(r'(?:store|remember) the( lowercase| uppercase)? (text|value|html|outer html) of the%s %s %s as "([^"]+)"' % (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, upper_lower, what, pick, find_pattern, name):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            value = getattr(ele, what.replace(' ', '_'))
            store_with_case_option(name, value, upper_lower)

    globals()["form_remember_%s" % (finder_function,)] = _remember_generator(finder_string, finder_function)


@step(r'hit the ([^"]*) key')
def hit_key(step, key_string):
    key = transform_key_string(key_string)
    try:
        world.browser.driver.switch_to_active_element().send_keys(key)
    except StaleElementReferenceException:
        world.browser.find_by_css("body").type(key)


@step(r'(?:store|remember) a random( lowercase| uppercase)? (string|email|name)(?: of length (\d+))?(?: with suffix "([^"]*)")? as "([^"]*)"')
def store_value(step, upper_lower, type_of_fill, length, suffix, name):
    if not length:
        length = 9
    if not suffix:
        suffix = ""
    random_value = _generate_content(type_of_fill, int(length)) + suffix
    store_with_case_option(name, random_value, upper_lower)


def transform_key_string(key_string):
    key_string = key_string.upper().replace(' ', '_')
    if key_string == 'BACKSPACE':
        key_string = 'BACK_SPACE'
    elif key_string == 'SPACEBAR':
        key_string = 'SPACE'
    key = Keys.__getattribute__(Keys, key_string)
    return key


def _type_slowly(driver_ele, text):
    for c in text:
        driver_ele.value += c
        sleep(0.5)
