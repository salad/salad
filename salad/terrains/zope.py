import logging
from lettuce import before, world, after
from splinter.browser import Browser


@before.all
def setup_browser():
    logging.info("Setting up zope...")
    try:
        world.zope = Browser("zope.testbrowser")
    except:
        logging.warn("Error starting up zope")


@after.all
def teardown_browser(total):
    logging.info("Tearing down browser...")
    try:
        world.zope.quit()
    except:
        logging.warn("Error tearing down zope")
