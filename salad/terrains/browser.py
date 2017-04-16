from lettuce import before, world, after
from splinter.browser import Browser
from salad.logger import logger


@before.all
def setup_master_browser():
    try:
        browser = world.drivers[0]
        remote_url = world.remote_url
    except (AttributeError, IndexError):
        browser = 'firefox'
        remote_url = None

    try:
        capabilities = world.remote_capabilities
    except AttributeError:
        capabilities = {}
    world.master_browser = setup_browser(browser, remote_url, **capabilities)
    world.browser = world.master_browser


def setup_browser(browser, url=None, **capabilities):
    logger.info("Setting up browser %s..." % browser)
    try:
        if url:
            logger.warn(capabilities)
            browser = Browser('remote', url=url,
                    browser=browser, **capabilities)
        else:
            browser = Browser(browser)
    except Exception as e:
        logger.warn("Error starting up %s: %s" % (browser, e))
        raise
    return browser


@before.each_scenario
def clear_alternative_browsers(step):
    world.browser = world.master_browser
    world.browsers = []


@after.each_scenario
def reset_to_parent_frame(step):
    if hasattr(world, "parent_browser"):
        world.browser = world.parent_browser


@after.each_scenario
def restore_browser(step):
    for browser in world.browsers:
        teardown_browser(browser)


@after.all
def teardown_master_browser(total):
    teardown_browser(world.master_browser)

def teardown_browser(browser):
    name = browser.driver_name
    logger.info("Tearing down browser %s..." % name)
    try:
        browser.quit()
    except Exception as e:
        logger.warn("Error tearing down %s: %s" % (name, e))
