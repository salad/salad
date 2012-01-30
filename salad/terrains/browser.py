from lettuce import before, world
from firefox import *


@before.all
def setup_browser():
    world.browser = world.firefox


@after.each_scenario
def reset_to_parent_frame(step):
    if hasattr(world, "parent_browser"):
        world.browser = world.parent_browser
