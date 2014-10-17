from lettuce import step, world
from salad.tests.util import (assert_with_negate, store_with_case_option,
                              transform_for_upper_lower_comparison,
                              wait_for_completion)


def _get_alert_or_none():
    try:
        alert = world.browser.driver.switch_to_alert()
        # switch_to_alert() always returns an object, but if there is no
        # alert, the following line will raise an exception
        alert.text
    except:
        alert = None
    return alert


@step(r'should( not)? see (?:a|an) (?:alert|prompt)(?: within (\d+) seconds)?$')
def should_see_alert(step, negate, wait_time):
    def assert_alert(negate):
        world.prompt = _get_alert_or_none()
        assert_with_negate(world.prompt is not None, negate)
        if world.prompt:
            world.prompt.accept()
        return True
    wait_for_completion(wait_time, assert_alert, negate)


@step(r'should( not)? see (?:a|an) (?:alert|prompt) (with the text|that says|with text that contains) "([^"]*)"(?: within (\d+) seconds)?$')
def should_see_alert_with_text(step, negate, type_of_match, text, wait_time):
    def assert_alert_with_text(negate, type_of_match, text):
        world.prompt = _get_alert_or_none()
        prompt_exists = world.prompt is not None
        text_exists = None
        if 'contains' in type_of_match:
            text_exists = text in world.prompt.text
        else:
            text_exists = world.prompt.text == text
        assert_with_negate(prompt_exists and text_exists, negate)
        if world.prompt:
            world.prompt.accept()
        return True
    wait_for_completion(wait_time, assert_alert_with_text, negate,
                        type_of_match, text)


@step(r'should( not)? see (?:a|an) (?:alert|prompt) text that (is|contains) the stored( lowercase| uppercase| case independent)? value of "([^"]*)"(?: within (\d+) seconds)?$')
def should_see_alert_with_stored_value(step, negate, type_of_match, upper_lower, name, wait_time):
    def assert_alert_with_stored_value(negate, type_of_match, upper_lower, name):
        world.prompt = _get_alert_or_none()
        assert world.stored_values[name]
        stored = world.stored_values[name]
        current = world.prompt.text
        if upper_lower:
            stored, current = transform_for_upper_lower_comparison(
                stored, current, upper_lower)
        prompt_exists = world.prompt is not None
        text_exists = None
        if 'contains' in type_of_match:
            text_exists = stored in current
        else:
            text_exists = stored == current
        assert_with_negate(prompt_exists and text_exists, negate)
        if world.prompt:
            world.prompt.accept()
        return True
    wait_for_completion(wait_time, assert_alert_with_stored_value, negate,
                        type_of_match, upper_lower, name)


@step(r'cancel the (?:prompt|alert)$')
def cancel_prompt(step):
    if not hasattr(world, "prompt") or not world.prompt:
        world.prompt = _get_alert_or_none()
    world.prompt.dismiss()


@step(r'accept the (?:prompt|alert)$')
def cancel_prompt(step):
    if not hasattr(world, "prompt") or not world.prompt:
        world.prompt = _get_alert_or_none()
    world.prompt.accept()


@step(r'enter "([^"]*)" into the prompt$')
def enter_into_the_prompt(step, text):
    if not hasattr(world, "prompt") or not world.prompt:
        world.prompt = _get_alert_or_none()
    world.prompt.send_keys(text)
    world.prompt.accept()


@step(r'enter the stored value of "([^"]*)" into the prompt$')
def enter_stored_value_into_prompt(step, name):
    if not hasattr(world, "prompt") or not world.prompt:
        world.prompt = _get_alert_or_none()
    assert world.stored_values[name]
    world.prompt.send_keys(world.stored_values[name])
    world.prompt.accept()


@step(r'(?:store|remember) the( lowercase| uppercase)? text of the (?:alert|prompt) as "([^"]+)"$')
def store_text_of_element_with_case_option_as(step, upper_lower, name):
    if not hasattr(world, "prompt") or not world.prompt:
        world.prompt = _get_alert_or_none()
    store_with_case_option(name, world.prompt.text, upper_lower)
