from nose.tools import assert_equals, assert_not_equals
from random import choice, randint
from string import ascii_letters

from lettuce import step, world

from salad.waiter import SaladWaiter


def wait_for_completion(wait_time, method, *args):
    wait_time = int(wait_time or 0)
    waiter = SaladWaiter(wait_time, ignored_exceptions=AssertionError)
    waiter.until(method, *args)


def parsed_negator(negator):
    return negator and (negator == True or negator != "")


def assert_equals_with_negate(a, b, negator=None):
    if parsed_negator(negator):
        assert_not_equals(a, b)
    else:
        assert_equals(a, b)


def assert_with_negate(assertion, negator=None):
    if parsed_negator(negator):
        assert not assertion
    else:
        assert assertion


def assert_value(type_of_match, value, text, negate):
    """
    assert that a value equals or is contained in a text
    the logic is reversed if negate is True
    """
    if type_of_match == 'is':
        assert_equals_with_negate(value, text, negate)
    elif type_of_match == 'contains':
        assert_with_negate(value in text, negate)
    else:
        msg = ("type_of_match must be either 'is' or 'contains', but "
               "you used '%s'." % (type_of_match, ))
        raise NotImplementedError(msg)


def store_with_case_option(key, value, upper_lower):
    """
    store an original / uppercase / lowercase value in world.stored_values
    with the key 'key'
    world.stored_values[key] will be overwritten!
    no check if it already exists!
    """
    if not upper_lower:
        world.stored_values[key] = value
        return
    if 'lower' in upper_lower:
        world.stored_values[key] = value.lower()
    elif 'upper' in upper_lower:
        world.stored_values[key] = value.upper()
    else:
        msg = ("upper_lower must contain either 'upper' or 'lower', but "
               "you used '%s' as input." % (upper_lower, ))
        raise NotImplementedError(msg)


def transform_for_upper_lower_comparison(stored, current, upper_lower):
    if not any(x in 'upper_lower' for x in ['upper', 'lower', 'independent']):
        msg = ("upper_lower must contain any of 'upper', 'lower', 'independ"
               "ent', but you used '%s' as input." % (upper_lower, ))
        raise NotImplementedError(msg)

    if 'lower' in upper_lower:
        stored = stored.lower()
    elif 'upper' in upper_lower:
        stored = stored.upper()
    elif 'independent' in upper_lower:
        stored = stored.lower()
        current = current.lower()
    return (stored, current)


def generate_content(type_of_fill, length):
    if type_of_fill == 'email':
        return generate_random_string(length) + '@mailinator.com'
    elif type_of_fill == 'string':
        return generate_random_string(length)
    elif type_of_fill == 'name':
        name = generate_random_string(length)
        if length <= 3:
            return name
        index = randint(1, len(name)-2)
        return name[:index] + ' ' + name[index+1:]


def generate_random_string(length):
    lst = [choice(ascii_letters) for n in range(length)]
    return "".join(lst)
