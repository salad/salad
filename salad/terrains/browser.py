from lettuce import before, world
from firefox import *


@before.all
def setup_browser():
    world.browser = world.firefox
