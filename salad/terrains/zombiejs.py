from lettuce import before, world, after
from splinter.browser import Browser
from salad.logger import logger


@before.all
def setup_browser():
    logger.info("Setting up zombiejs...")
    try:
        world.zombiejs = Browser("zombiejs.testbrowser")
    except:
        logger.warn("Error starting up zombiejs")


@after.all
def teardown_browser(total):
    logger.info("Tearing down browser...")
    try:
        world.zombiejs.quit()
    except:
        logger.warn("Error tearing down zombiejs")
