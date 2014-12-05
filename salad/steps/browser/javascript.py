# -*- coding: utf-8 -*-

from lettuce import step, world

from salad.exceptions import WrongJavascriptReturnValue
from salad.logger import logger
from salad.tests.util import assert_equals_with_negate, wait_for_completion

# Execute JS and verify results


@step(r'run the javascript "([^"]*)"$')
def run_the_javascript(step, script):
    try:
        world.browser.execute_script(script)
    except NotImplementedError:
        logger.info("Attempted to run javascript in a javascript-disabled"
                    "browser. Moving along.")


@step(r'should( not)? see that running the javascript "([^"]*)" returns '
      '"([^"]*)"(?: within (\d+) seconds)?$')
def evaluate_the_javascript(step, negate, script, value, wait_time):
    def assert_javascript_returns_value(negate, script, value):
        try:
            assert_equals_with_negate(
                "%s" % world.browser.evaluate_script(script), value, negate)
        except NotImplementedError:
            logger.info("Attempted to run javascript in a javascript-disabled"
                        "browser. Moving along.")

        return True

    try:
        wait_for_completion(wait_time, assert_javascript_returns_value,
                            negate, script, value)
    except:
        ret_val = world.browser.evaluate_script(script)
        msg = "%s != %s after %s seconds" % (ret_val, value, wait_time)
        raise WrongJavascriptReturnValue(msg)
