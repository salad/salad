from lettuce import step, world
from salad.terrains.browser import setup_browser

# Choose which browser to use


@step(r'am using (.*)')
def using_alternative_browser(step, browser_name):
    driver = browser_name.lower().replace(' ', '')
    if driver == 'zope':
        driver = 'zope.testbrowser'
    world.browsers.append(setup_browser(driver))
    world.browser = world.browsers[-1]
