import time

from lettuce import step, world


@step(r'look around')
def look_around(step):
    pass


@step(r'wait (\d+) seconds?')
def wait(step, seconds):
    time.sleep(int(seconds))


@step(r'Then I should fail because "(.*)"')
def should_fail(step, because):
    assert because == True
