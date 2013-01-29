Feature: Ensuring that the elements steps work
    In order to make sure that the elements module works
    As a developer
    I test against the form test files

    Scenario: Seeing text in the page
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see "Text that exists" somewhere in the page

    Scenario: Waiting for text in the page
        Given I visit the salad test url "browser/element_waiter.html"
        When I look around
        Then I should see "can be deceiving" somewhere in the page within 10 seconds

    Scenario: seeing text that should not be in doesn't th page
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see "Text that doesn't exist" somewhere in the page

    Scenario: Waiting for text not to be in the page
        Given I visit the salad test url "browser/element_waiter.html"
        When I look around
        Then I should not see "appearances" somewhere in the page within 10 seconds

    Scenario: Seeing links in the page by url
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see a link to "http://example.com"

    Scenario: Waiting for links in the page by url
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see a link to "http://example.com" within 5 seconds

    Scenario: Not seeing links that should not be in the page by url
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see a link to "http://google.com"

    Scenario: Wait to not see links that should not be in the page by url
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see a link to "http://google.com" within 5 seconds

    Scenario: Seeing links in the page by link name
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see a link called "example"

    Scenario: Waiting to see links in the page by link name
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see a link called "example" within 5 seconds

    Scenario: Not seeing links that should not be in the page by link name
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see a link called "google"

    Scenario: Wait to not see links that should not be in the page by link name
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see a link called "google" within 5 seconds

    Scenario Outline: Existence of an element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see an element <finder>

    Examples:
        | finder                                   |
        | named "i_exist_name"                     |
        | with the id "i_exist"                    |
        | with the css selector ".i_exist_class"   |


    Scenario Outline: Non-existence of a non-existent element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see an element <finder>

    Examples:
        | finder                                          |
        | named "i_do_not_exist_name"                     |
        | with the id "i_do_not_exist"                    |
        | with the css selector ".i_do_not_exist_class"   |


    Scenario Outline: Content of an element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see that the element <finder> contains "has"

    Examples:
        | finder                                     |
        | named "i_contain_name"                     |
        | with the id "i_contain"                    |
        | with the css selector ".i_contain_class"   |


    Scenario Outline: Non-content of a element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see that the element <finder> contains "haz"

    Examples:
        | finder                                     |
        | named "i_contain_name"                     |
        | with the id "i_contain"                    |
        | with the css selector ".i_contain_class"   |

    Scenario Outline: Exact content of an element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see that the element <finder> contains exactly "I has."

    Examples:
        | finder                                     |
        | named "i_contain_name"                     |
        | with the id "i_contain"                    |
        | with the css selector ".i_contain_class"   |


    Scenario Outline: Not exact content of a element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see that the element <finder> contains exactly "I haz."

    Examples:
        | finder                                     |
        | named "i_contain_name"                     |
        | with the id "i_contain"                    |
        | with the css selector ".i_contain_class"   |

    Scenario Outline: Attribute on an element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see that the element <finder> has an attribute called "my_attr"

    Examples:
        | finder                                  |
        | named "i_attr_name"                     |
        | with the id "i_attr"                    |
        | with the css selector ".i_attr_class"   |


    Scenario Outline: Attribute not on a element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see that the element <finder> has an attribute called "my_cool_attr"

    Examples:
        | finder                                  |
        | named "i_attr_name"                     |
        | with the id "i_attr"                    |
        | with the css selector ".i_attr_class"   |


    Scenario Outline: Attribute on an element with value
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see that the element <finder> has an attribute called "my_attr" with value "me!"

    Examples:
        | finder                                  |
        | named "i_attr_name"                     |
        | with the id "i_attr"                    |
        | with the css selector ".i_attr_class"   |


    Scenario Outline: Attribute not on a element with value
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see that the element <finder> has an attribute called "my_attr" with value "you"

    Examples:
        | finder                                  |
        | named "i_attr_name"                     |
        | with the id "i_attr"                    |
        | with the css selector ".i_attr_class"   |

    Scenario: Visibility of elements
        Given I visit the salad test url "browser/invisible_elements.html"
        And I should see the element with the id "loading_status"
        When I look around
        Then I should see the element with the id "ready_status" within 5 seconds
        And I should not see the element with the id "loading_status"


    Scenario Outline: Element polling for disappearance
        Given I visit the salad test url "browser/element_waiter.html"
        When I look around
        Then I should not see <thing> within 10 seconds

    Examples:
        | thing                                                                                   |
        | that the element with id "disappear" has an attribute called "my_attr" with value "you" |
        | that the element with id "disappear" contains exactly "appearances"                     |
        | the element with id "disappear"                                                         |


    Scenario Outline: Element polling for appearance
        Given I visit the salad test url "browser/element_waiter.html"
        When I look around
        Then I should see <thing> within 10 seconds

    Examples:
        | thing                                                                                |
        | the element with id "appear"                                                         |
        | that the element with id "appear" contains exactly "can be deceiving"                |
        | that the element with id "appear" has an attribute called "my_attr" with value "you" |
