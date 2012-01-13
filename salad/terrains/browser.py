import logging
from lettuce import before, world, after
from splinter.browser import Browser


@before.all
def setup_browser():
    logging.info("Setting up browser...")
    world.browser = Browser()


@after.all
def teardown_browser(total):
    logging.info("Tearing down browser...")
    world.browser.quit()
