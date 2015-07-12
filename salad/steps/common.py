import time

from lettuce import step, world


@step(r'look around')
def look_around(step):
    pass


@step(r'wait (\d+) seconds?')
def wait(step, seconds):
    time.sleep(float(seconds))


@step(r'should fail because "([^"]*)"')
def should_fail(step, because):
    raise Exception(because)


@step(r'print out( the stored value of)? "([^"]+)"')
def print_out(step, stored, text):
    if stored:
        text = world.stored_values[text]
    print(text)
    print("-------")
