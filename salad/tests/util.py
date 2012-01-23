from nose.tools import assert_equals, assert_not_equals


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
