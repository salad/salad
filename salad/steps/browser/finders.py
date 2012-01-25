from lettuce import world
from salad.logger import logger
from splinter.exceptions import ElementDoesNotExist

ELEMENT_FINDERS = {
    'named "(.*)"': "find_by_name",
    'with(?: the)? id "(.*)"': "find_by_id",
    'with(?: the)? css selector "(.*)"': "find_by_css",
    'with(?: the)? value (.*)': "find_by_value",
}

LINK_FINDERS = {
    'to "(.*)"': "find_link_by_href",
    'to a url that contains "(.*)"': "find_link_by_partial_href",
    'with(?: the)? text "(.*)"': "find_link_by_text",
    'with text that contains "(.*)"': "find_link_by_partial_text",
}

ELEMENT_THING_STRING = "(?:element|thing|field|textarea|radio button|button|checkbox|label)"
LINK_THING_STRING = "link"


def _get_element(finder_function, first, last, pattern, expect_not_to_find=False, leave_in_list=False):

    ele = world.browser.__getattribute__(finder_function)(pattern)

    try:
        if first:
            ele = ele.first
        if last:
            ele = ele.last

        if len(ele) > 1:
            logger.warn("More than one element found when looking for %s for %s.  Using the first one. " % (finder_function, pattern))

        if not leave_in_list:
            ele = ele.first

    except ElementDoesNotExist:
            if not expect_not_to_find:
                logger.error("Element not found: %s for %s" % (finder_function, pattern))
            raise ElementDoesNotExist

    world.current_element = ele
    return ele


def _convert_pattern_to_css(finder_function, first, last, find_pattern, tag=""):
    pattern = ""
    if finder_function == "find_by_name":
        pattern += "%s[name='%s']" % (tag, find_pattern, )
    elif finder_function == "find_by_id":
        pattern += "#%s" % (find_pattern, )
    elif finder_function == "find_by_css":
        pattern += "%s" % (find_pattern, )
    elif finder_function == "find_by_value":
        pattern += "%s[value='%s']" % (tag, find_pattern, )  # makes no sense, but consistent.
    else:
        raise Exception("Unknown pattern.")

    if first:
        pattern += ":first"

    if last:
        pattern += ":last"

    return pattern
