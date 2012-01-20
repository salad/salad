from lettuce import step, world
from salad.tests.util import assert_equals_with_negate
from salad.logger import logger

# Execute JS and verify results


@step(r'run the javascript "(.*)"')
def run_the_javascript(step, script):
    try:
        world.browser.execute_script(script)
    except NotImplementedError:
        logger.info("Attempted to run javascript in a javascript-disabled browser. Moving along.")


@step(r'should( not)? see that running the javascript "(.*)" returns "(.*)"')
def evaluate_the_javascript(step, negate, script, value):
    try:
        assert_equals_with_negate("%s" % world.browser.evaluate_script(script), value, negate)
    except NotImplementedError:
        logger.info("Attempted to run javascript in a javascript-disabled browser. Moving along.")
