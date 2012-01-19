from lettuce import before, world, after
from splinter.browser import Browser
from salad.logger import logger


@before.all
def setup_browser():
    logger.info("Setting up zope...")
    try:
        world.zope = Browser("zope.testbrowser")
    except:
        logger.warn("Error starting up zope")


@after.all
def teardown_browser(total):
    logger.info("Tearing down browser...")
    try:
        world.zope.quit()
    except:
        logger.warn("Error tearing down zope")
