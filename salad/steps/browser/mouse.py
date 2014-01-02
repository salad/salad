from lettuce import step
from salad.steps.browser.finders import (ELEMENT_FINDERS, LINK_FINDERS,
        ELEMENT_THING_STRING, LINK_THING_STRING, PICK_EXPRESSION,
        _get_visible_element)


# Click on things, mouse over, move the mouse around.

# General syntax:
# <action> the <how-many-eth> <thing> <find clause>
#
# <action> can be:
# click on
# mouse over / mouseover
# mouse out / mouseout
# (double click / double-click / doubleclick) on
# (right click / right-click / rightclick) on
#
# <how-many-eth> can be:
# empty or first, last, 1st, 2nd, 3rd, 4th, 5th, ..
#
# <thing> can be:
# element
# link (searches for <A hrefs>)
# thing
#
# <find clause> for any page element can be:
# named "foo"
# with the id "foo"
# with the css selector ""
#
# <find clause> for links can be
# to "http://www.google.com"
# to a url that contains ".google.com"
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


def step_generator(action_string, action_function, thing_string, finder_string, finder_function):

    @step(r'%s (?:a|the)%s %s %s' % (action_string, PICK_EXPRESSION, thing_string, finder_string))
    def _this_step(step, pick, find_pattern):
        ele = _get_visible_element(finder_function, pick, find_pattern)

        ele.__getattribute__(action_function)()

    return _this_step


def drag_and_drop_generator(thing_string, finder_string_from, finder_string_to,
        finder_function_from, finder_function_to):

    @step(r'drag the%s %s %s and drop it on the%s %s %s' % (
                PICK_EXPRESSION, thing_string, finder_string_from,
                PICK_EXPRESSION, thing_string, finder_string_to
                                                           )
         )
    def _this_step(step, handler_pick, drag_handler_pattern, target_pick, drag_target_pattern):
        handler = _get_visible_element(finder_function_from, handler_pick, drag_handler_pattern)
        target = _get_visible_element(finder_function_to, target_pick, drag_target_pattern)

        handler.drag_and_drop(target)

    return _this_step


for action_string, action_function in actions.iteritems():
    for finder_string, finder_function in ELEMENT_FINDERS.iteritems():
        globals()["element_%s_%s" % (action_function, finder_function)] = step_generator( action_string,
                                                                                          action_function,
                                                                                          ELEMENT_THING_STRING,
                                                                                          finder_string,
                                                                                          finder_function
                                                                                         )

    for finder_string, finder_function in LINK_FINDERS.iteritems():
        globals()["link_%s_%s" % (action_function, finder_function)] = step_generator( action_string,
                                                                                       action_function,
                                                                                       LINK_THING_STRING,
                                                                                       finder_string,
                                                                                       finder_function
                                                                                      )

for finder_string_from, finder_function_from in ELEMENT_FINDERS.iteritems():
    for finder_string_to, finder_function_to in ELEMENT_FINDERS.iteritems():
        globals()["element_drag_%s_%s" % (finder_function_from, finder_function_to)] = drag_and_drop_generator(
                                     ELEMENT_THING_STRING,
                                     finder_string_from,
                                     finder_string_to,
                                     finder_function_from,
                                     finder_function_to
                                   )

