import logging
from lettuce import before, world, after
from splinter.browser import Browser


@before.all
def setup_browser():
    logging.info("Setting up firefox...")
    try:
        world.firefox = Browser("firefox")
    except:
        logging.warn("Error starting up firefox")


@after.all
def teardown_browser(total):
    logging.info("Tearing down firefox...")
    try:
        world.firefox.quit()
    except:
        logging.warn("Error tearing down firefox")
