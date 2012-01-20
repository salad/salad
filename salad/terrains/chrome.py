from lettuce import before, world, after
from splinter.browser import Browser
from salad.logger import logger


@before.all
def setup_browser():
    logger.info("Setting up chrome...")
    try:
        world.chrome = Browser("chrome")
    except Exception, e:
        logger.warn("Error starting up chrome: %s" % e)


@after.all
def teardown_browser(total):
    logger.info("Tearing down chrome...")
    try:
        world.chrome.quit()
    except:
        logger.warn("Error tearing down chrome.")
