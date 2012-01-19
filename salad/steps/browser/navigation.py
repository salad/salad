from lettuce import step, world
from salad.logger import logger

# Browse from page to page


@step(r'visit the url "(.*)"')
def go_to_the_url(step, url):
    world.response = world.browser.visit(url)


@step(r'access the url "(.*)"')
def access_to_the_url(step, url):
    logger.warn("'access the url has been deprecated in favor of 'visit the url', and will be removed in salad 0.5. Please update your code.")
    go_to_the_url(step, url)


@step(r'go back a page')
def go_back(step, url):
    world.browser.back()


@step(r'go forward a page')
def go_forward(step, url):
    world.browser.forward()


@step(r'reload the page')
def go_reload(step, url):
    world.browser.reload()
