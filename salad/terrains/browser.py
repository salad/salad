from lettuce import before, world, after
from splinter.browser import Browser
from salad.logger import logger


@before.all
def setup_browser():
    logger.info("Setting up browser %s..." % world.browsers[0])
    try:
        if world.remote_url:
            world.browser = Browser('remote', url=world.remote_url,
                    browser=world.browsers[0])
        else:
            world.browser = Browser(world.browsers[0])
    except Exception as e:
        logger.warn("Error starting up %s: %s" % (world.browsers[0], e))
        raise


@after.each_scenario
def reset_to_parent_frame(step):
    if hasattr(world, "parent_browser"):
        world.browser = world.parent_browser


@after.all
def teardown_browser(total):
    logger.info("Tearing down browser %s..." % world.browsers[0])
    try:
        world.browser.quit()
    except:
        logger.warn("Error tearing down %s" % world.browsers[0])
