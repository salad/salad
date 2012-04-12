from lettuce import step, world
from salad.tests.util import assert_equals_with_negate, assert_with_negate, parsed_negator
from salad.steps.browser.finders import ELEMENT_FINDERS, ELEMENT_THING_STRING, _get_element
from splinter.exceptions import ElementDoesNotExist

# Find and verify that elements exist, have the expected content and attributes (text, classes, ids)


@step(r'should( not)? see "(.*)" (?:somewhere|anywhere) in (?:the|this) page')
def should_see_in_the_page(step, negate, text):
    assert_with_negate(text in world.browser.html, negate)


@step(r'should( not)? see a link (?:called|with the text) "(.*)"')
def should_see_a_link_called(step, negate, text):
    assert_with_negate(len(world.browser.find_link_by_text(text)) > 0, negate)


@step(r'should( not)? see a link to "(.*)"')
def should_see_a_link_to(step, negate, link):
    assert_with_negate(len(world.browser.find_link_by_href(link)) > 0, negate)

for finder_string, finder_function in ELEMENT_FINDERS.iteritems():
    def _visible_generator(finder_string, finder_function):
        @step(r'should( not)? see (?:the|a|an)( first)?( last)? %s %s' % (ELEMENT_THING_STRING, finder_string))
        def _this_step(step, negate, first, last, find_pattern):
            try:
                _get_element(finder_function, first, last, find_pattern, expect_not_to_find=True)
            except ElementDoesNotExist:
                assert parsed_negator(negate)

        return _this_step

    globals()["form_visible_%s" % (finder_function,)] = _visible_generator(finder_string, finder_function)

    def _contains_generator(finder_string, finder_function):
        @step(r'should( not)? see that the( first)?( last)? %s %s contains? "(.*)"' % (ELEMENT_THING_STRING, finder_string))
        def _this_step(step, negate, first, last, find_pattern, content):
            ele = _get_element(finder_function, first, last, find_pattern)
            print ele.text
            print "foo"
            assert_with_negate(content in ele.text, negate)

        return _this_step

    globals()["form_contains_%s" % (finder_function,)] = _contains_generator(finder_string, finder_function)

    def _is_exactly_generator(finder_string, finder_function):
        @step(r'should( not)? see that the( first)?( last)? %s %s (?:is|contains) exactly "(.*)"' % (ELEMENT_THING_STRING, finder_string))
        def _this_step(step, negate, first, last, find_pattern, content):
            ele = _get_element(finder_function, first, last, find_pattern)
            assert_equals_with_negate(ele.text, content, negate)

        return _this_step

    globals()["form_exactly_%s" % (finder_function,)] = _is_exactly_generator(finder_string, finder_function)

    def _attribute_value_generator(finder_string, finder_function):
        @step(r'should( not)? see that the( first)?( last)? %s %s has (?:an|the) attribute (?:of|named|called) "(.*)" with(?: the)? value "(.*)"' % (ELEMENT_THING_STRING, finder_string))
        def _this_step(step, negate, first, last, find_pattern, attr_name, attr_value):
            ele = _get_element(finder_function, first, last, find_pattern)
            assert_equals_with_negate("%s" % ele[attr_name], attr_value, negate)

        return _this_step

    globals()["form_attribute_value_%s" % (finder_function,)] = _attribute_value_generator(finder_string, finder_function)

    def _attribute_generator(finder_string, finder_function):
        @step(r'should( not)? see that the( first)?( last)? %s %s has (?:an|the) attribute (?:of|named|called) "(\w*)"$' % (ELEMENT_THING_STRING, finder_string))
        def _this_step(step, negate, first, last, find_pattern, attr_name):
            ele = _get_element(finder_function, first, last, find_pattern)
            print ele
            print attr_name
            print ele[attr_name]
            assert_with_negate(ele[attr_name] != None, negate)

        return _this_step

    globals()["form_attribute_%s" % (finder_function,)] = _attribute_generator(finder_string, finder_function)
