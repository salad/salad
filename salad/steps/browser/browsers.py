from lettuce import step, world

# Choose which browser to use


@step(r'am using (?:Z|z)ope')
def using_zope(step):
    world.browser = world.zope


@step(r'am using (?:C|c)hrome')
def using_chrome(step):
    world.browser = world.chrome


@step(r'am using (?:F|f)irefox')
def using_firefox(step):
    world.browser = world.firefox
