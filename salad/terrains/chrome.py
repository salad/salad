import logging
from lettuce import before, world, after
from splinter.browser import Browser


@before.all
def setup_browser():
    logging.info("Setting up chrome...")
    try:
        world.chrome = Browser("chrome")
    except:
        logging.warn("Error starting up chrome")


@after.all
def teardown_browser(total):
    logging.info("Tearing down chrome...")
    try:
        world.chrome.quit()
    except:
        logging.warn("Error tearing down chrome")
