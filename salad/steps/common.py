import time

from lettuce import step


@step(r'look around')
def look_around(step):
    pass


@step(r'wait (\d+) seconds?')
def wait(step, seconds):
    time.sleep(float(seconds))


@step(r'should fail because "(.*)"')
def should_fail(step, because):
    assert because == True
