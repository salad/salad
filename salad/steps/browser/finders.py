from lettuce import world

from salad.logger import logger
from salad.steps.parsers import pick_to_index
from salad.exceptions import (
    ElementDoesNotExist,
    ElementIsNotVisible,
    ElementAtIndexDoesNotExist
)


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

FINDER_ASSOCIATION = {
    "find_by_name": "find_elements_by_name",
    "find_by_id": "find_elements_by_id",
    "find_by_css": "find_elements_by_css_selector",
    "find_by_xpath": "find_elements_by_xpath",
    "find_by_tag": "find_elements_by_tag_name",
    "find_link_by_text": "find_elements_by_link_text",
    "find_link_by_partial_text": "find_elements_by_partial_link_text",
}
PATTERN_ASSOCIATION = {
    "by_value": "[value='%s']",
    "by_partial_href": "a[href*='%s']",
    "by_href": "a[href='%s']"
}


def _get_visible_element(finder_function, pick, pattern):
    element = _get_element(finder_function, pick, pattern)
    if not element:
        exception, msg = world.failure
        raise exception(msg)
    if not element.is_displayed():
        raise ElementIsNotVisible("The element exist, but it is not visible. "
                                  "function: %s, pattern: %s, index: %s" %
                                  (finder_function, pattern, pick))
    return element


def _get_element(finder_function, pick, pattern):
    # to support the splinter legacy functions
    legacy_functions = ['by_value', 'by_partial_href', 'by_href']
    for lf in legacy_functions:
        if lf in finder_function:
            finder_function = "find_by_css"
            pattern = PATTERN_ASSOCIATION[lf] % (pattern, )

    finder_function = FINDER_ASSOCIATION[finder_function]
    element = world.browser.driver.__getattribute__(finder_function)(pattern)
    if not element:
        msg = ("function: %s, pattern: %s, index: %s" %
               (finder_function, pattern, pick))
        world.failure = (ElementDoesNotExist, msg)
        return None

    index = pick_to_index(pick)
    try:
        element = element[index]
    except IndexError:
        msg = ("There are elements that match your search, but the index is "
               "out of range.\nfunction: %s, pattern: %s, index: %s" %
               (finder_function, pattern, pick))
        world.failure = (ElementAtIndexDoesNotExist, msg)
        return None

    world.current_element = element
    return element
