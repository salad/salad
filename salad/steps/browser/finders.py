from lettuce import world
from salad.logger import logger
from salad.steps.parsers import pick_to_index
from splinter.exceptions import ElementDoesNotExist
from selenium.webdriver.support.wait import WebDriverWait
from selenium.common.exceptions import TimeoutException

ELEMENT_FINDERS = {
    'named "(.*)"': "find_by_name",
    'with(?: the)? id "(.*)"': "find_by_id",
    'with(?: the)? css selector "(.*)"': "find_by_css",
    'with(?: the)? value "(.*)"': "find_by_value",
}

LINK_FINDERS = {
    'to "(.*)"': "find_link_by_href",
    'to a url that contains "(.*)"': "find_link_by_partial_href",
    'with(?: the)? text "(.*)"': "find_link_by_text",
    'with text that contains "(.*)"': "find_link_by_partial_text",
}

ELEMENT_THING_STRING = "(?:element|thing|field|textarea|radio button|button|checkbox|label)"
LINK_THING_STRING = "link"

VISIBILITY_TIMEOUT = 1

def _get_visible_element(finder_function, pick, pattern, wait_time=VISIBILITY_TIMEOUT):
    element = _get_element(finder_function, pick, pattern)

    w = WebDriverWait(world.browser.driver, wait_time)
    try:
        w.until(lambda driver: element.visible)
    except TimeoutException as e:
        raise ElementDoesNotExist

    return element


def _get_element(finder_function, pick, pattern):
    ele = world.browser.__getattribute__(finder_function)(pattern)

    index = pick_to_index(pick)
    ele = ele[index]

    if not "WebDriverElement" in "%s" % type(ele):
        if len(ele) > 1:
            logger.warn("More than one element found when looking for %s for %s.  Using the first one. " % (finder_function, pattern))
        ele = ele.first

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
