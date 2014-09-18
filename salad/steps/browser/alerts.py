from lettuce import step, world
from salad.tests.util import (assert_with_negate, store_with_case_option,
                              transform_for_upper_lower_comparison)


def _get_alert_or_none():
    try:
        alert = world.browser.get_alert()
    except:
        alert = None
    return alert


@step(r'should( not)? see (?:a|an) (?:alert|prompt)$')
def should_see_alert(step, negate):
    world.prompt = _get_alert_or_none()
    assert_with_negate(world.prompt is not None, negate)
    if world.prompt:
        world.prompt.accept()


@step(r'should( not)? see (?:a|an) (?:alert|prompt) (with the text|that says|with text that contains) "([^"]*)"$')
def should_see_alert_with_text(step, negate, type_of_match, text):
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


@step(r'should( not)? see (?:a|an) (?:alert|prompt) text that (is|contains) the stored( lowercase| uppercase| case independent)? value of "([^"]*)"$')
def should_see_alert_with_stored_value(step, negate, type_of_match, upper_lower, name):
    world.prompt = _get_alert_or_none()
    assert world.stored_values[name]
    stored = world.stored_values[name]
    current = world.prompt.text
    if upper_lower:
        stored, current = transform_for_upper_lower_comparison(stored,
                                                               current,
                                                               upper_lower)
    prompt_exists = world.prompt is not None
    text_exists = None
    if 'contains' in type_of_match:
        text_exists = stored in current
    else:
        text_exists = stored == current
    assert_with_negate(prompt_exists and text_exists, negate)
    if world.prompt:
        world.prompt.accept()


@step(r'cancel the (?:prompt|alert)$')
def cancel_prompt(step):
    if not hasattr(world, "prompt") or not world.prompt:
        world.prompt = _get_alert_or_none()
    # for some reason, world.prompt.dismiss() doesn't work.
    world.prompt._alert.dismiss()


@step(r'enter "([^"]*)" into the (?:alert|prompt)$')
def enter_into_the_prompt(step, text):
    if not hasattr(world, "prompt") or not world.prompt:
        world.prompt = _get_alert_or_none()
    world.prompt.fill_with(text)
    world.prompt.accept()


@step(r'enter the stored value of "([^"]*)" into the (?:alert|prompt)$')
def enter_stored_value_into_prompt(step, name):
    if not hasattr(world, "prompt") or not world.prompt:
        world.prompt = _get_alert_or_none()
    assert world.stored_values[name]
    world.prompt.fill_with(world.stored_values[name])
    world.prompt.accept()


@step(r'(?:store|remember) the( lowercase| uppercase)? text of the (?:alert|prompt) as "([^"]+)"$')
def bla(step, upper_lower, name):
    if not hasattr(world, "prompt") or not world.prompt:
        world.prompt = _get_alert_or_none()
    store_with_case_option(name, world.prompt.text, upper_lower)
