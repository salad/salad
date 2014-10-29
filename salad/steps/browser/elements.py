from lettuce import step, world

from salad.exceptions import (
    ElementDoesNotExist,
    ElementIsNotVisible,
    ElementAtIndexDoesNotExist
)
from salad.logger import logger
from salad.steps.browser.finders import (
    PICK_EXPRESSION,
    ELEMENT_FINDERS,
    ELEMENT_THING_STRING,
    _get_visible_element
)
from salad.tests.util import (
    assert_equals_with_negate,
    assert_with_negate,
    parsed_negator,
    wait_for_completion
)
from salad.waiter import SaladWaiter
from salad.waiter import TimeoutException

# Find and verify that elements exist, have the expected content
# and attributes (text, classes, ids)


# the following steps do not use the ExistenceStepsFactory
@step(r'should( not)? see "([^"]*)" (?:somewhere|anywhere) in (?:the|this) '
      'page(?: within (\d+) seconds)?$')
def should_see_in_the_page(step, negate, text, wait_time):
    def assert_text_present_with_negates(negate, text):
        body = world.browser.driver.find_element_by_tag_name('body')
        assert_with_negate(text in body.text, negate)
        return True

    wait_for_completion(wait_time, assert_text_present_with_negates, negate,
                        text)


def assert_element_exists_with_negate(negate, text, partial, function):
    infix = "partial_" if partial else ""
    found = True
    try:
        _get_visible_element(function % (infix, ), None, text)
    except (ElementDoesNotExist, ElementIsNotVisible,
            ElementAtIndexDoesNotExist):
        found = False
    assert_with_negate(found, negate)
    return True


@step(r'should( not)? see (?:the|a) link with (?:the partial text|text '
      'that contains) "([^"]*)"(?: within (\d+) seconds)?$')
def should_see_a_link_with_partial_text(step, negate, text, wait_time):
    wait_for_completion(wait_time, assert_element_exists_with_negate, negate,
                        text, "partial", "find_link_by_%stext")


@step(r'should( not)? see (?:the|a) link (?:called|with the text) "([^"]*)"'
      '(?: within (\d+) seconds)?$')
def should_see_a_link_called(step, negate, text, wait_time):
    wait_for_completion(wait_time, assert_element_exists_with_negate, negate,
                        text, None, "find_link_by_%stext")


@step(r'should( not)? see (?:the|a) link to( the partial url| a url that contains)? "([^"]*)"'
      '(?: within (\d+) seconds)?$')
def should_see_a_link_to(step, negate, partial, text, wait_time):
    wait_for_completion(wait_time, assert_element_exists_with_negate, negate,
                        text, partial, "find_by_%shref")


class ExistenceStepsFactory(object):
    def __init__(self, finders, step_pattern, test_function):
        self.finders = finders
        self.pattern = step_pattern
        self.test = test_function
        self.make_steps()

    def make_steps(self):
        for finder_string, finder_function in self.finders.iteritems():
            self.make_step(finder_string, finder_function)

    def make_step(self, finder_string, finder_function):
        self.step_pattern = self.pattern + '(?: within (\d+) seconds)?$'

        @step(self.step_pattern % (PICK_EXPRESSION, ELEMENT_THING_STRING, finder_string))
        def _polling_assertion_step(step, negate, pick, find_pattern, *args):
            wait_time = int(args[-1] or 0)
            args = args[:-1]  # Chop off the wait_time arg

            waiter = SaladWaiter(wait_time, ignored_exceptions=AssertionError)
            try:
                waiter.until(self.check_element, finder_function,
                             negate, pick, find_pattern, wait_time, *args)
            except TimeoutException as t:
                # BEWARE: only way to get step regular expression
                expression, func = step._get_match(True)
                logger.error(t.message)
                logger.error("Encountered error using definition '%s'" %
                             expression.re.pattern)
                message = ("Element not found or assertion failed using "
                           "pattern '%s' after %s seconds" %
                           (find_pattern, wait_time))
                raise AssertionError(message)
            except Exception as error:
                # BEWARE: only way to get step regular expression
                expression, func = step._get_match(True)
                logger.error("%s" % error)
                logger.error("Encountered error using definition '%s'" %
                             expression.re.pattern)
                raise

    def check_element(self, finder_function, negate, pick,
                      find_pattern, wait_time, *args):
        try:
            element = _get_visible_element(finder_function, pick, find_pattern)
        except (ElementDoesNotExist, ElementIsNotVisible,
                ElementAtIndexDoesNotExist):
            assert parsed_negator(negate)
            element = None
        self.test(element, negate, *args)
        return True


visibility_pattern = r'should( not)? see (?:the|a|an)%s %s %s'
def visibility_test(element, negate, *args):
    assert_with_negate(element, negate)


contains_pattern = (r'should( not)? see that the%s %s %s (?:has|contains)'
                    '(?: the text)? "([^"]*)"')
def contains_test(element, negate, *args):
    content = args[0]
    text = getattr(element, 'text', None)
    assert_with_negate(content in text, negate)


contains_exactly_pattern = (r'should( not)? see that the%s %s %s '
                            '(?:is|contains) exactly "([^"]*)"')
def contains_exactly_test(element, negate, *args):
    content = args[0]
    text = getattr(element, 'text', None)
    assert_equals_with_negate(content, text, negate)


attribute_pattern = (r'should( not)? see that the%s %s %s has (?:an|the) '
                     'attribute (?:of|named|called) "(\w*)"')
def attribute_test(element, negate, *args):
    attribute = args[0]
    assert_with_negate(element.get_attribute(attribute) is not None, negate)


attribute_value_pattern = (r'should( not)? see that the%s %s %s has '
                           '(?:an|the) attribute (?:of|named|called) '
                           '"([^"]*)" with(?: the)? value "([^"]*)"')
def attribute_value_test(element, negate, *args):
    attribute = args[0]
    value = args[1]
    assert_equals_with_negate(element.get_attribute(attribute), value, negate)


ExistenceStepsFactory(ELEMENT_FINDERS, visibility_pattern, visibility_test)
ExistenceStepsFactory(ELEMENT_FINDERS, contains_pattern, contains_test)
ExistenceStepsFactory(ELEMENT_FINDERS, contains_exactly_pattern, contains_exactly_test)
ExistenceStepsFactory(ELEMENT_FINDERS, attribute_pattern, attribute_test)
ExistenceStepsFactory(ELEMENT_FINDERS, attribute_value_pattern, attribute_value_test)
