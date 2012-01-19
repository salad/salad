from lettuce import step, world

# Find and verify that elements exist, have the expected content.


@step(r'should see "(.*)"')
def should_see(step, text):
    assert text in world.browser.html


@step(r'should not see "(.*)"')
def should_not_see(step, text):
    assert not text in world.browser.html


@step(r'should see a link called "(.*)"')
def should_see_a_link_called(step, text):
    assert len(world.browser.find_link_by_text(text)) > 0


@step(r'should not see a link called "(.*)"')
def should_not_see_a_link_called(step, text):
    assert len(world.browser.find_link_by_text(text)) == 0


@step(r'should see a link to "(.*)"')
def should_see_a_link_to(step, link):
    assert len(world.browser.find_link_by_href(link)) > 0


@step(r'should not see a link to "(.*)"')
def should_not_see_a_link_to(step, link):
    assert len(world.browser.find_link_by_href(link)) == 0


@step(r'the element with the CSS selector of "(.*)" should be visible')
def element_visible(step, css):
    ele = world.browser.find_by_css(css)
    assert ele.visible == True


@step(r'the element with the CSS selector of "(.*)" should not be visible')
def element_invisible(step, css):
    ele = world.browser.find_by_css(css)
    assert ele.visible == False
