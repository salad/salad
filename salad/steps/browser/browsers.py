from lettuce import step, world

# Choose which browser to use


@step(r'am using zope')
def using_zope(step):
    world.browser = world.zope


@step(r'am using chrome')
def using_chrome(step):
    world.browser = world.chrome


@step(r'am using firefox')
def using_firefox(step):
    world.browser = world.firefox
