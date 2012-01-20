from nose.tools import assert_equals, assert_not_equals


def assert_equals_with_negate(a, b, negator=None):
    if negator and (negator == True or negator != ""):
        assert_not_equals(a, b)
    else:
        assert_equals(a, b)


def assert_with_negate(assertion, negator=None):
    if negator and (negator == True or negator != ""):
        assert not assertion
    else:
        assert assertion
