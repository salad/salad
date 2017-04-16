from time import sleep

from lettuce import step, world
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.remote.errorhandler import \
    StaleElementReferenceException
from selenium.webdriver.support.ui import Select

from salad.steps.browser.finders import (
    PICK_EXPRESSION,
    ELEMENT_FINDERS,
    ELEMENT_THING_STRING,
    _get_visible_element
)
from salad.tests.util import (
    assert_equals_with_negate,
    assert_with_negate,
    assert_value,
    store_with_case_option,
    transform_for_upper_lower_comparison,
    wait_for_completion,
    generate_content
)

# What's happening here? We're generating steps for every possible
# permuation of the element finder

world.stored_values = dict()


for finder_string, finder_function in ELEMENT_FINDERS.items():

    def _type_generator(finder_string, finder_function):
        @step(r'(slowly )?type "([^"]*)" into the%s %s %s$' %
              (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, slowly, text, pick, find_pattern):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            if slowly and slowly != "":
                _type_slowly(ele, text)
            else:
                ele.send_keys(text)

        return _this_step

    globals()["form_type_%s" % (finder_function,)] = (
        _type_generator(finder_string, finder_function))

    def _deselect_generator(finder_string, finder_function):
        @step(r'deselect all options from the%s %s %s$' %
              (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _deselect_function(step, pick, find_pattern):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            select = Select(ele)
            select.deselect_all()

        return _deselect_function

    globals()["form_deselect_%s" % (finder_function,)] = (
        _deselect_generator(finder_string, finder_function))

    def _select_generator(finder_string, finder_function):
        @step(r'(de)?select the option with the (index|value|text)'
              '( that is the stored value of)? "([^"]+)" '
              'from the%s %s %s$' %
              (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _select_function(step, negate, by_what, stored, value, pick,
                             find_pattern):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            select = Select(ele)
            # get value from storage if necessary
            if stored:
                value = world.stored_values[value]
            # adjust variables for proper Select usage
            if by_what == 'text':
                by_what = 'visible_text'
            elif by_what == 'index':
                value = int(value)
            # select or deselect according to negate
            attribute_mask = 'deselect_by_%s' if negate else 'select_by_%s'
            # get the method
            select_method = getattr(select, attribute_mask % (by_what, ))
            # select the correct option
            select_method(value)

        return _select_function

    globals()["form_select_%s" % (finder_function,)] = (
        _select_generator(finder_string, finder_function))

    def _fill_generator(finder_string, finder_function):
        @step(r'fill in the%s %s %s with "([^"]*)"$' %
              (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, pick, find_pattern, text):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            _fill_in_text(ele, text)

        return _this_step

    globals()["form_fill_%s" % (finder_function,)] = (
        _fill_generator(finder_string, finder_function))

    def _fill_with_stored_generator(finder_string, finder_function):
        @step(r'fill in the%s %s %s with the stored value of "([^"]*)"$' %
              (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, pick, find_pattern, name):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            assert(world.stored_values[name])
            _fill_in_text(ele, world.stored_values[name])

        return _this_step

    globals()["form_fill_with_stored_%s" % (finder_function,)] = (
        _fill_with_stored_generator(finder_string, finder_function))

    def _attach_generator(finder_string, finder_function):
        @step(r'attach "([^"]*)" onto the%s %s %s$' %
              (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, file_name, pick, find_pattern):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            _fill_in_text(ele, file_name)

        return _this_step

    globals()["form_attach_%s" % (finder_function,)] = (
        _attach_generator(finder_string, finder_function))

    def _focus_generator(finder_string, finder_function):
        """
           the selenium support for focus on and blur from is limited
           and does not work properly.
           so instead of focusing on, we will click on the element
        """
        @step(r'focus on the%s %s %s$' %
              (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, pick, find_pattern):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            ele.click()

        return _this_step

    globals()["form_focus_%s" % (finder_function,)] = (
        _focus_generator(finder_string, finder_function))

    def _blur_generator(finder_string, finder_function):
        """
           the selenium support for focus on and blur from is limited
           and does not work properly.
           so instead of blurring from the element, we will click on the body
        """
        @step(r'(?:blur|move) from the%s %s %s$' %
              (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, pick, find_pattern):
            # make sure the element is visible anyway
            ele = _get_visible_element(finder_function, pick, find_pattern)
            # then click on the body of the html document
            ele = _get_visible_element('find_by_tag', None, "body")
            ele.click()

        return _this_step

    globals()["form_blur_%s" % (finder_function,)] = (
        _blur_generator(finder_string, finder_function))

    def _value_generator(finder_string, finder_function):
        @step(r'should( not)? see that the (value|text|html|outer html) of '
              'the%s %s %s (is|contains) "([^"]*)"'
              '(?: within (\d+) seconds)?$' %
              (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, negate, attribute, pick, find_pattern,
                       type_of_match, value, wait_time):
            def assert_element_attribute_is_or_contains_text(
                    negate, attribute, pick, find_pattern,
                    type_of_match, value):
                ele_value = _get_attribute_of_element(
                    finder_function, pick, find_pattern, attribute)
                assert_value(type_of_match, value, ele_value, negate)
                return True
            wait_for_completion(
                wait_time, assert_element_attribute_is_or_contains_text,
                negate, attribute, pick, find_pattern, type_of_match, value)

        return _this_step

    globals()["form_value_%s" % (finder_function,)] = (
        _value_generator(finder_string, finder_function))

    def _see_stored_value_generator(finder_string, finder_function):
        @step(r'should( not)? see that the (value|text|html|outer html) of '
              'the%s %s %s (is|contains) the stored( lowercase| uppercase| '
              'case independent)? value of "([^"]*)"'
              '(?: within (\d+) seconds)?$' %
              (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, negate, attribute, pick, find_pattern,
                       type_of_match, upper_lower, name, wait_time):
            def assert_element_attribute_is_or_contains_stored_value(
                    negate, attribute, pick, find_pattern, type_of_match,
                    upper_lower, name):
                current = _get_attribute_of_element(
                    finder_function, pick, find_pattern, attribute)
                stored = world.stored_values[name]
                if upper_lower:
                    stored, current = transform_for_upper_lower_comparison(
                        stored, current, upper_lower)
                assert_value(type_of_match, stored, current, negate)
                return True
            wait_for_completion(
                wait_time,
                assert_element_attribute_is_or_contains_stored_value, negate,
                attribute, pick, find_pattern, type_of_match, upper_lower,
                name)

        return _this_step

    globals()["form_stored_value_%s" % (finder_function,)] = (
        _see_stored_value_generator(finder_string, finder_function))

    def _key_generator(finder_string, finder_function):
        @step(r'hit the ([^"]*) key in the%s %s %s$' %
              (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, key_string, pick, find_pattern):
            ele = _get_visible_element(finder_function, pick, find_pattern)
            key = transform_key_string(key_string)
            ele.send_keys(key)

        return _this_step

    globals()["form_key_%s" % (finder_function,)] = (
        _key_generator(finder_string, finder_function))

    def _remember_generator(finder_string, finder_function):
        @step(r'(?:store|remember) the( lowercase| uppercase)? '
              '(text|value|html|outer html) of the%s %s %s as "([^"]+)"$' %
              (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _this_step(step, upper_lower, what, pick, find_pattern, name):
            ele_value = _get_attribute_of_element(
                finder_function, pick, find_pattern, what)
            store_with_case_option(name, ele_value, upper_lower)

    globals()["form_remember_%s" % (finder_function,)] = (
        _remember_generator(finder_string, finder_function))


@step(r'hit the ([^"]*) key')
def hit_key(step, key_string):
    key = transform_key_string(key_string)
    try:
        world.browser.driver.switch_to_active_element().send_keys(key)
    except StaleElementReferenceException:
        world.browser.find_by_css("body").type(key)


@step(r'(?:store|remember) a random( lowercase| uppercase)? '
      '(string|email|name)(?: of length (\d+))?(?: with suffix "([^"]*)")? '
      'as "([^"]*)"$')
def store_value(step, upper_lower, type_of_fill, length, suffix, name):
    if not length:
        length = 9
    if not suffix:
        suffix = ""
    random_value = generate_content(type_of_fill, int(length)) + suffix
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
        driver_ele.send_keys(c)
        sleep(0.3)


def _fill_in_text(ele, text):
    if ele.get_attribute('type') != 'file':
        ele.clear()
    ele.send_keys(text)


def _get_attribute_of_element(finder_function, pick, find_pattern, attribute):
    ele = _get_visible_element(finder_function, pick, find_pattern)
    if attribute == 'text':
        return ele.text
    elif attribute == 'outer html':
        return ele.get_attribute('outerHTML')
    elif attribute == 'html':
        return ele.get_attribute('innerHTML')
    else:
        return ele.get_attribute(attribute)
