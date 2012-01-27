from lettuce import step, world
from salad.tests.util import assert_with_negate


def _get_alert_or_none():
    try:
        alert = world.browser.get_alert()
    except:
        alert = None
    return alert


@step(r'should( not)? see an alert$')
def should_see_alert(step, negate):
    alert = _get_alert_or_none()
    assert_with_negate(alert is not None, negate)
    if alert:
        alert.accept()


@step(r'should( not)? see an alert (?:with the text|that says) "(.*)"')
def should_see_alert_with_text(step, negate, text):
    alert = _get_alert_or_none()
    assert_with_negate(alert is not None and alert.text == text, negate)
    if alert:
        alert.accept()


@step(r'should( not)? see a prompt.?$')
def should_see_prompt(step, negate):
    world.prompt = _get_alert_or_none()
    assert_with_negate(world.prompt is not None, negate)
    if world.prompt:
        world.prompt.accept()


@step(r'should( not)? see a prompt (?:with the text|that says) "(.*)"')
def should_see_prompt_with_text(step, negate, text):
    world.prompt = _get_alert_or_none()
    assert_with_negate(world.prompt is not None and world.prompt.text == text, negate)
    if world.prompt:
        world.prompt.accept()


@step(r'cancel the prompt')
def cancel_prompt(step):
    if not hasattr(world, "prompt") or not world.prompt:
        world.prompt = _get_alert_or_none()
    # for some reason, world.prompt.dismiss() doesn't work.
    world.prompt._alert.dismiss()


@step(r'enter "(.*)" into the prompt')
def enter_into_the_prompt(step, text):
    if not hasattr(world, "prompt") or not world.prompt:
        world.prompt = _get_alert_or_none()

    world.prompt.fill_with(text)
    world.prompt.accept()
