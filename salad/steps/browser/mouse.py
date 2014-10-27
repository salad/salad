from lettuce import step, world
from selenium.webdriver.common.action_chains import ActionChains

from salad.steps.browser.finders import (ELEMENT_FINDERS, LINK_FINDERS,
                                         ELEMENT_THING_STRING,
                                         LINK_THING_STRING,
                                         PICK_EXPRESSION, _get_visible_element)

"""
    Click on things, mouse over, move the mouse around.

    General syntax:
    <action> the <how-many-eth> <thing> <find clause>

    For example:
    click on the 3rd element with the xpath "//div"

    Please look in finders.py for the regular expressions

    The actions are:
    click
    double click
    right click
    drag and drop
    mouse over
    mouse out

    What's happening here? We're generating steps for every possible
    permutation of the actions and the finders below.
"""

ACTIONS = {
    "click(?: on)?": "click",
    "(?: mouse over|mouse-over|mouseover)": "mouse_over",
    "(?: mouse out|mouse-out|mouseout)": "mouse_out",
    "(?: double click|double-click|doubleclick)": "double_click",
    "(?: right click|right-click|rightclick)": "right_click",
}

ACTION_ASSOCIATIONS = {
    "mouse_over": "move_to_element",
    "mouse_out": "move_by_offset",
    "double_click": "double_click",
    "right_click": "context_click"
}


def step_generator(action_string, action_function, thing_string,
                   finder_string, finder_function):

    @step(r'%s (?:a|the)%s %s %s$' %
          (action_string, PICK_EXPRESSION, thing_string, finder_string))
    def _this_step(step, pick, find_pattern):
        ele = _get_visible_element(finder_function, pick, find_pattern)

        if action_function == 'click':
            ele.click()
            return

        action_chain = ActionChains(world.browser.driver)
        function = getattr(action_chain, ACTION_ASSOCIATIONS[action_function])
        if action_function == 'mouse_out':
            function(5000, 5000)
        else:
            function(ele)
        action_chain.perform()

    return _this_step


def drag_and_drop_generator(thing_string, finder_string_from, finder_string_to,
                            finder_function_from, finder_function_to):

    @step(r'drag the%s %s %s and drop it on the%s %s %s$' % (
          PICK_EXPRESSION, thing_string, finder_string_from,
          PICK_EXPRESSION, thing_string, finder_string_to))
    def _this_step(step, handler_pick, drag_handler_pattern, target_pick,
                   drag_target_pattern):
        handler = _get_visible_element(finder_function_from, handler_pick,
                                       drag_handler_pattern)
        target = _get_visible_element(finder_function_to, target_pick,
                                      drag_target_pattern)

        action_chain = ActionChains(world.browser.driver)
        action_chain.drag_and_drop(handler, target)
        action_chain.perform()

    return _this_step


for action_string, action_function in ACTIONS.iteritems():
    for finder_string, finder_function in ELEMENT_FINDERS.iteritems():
        globals()["element_%s_%s" % (action_function, finder_function)] = (
            step_generator(action_string, action_function,
                           ELEMENT_THING_STRING, finder_string,
                           finder_function))

    for finder_string, finder_function in LINK_FINDERS.iteritems():
        globals()["link_%s_%s" % (action_function, finder_function)] = (
            step_generator(action_string, action_function,
                           LINK_THING_STRING, finder_string,
                           finder_function))

for finder_str_from, findr_func_from in ELEMENT_FINDERS.iteritems():
    for finder_str_to, findr_func_to in ELEMENT_FINDERS.iteritems():
        globals()["element_drag_%s_%s" % (findr_func_from, findr_func_to)] = (
            drag_and_drop_generator(ELEMENT_THING_STRING, finder_str_from,
                                    finder_str_to, findr_func_from,
                                    findr_func_to))
