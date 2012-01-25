from lettuce import step, world

# Browse from page to page


@step(r'(?:visit|access|open) the url "(.*)"')
def go_to_the_url(step, url):
    world.response = world.browser.visit(url)


@step(r'go back(?: a page)?')
def go_back(step):
    world.browser.back()


@step(r'go forward(?: a page)?')
def go_forward(step):
    world.browser.forward()


@step(r'(?:reload|refresh)(?: the page)?')
def reload(step):
    world.browser.reload()
