from datetime import datetime
from time import time

from lettuce import step, world
from salad.terrains.browser import setup_browser
from salad.tests.util import generate_random_string


@step(r'am using ([^"]*)$')
def using_alternative_browser(step, browser_name):
    driver = browser_name.lower().replace(' ', '')
    world.browsers.append(setup_browser(driver))
    world.browser = world.browsers[-1]


@step(r'take a screenshot(?: named "([^"]+)")?( with timestamp)?')
def take_screenshot(step, name, with_timestamp):
    ts = ''

    if with_timestamp:
        ts = datetime.fromtimestamp(time()).strftime('%Y-%m-%d_%H:%M:%S')
        ts = '_%s' % (ts, )
        if not name:
            name = 'screenshot'

    if not (with_timestamp or name):
        suffix = generate_random_string(10)
        name = 'screenshot_%s' % (suffix, )

    name = '/tmp/%s%s.png' % (name, ts)
    world.browser.driver.get_screenshot_as_file(name)
