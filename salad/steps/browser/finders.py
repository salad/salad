from lettuce import world

from salad.logger import logger
from salad.steps.parsers import pick_to_index
from salad.exceptions import ElementDoesNotExist, ElementIsNotVisible, \
    ElementAtIndexDoesNotExist


ELEMENT_FINDERS = {
    'named "([^"]*)"': "find_by_name",
    'with(?: the)? id "([^"]*)"': "find_by_id",
    'with(?: the)? css selector "([^"]*)"': "find_by_css",
    'with(?: the)? value "([^"]*)"': "find_by_value",
    'with(?: the)? xpath "([^"]*)"': "find_by_xpath",
}

LINK_FINDERS = {
    'to(?: the url)? "([^"]*)"': "find_link_by_href",
    'to a url that contains "([^"]*)"': "find_link_by_partial_href",
    'with(?: the)? text "([^"]*)"': "find_link_by_text",
    'with text that contains "([^"]*)"': "find_link_by_partial_text",
}

ELEMENT_THING_STRING = "(?:element|thing|field|textarea|radio button|button|checkbox|label)"
LINK_THING_STRING = "link"
PICK_EXPRESSION = "( first| last| \d+..)?"


def _get_visible_element(finder_function, pick, pattern):
    element = _get_element(finder_function, pick, pattern)
    if not element.is_displayed():
        raise ElementIsNotVisible("The element exist, but it is not visible."
                                  "function: %s, pattern: %s, index: %s" %
                                  (finder_function, pattern, pick))
    return element


def _get_element(finder_function, pick, pattern):
    ele = world.browser.__getattribute__(finder_function)(pattern)
    if not ele:
        raise ElementDoesNotExist("function: %s, pattern: %s, index: %s" %
                                  (finder_function, pattern, pick))

    index = pick_to_index(pick)
    try:
        ele = ele[index]
    except IndexError:
        raise ElementAtIndexDoesNotExist("There are elements that match "
                                         "your search, but the index is out "
                                         "of range.\nfunction: %s, pattern: "
                                         "%s, index: %s" %
                                         (finder_function, pattern, pick))

    world.current_element = ele
    return ele
