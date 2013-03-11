Feature: Ensuring that the elements steps work
    In order to make sure that the elements module works
    As a developer
    I test against the form test files

    Scenario Outline: Content of an element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see that the <ordinal> element with css selector ".i_contain_class" contains "has"

	Examples:
		| ordinal                                    |
		| first                                      |
		| 1st                                        |
		| 2nd                                        |
		| 3rd                                        |
		| 4th                                        |
		| 5th                                        |

    Scenario: Non-Content of an element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see that the 6th element with css selector ".i_contain_class" contains "has"

    Scenario Outline: Attribute of an element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see that the <ordinal> element with css selector ".i_contain_class" has an attribute called "class"

	Examples:
		| ordinal                                    |
		| first                                      |
		| 1st                                        |
		| 2nd                                        |
		| 3rd                                        |
		| 4th                                        |
		| 5th                                        |

    Scenario: Non-Attribute of an element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see that the last element with css selector ".i_contain_class" has an attribute called "label"

    Scenario: Content of an <ordnial-number> element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see that the 6th element with css selector ".i_contain_class" is exactly "But I have."

    Scenario Outline: Attribute on an element with value
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see that the <ordinal> element with css selector ".i_attr_class" has an attribute called "my_attr" with value "me!"

    Examples:
        | ordinal                                    |
		| first                                      |
		| 1st                                        |
		| 2nd                                        |
		| 3rd                                        |
		| 4th                                        |
		| 5th                                        |

    Scenario: Attribute not on a element with value
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see that the 6th element with css selector ".i_attr_class" has an attribute called "my_attr" with value "me!"

    Scenario: Attribute not on a element with value
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see that the 7th element with css selector ".i_attr_class" has an attribute called "my_attr" with value "me!"

    Scenario Outline: Visibility of elements
        Given I visit the salad test url "browser/invisible_elements.html"
        And I should see the element with the id "loading_status"
        When I look around
		Then I should not see the <ordinal> element with css selector ".invisible"

	Examples:
		| first                                      |
		| last                                       |
		| 1st                                        |
		| 2nd                                        |
		| 3rd                                        |
		| 4th                                        |
		| 5th                                        |

