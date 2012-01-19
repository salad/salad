from lettuce import before, world, after
from splinter.browser import Browser
from salad.logger import logger


@before.all
def setup_browser():
    logger.info("Setting up firefox...")
    try:
        world.firefox = Browser("firefox")
    except:
        logger.warn("Error starting up firefox")


@after.all
def teardown_browser(total):
    logger.info("Tearing down firefox...")
    try:
        world.firefox.quit()
    except:
        logger.warn("Error tearing down firefox")
