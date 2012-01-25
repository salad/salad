from lettuce import step, world
from splinter.driver.webdriver import TypeIterator
from selenium.webdriver.remote.errorhandler import StaleElementReferenceException
from salad.steps.browser.finders import ELEMENT_FINDERS, ELEMENT_THING_STRING, _get_element, _convert_pattern_to_css
from salad.tests.util import assert_equals_with_negate

# What's happening here? We're generating steps for every possible permuation of the element finder

for finder_string, finder_function in ELEMENT_FINDERS.iteritems():

    def _fill_generator(finder_string, finder_function):
        @step(r'fill in the( first)?( last)? %s %s with "(.*)"' % (ELEMENT_THING_STRING, finder_string))
        def _this_step(step, first, last, find_pattern, text):
            ele = _get_element(finder_function, first, last, find_pattern)
            try:
                ele.value = text
            except:
                ele._control.value = text

        return _this_step

    globals()["form_fill_%s" % (finder_function,)] = _fill_generator(finder_string, finder_function)

    def _type_generator(finder_string, finder_function):
        @step(r'(slowly )?type "(.*)" into the( first)?( last)? %s %s' % (ELEMENT_THING_STRING, finder_string))
        def _this_step(step, slowly, text, first, last, find_pattern):
            css = _convert_pattern_to_css(finder_function, first, last, find_pattern)

            driver_ele = world.browser.driver.find_element_by_css_selector(css)
            slowly = False
            if slowly and slowly != "":
                TypeIterator(driver_ele, text)
            else:
                driver_ele.send_keys(text)

        return _this_step

    globals()["form_type_%s" % (finder_function,)] = _type_generator(finder_string, finder_function)

    def _attach_generator(finder_string, finder_function):
        @step(r'attach "(.*)" onto the( first)?( last)? %s %s' % (ELEMENT_THING_STRING, finder_string))
        def _this_step(step, file_name, first, last, find_pattern):
            ele = _get_element(finder_function, first, last, find_pattern)
            try:
                ele.value = file_name
            except:
                ele._control.value = file_name

        return _this_step

    globals()["form_attach_%s" % (finder_function,)] = _attach_generator(finder_string, finder_function)

    def _select_generator(finder_string, finder_function):
        @step(r'select the option (named|with the value)? "(.*)" (?:from|in) the( first)?( last)? %s %s' % (ELEMENT_THING_STRING, finder_string))
        def _this_step(step, named_or_with_value, field_value, first, last, find_pattern):
            css = _convert_pattern_to_css(finder_function, first, last, find_pattern, tag="select")

            if named_or_with_value == "with the value":
                css += " option[value='%s']" % (field_value,)
                ele = world.browser.find_by_css(css).first
            else:
                ele = world.browser.find_option_by_text(field_value)

            ele.click()

        return _this_step

    globals()["form_select_%s" % (finder_function,)] = _select_generator(finder_string, finder_function)

    def _focus_generator(finder_string, finder_function):
        @step(r'focus on the( first)?( last)? %s %s' % (ELEMENT_THING_STRING, finder_string))
        def _this_step(step, first, last, find_pattern):
            ele = _get_element(finder_function, first, last, find_pattern)
            ele.focus()

        return _this_step

    globals()["form_focus_%s" % (finder_function,)] = _focus_generator(finder_string, finder_function)

    def _blur_generator(finder_string, finder_function):
        @step(r'(?:blur|move) from the( first)?( last)? %s %s' % (ELEMENT_THING_STRING, finder_string))
        def _this_step(step, first, last, find_pattern):
            ele = _get_element(finder_function, first, last, find_pattern)
            ele.blur()

        return _this_step

    globals()["form_blur_%s" % (finder_function,)] = _blur_generator(finder_string, finder_function)

    def _value_generator(finder_string, finder_function):
        @step(r'(?:should see that the)? value of the( first)?( last)? %s %s is( not)? "(.*)"' % (ELEMENT_THING_STRING, finder_string))
        def _this_step(step, first, last, find_pattern, negate, value):
            ele = _get_element(finder_function, first, last, find_pattern)
            assert_equals_with_negate(ele.value, value, negate)

        return _this_step

    globals()["form_value_%s" % (finder_function,)] = _value_generator(finder_string, finder_function)

    def _enter_generator(finder_string, finder_function):
        @step(r'hit enter in the ( first)?( last)? %s %s' % (ELEMENT_THING_STRING, finder_string))
        def _this_step(step, first, last, find_pattern):
            ele = _get_element(finder_function, first, last, find_pattern)
            ele.type("\n")

        return _this_step

    globals()["form_enter_%s" % (finder_function,)] = _enter_generator(finder_string, finder_function)


@step(r'hit enter')
def hit_enter(step):
    try:
        world.current_element._element.send_keys("\n")
    except StaleElementReferenceException:
        world.browser.find_by_css("body").type("\n")
