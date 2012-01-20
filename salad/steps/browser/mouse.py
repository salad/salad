from lettuce import step, world
from nose.tools import assert_equals
from salad.logger import logger
from splinter.exceptions import ElementDoesNotExist

# Click on things, mouse over, move the mouse around.

# General syntax:
# <action> the (first|last) <thing> <find clause>
#
# <action> can be:
# click on
# mouse over / mouseover
# mouse out / mouseout
# (double click / double-click / doubleclick) on
# (right click / right-click / rightclick) on
#
# <thing> can be:
# element
# link (searches for <A hrefs>)
# thing
#
# <find clause> can be
# named "foo"
# with the id "foo"
# with the css selector ""
# to "http://www.google.com" (links only)
# to a url that contains ".google.com" (links only)
# with the text "foo"
# with text that contains "foo"


# What's happening here? We're generating steps for every possible permutation
# of the actions and the finders below.

actions = {
    "click(?: on)?": "click",
    "(?: mouse over|mouse-over|mouseover)": "mouse_over",
    "(?: mouse out|mouse-out|mouseout)": "mouse_out",
    "(?: double click|double-click|doubleclick)": "double_click",
    "(?: right click|right-click|rightclick)": "right_click",
}

finders = {
    'named "(.*)"': "find_by_name",
    'with(?: the)? id "(.*)"': "find_by_id",
    'with(?: the)? css selector "(.*)"': "find_by_css",
}

link_finders = {
    'to "(.*)"': "find_link_by_href",
    'to a url that contains "(.*)"': "find_link_by_partial_href",
    'with(?: the)? text "(.*)"': "find_link_by_text",
    'with text that contains "(.*)"': "find_link_by_partial_text",
}

element_thing_string = "(?:element|thing)"
link_thing_string = "link"


def step_generator(action_string, action_function, thing_string, finder_string, finder_function):

    @step(r'%s the( first)?( last)? %s %s' % (action_string, thing_string, finder_string))
    def _this_step(step, first, last, find_pattern):
        ele = world.browser.__getattribute__(finder_function)(find_pattern)
        try:
            if first:
                ele = ele.first
            if last:
                ele = ele.last

            if len(ele) > 1:
                logger.warn("More than one element found when looking for %s for %s.  Using the first one. " % (finder_string, find_pattern))

            ele = ele.first

        except ElementDoesNotExist:
                logger.error("Element not found: %s for %s" % (finder_string, find_pattern))
                raise ElementDoesNotExist

        ele.__getattribute__(action_function)()

    return _this_step

for action_string, action_function in actions.iteritems():
    for finder_string, finder_function in finders.iteritems():
        globals()["element_%s_%s" % (action_function, finder_function)] = step_generator(action_string,
                                                                                        action_function,
                                                                                        element_thing_string,
                                                                                        finder_string,
                                                                                        finder_function
                                                                                        )


for action_string, action_function in actions.iteritems():
    for finder_string, finder_function in link_finders.iteritems():
        globals()["element_%s_%s" % (action_function, finder_function)] = step_generator(action_string,
                                                                                        action_function,
                                                                                        link_thing_string,
                                                                                        finder_string,
                                                                                        finder_function
                                                                                        )
