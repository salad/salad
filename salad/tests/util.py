from nose.tools import assert_equals, assert_not_equals


def assert_equals_with_negate(a, b, negator=False):
    if negator:
        assert_not_equals(a, b)
    else:
        assert_equals(a, b)
