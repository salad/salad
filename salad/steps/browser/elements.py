from lettuce import step, world
from salad.tests.util import assert_equals_with_negate, assert_with_negate, parsed_negator
from salad.steps.browser.finders import ELEMENT_FINDERS, ELEMENT_THING_STRING, _get_visible_element
from splinter.exceptions import ElementDoesNotExist
from selenium.webdriver.support.wait import WebDriverWait

# Find and verify that elements exist, have the expected content and attributes (text, classes, ids)
@step(r'should( not)? see "(.*)" (?:somewhere|anywhere) in (?:the|this) page(?: within (\d+) seconds)?')
def should_see_in_the_page(step, negate, text, wait_time):
    def assert_text_present_with_negates(negate, text):
        assert_with_negate(world.browser.is_text_present(text), negate)

    wait_for_completion(wait_time, assert_text_present_with_negates, negate, text)


def wait_for_completion(wait_time, method, *args):
    wait_time = int(wait_time or 0)
    waiter = WebDriverWait(None, wait_time, ignored_exceptions=AssertionError)
    done_test = lambda x: method(*args) is None
    waiter.until(done_test)


@step(r'should( not)? see (?:the|a) link (?:called|with the text) "(.*)"(?: within (\d+) seconds)?')
def should_see_a_link_called(step, negate, text, wait_time):
    def assert_link_exists_negates(negate, text):
        assert_with_negate(len(world.browser.find_link_by_text(text)) > 0, negate)

    wait_for_completion(wait_time, assert_link_exists_negates, negate, text)


@step(r'should( not)? see (?:the|a) link to "(.*)"(?: within (\d+) seconds)?')
def should_see_a_link_to(step, negate, link, wait_time):
    def assert_link_exists_negates(negate, text):
        assert_with_negate(len(world.browser.find_link_by_href(text)) > 0, negate)

    wait_for_completion(wait_time, assert_link_exists_negates, negate, link)


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
        self.step_pattern = self.pattern + '(?: within (\d+) seconds)?'
        @step(self.step_pattern % (ELEMENT_THING_STRING, finder_string))
        def _polling_assertion_step(step, negate, pick, find_pattern, *args):
            wait_time = int(args[-1] or 0)
            args = args[:-1]  # Chop off the wait_time arg

            def check_element():
                try:
                    element = _get_visible_element(finder_function, pick,
                            find_pattern, wait_time=wait_time)
                except ElementDoesNotExist:
                    assert parsed_negator(negate)
                    element = None
                self.test(element, negate, *args)

            waiter = WebDriverWait(None, wait_time,
                                   ignored_exceptions=AssertionError)
            done_test = lambda x: check_element() is None
            waiter.until(done_test)


visibility_pattern = r'should( not)? see (?:the|a|an)( first| last)? %s %s'
def visibility_test(element, negate, *args):
    assert_with_negate(element, negate)


contains_pattern = r'should( not)? see that the( first| last)? %s %s contains "(.*)"'
def contains_test(element, negate, *args):
    content = args[0]
    text = getattr(element, 'text', None)
    assert_with_negate(content in text, negate)


contains_exactly_pattern = r'should( not)? see that the( first| last)? %s %s (?:is|contains) exactly "(.*)"'
def contains_exactly_test(element, negate, *args):
    content = args[0]
    text = getattr(element, 'text', None)
    assert_equals_with_negate(content, text, negate)

attribute_pattern = r'should( not)? see that the( first| last)? %s %s has (?:an|the) attribute (?:of|named|called) "(\w*)"$'
def attribute_test(element, negate, *args):
    attribute = args[0]
    assert_with_negate(element[attribute] != None, negate)

attribute_value_pattern = r'should( not)? see that the( first| last)? %s %s has (?:an|the) attribute (?:of|named|called) "(.*)" with(?: the)? value "(.*)"'
def attribute_value_test(element, negate, *args):
    attribute = args[0]
    value = args[1]
    assert_equals_with_negate(element[attribute], value, negate)

ExistenceStepsFactory(ELEMENT_FINDERS, visibility_pattern, visibility_test)
ExistenceStepsFactory(ELEMENT_FINDERS, contains_pattern, contains_test)
ExistenceStepsFactory(ELEMENT_FINDERS, contains_exactly_pattern, contains_exactly_test)
ExistenceStepsFactory(ELEMENT_FINDERS, attribute_pattern, attribute_test)
ExistenceStepsFactory(ELEMENT_FINDERS, attribute_value_pattern, attribute_value_test)
