Feature: Ensuring that the elements steps work
    In order to make sure that the elements module works
    As a developer
    I test against the form test files

    Scenario: 1. Seeing text in the page
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see "Text that exists" somewhere in the page

    Scenario: 2. Waiting for text in the page
        Given I visit the salad test url "browser/element_waiter.html"
         When I look around
         Then I should see "can be deceiving" somewhere in the page within 10 seconds

    Scenario: 3. Seeing text that should not be in the page
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see "Text that doesn't exist" somewhere in the page

    Scenario: 4. Waiting for text not to be in the page
        Given I visit the salad test url "browser/element_waiter.html"
         When I look around
         Then I should not see "appearances" somewhere in the page within 10 seconds

    Scenario: 5. Seeing links in the page by url and partial url
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see a link to "http://example.com"
          And I should see a link to "http://example.com"
          And I should see a link to the partial url "example.com"
          And I should see a link to a url that contains "example.com"

    Scenario: 6. Waiting for links in the page by url
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see a link to "http://example.com" within 5 seconds
          And I should see a link to the partial url "example.com" within 5 seconds
          And I should see a link to a url that contains "example.com" within 5 seconds

    Scenario: 7. Not seeing links that should not be in the page by url
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see a link to "http://google.com"
          And I should not see a link to the partial url "google.com"
          And I should not see a link to a url that contains "google.com"

    Scenario: 8. Wait to not see links that should not be in the page by url
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see a link to "http://google.com" within 3 seconds
          And I should not see a link to the partial url "google.com" within 3 seconds
          And I should not see a link to a url that contains "google.com" within 3 seconds

    Scenario: 9. Seeing links in the page by link name / link text / partial link text
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see a link called "example"
          And I should see a link with the text "example"
          And I should see a link with the partial text "ample"
          And I should see a link with text that contains "ample"

    Scenario: 10. Waiting to see links in the page by link name
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see a link called "example" within 5 seconds
          And I should see a link with the text "example" within 5 seconds
          And I should see a link with the partial text "ample" within 5 seconds
          And I should see a link with text that contains "ample" within 5 seconds

    Scenario: 11. Not seeing links that should not be in the page by link name
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see a link called "google"
          And I should not see a link with the text "google"
          And I should not see a link with the partial text "oogle"
          And I should not see a link with text that contains "oogle"

    Scenario: 12. Wait to not see links that should not be in the page by link name
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see a link called "google" within 3 seconds
          And I should not see a link with the text "google" within 3 seconds
          And I should not see a link with the partial text "oogle" within 3 seconds
          And I should not see a link with text that contains "oogle" within 3 seconds

    Scenario Outline: 13. Existence of an element
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see an element <finder>

    Examples:
        | finder                                        |
        | named "i_exist_name"                          |
        | with the id "i_exist"                         |
        | with the css selector ".i_exist_class"        |
        | with the xpath "//div[@name='i_exist_name']"  |
        | with the value "this is the value"            |


    Scenario Outline: 14. Non-existence of a non-existent element
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see an element <finder>

    Examples:
        | finder                                              |
        | named "i_do_not_exist_name"                         |
        | with the id "i_do_not_exist"                        |
        | with the css selector ".i_do_not_exist_class"       |
        | with the xpath "//div[@name='i_do_not_exist_name']" |
        | with the value "not existing value"                 |


    Scenario: 15. Content of an element, different sentences
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see that the element with the xpath "//div[@class='i_contain_class']" has "has"
          And I should see that the element with the xpath "//div[@class='i_contain_class']" has the text "has"
          And I should see that the element with the xpath "//div[@class='i_contain_class']" contains the text "has"


    Scenario Outline: 16. Content of an element
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see that the element <finder> contains "has"

    Examples:
        | finder                                             |
        | named "i_contain_name"                             |
        | with the id "i_contain"                            |
        | with the css selector ".i_contain_class"           |
        | with the xpath "//div[@class='i_contain_class']"   |
        | with the value "x"                                 |


    Scenario Outline: 17. Non-content of a element
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see that the element <finder> contains "haz"

    Examples:
        | finder                                    |
        | named "i_contain_name"                    |
        | with the id "i_contain"                   |
        | with the css selector ".i_contain_class"  |
        | with the xpath "//div[@id='i_contain']"   |
        | with the value "x"                                 |


    Scenario Outline: 18. Exact content of an element
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see that the element <finder> contains exactly "I has."

    Examples:
        | finder                                             |
        | named "i_contain_name"                             |
        | with the id "i_contain"                            |
        | with the css selector ".i_contain_class"           |
        | with the xpath "//div[@class='i_contain_class']"   |


    Scenario Outline: 19. Not exact content of a element
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see that the element <finder> contains exactly "I haz."

    Examples:
        | finder                                             |
        | named "i_contain_name"                             |
        | with the id "i_contain"                            |
        | with the css selector ".i_contain_class"           |
        | with the xpath "//div[@class='i_contain_class']"   |


    Scenario Outline: 20. Attribute on an element
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see that the element <finder> has an attribute called "my_attr"

    Examples:
        | finder                                          |
        | named "i_attr_name"                             |
        | with the id "i_attr"                            |
        | with the css selector ".i_attr_class"           |
        | with the xpath "//div[@class='i_attr_class']"   |
        | with the value "attr"                           |


    Scenario Outline: 21. Attribute not on a element
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see that the element <finder> has an attribute called "my_cool_attr"

    Examples:
        | finder                                          |
        | named "i_attr_name"                             |
        | with the id "i_attr"                            |
        | with the css selector ".i_attr_class"           |
        | with the xpath "//div[@class='i_attr_class']"   |
        | with the value "attr"                           |


    Scenario Outline: 22. Attribute on an element with value
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see that the element <finder> has an attribute called "my_attr" with value "me!"

    Examples:
        | finder                                          |
        | named "i_attr_name"                             |
        | with the id "i_attr"                            |
        | with the css selector ".i_attr_class"           |
        | with the xpath "//div[@class='i_attr_class']"   |
        | with the value "attr"                           |


    Scenario Outline: 23. Attribute not on a element with value
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see that the element <finder> has an attribute called "my_attr" with value "you"

    Examples:
        | finder                                        |
        | named "i_attr_name"                           |
        | with the id "i_attr"                          |
        | with the css selector ".i_attr_class"         |
        | with the xpath "//div[@name='i_attr_name']"   |
        | with the value "attr"                           |


    Scenario: 24. Visibility of elements
        Given I visit the salad test url "browser/invisible_elements.html"
          And I should see the element with the id "loading_status"
         When I look around
         Then I should see the element with the id "ready_status" within 5 seconds
          And I should not see the element with the id "loading_status"


    Scenario Outline: 25. Element polling for disappearance
        Given I visit the salad test url "browser/element_waiter.html"
         When I look around
         Then I should not see <thing> within 10 seconds

    Examples:
        | thing                                                                                   |
        | that the element with id "disappear" has an attribute called "my_attr" with value "you" |
        | that the element with id "disappear" contains exactly "appearances"                     |
        | the element with id "disappear"                                                         |


    Scenario Outline: 26. Element polling for appearance
        Given I visit the salad test url "browser/element_waiter.html"
         When I look around
         Then I should see <thing> within 10 seconds

    Examples:
        | thing                                                                                |
        | the element with id "appear"                                                         |
        | that the element with id "appear" contains exactly "can be deceiving"                |
        | that the element with id "appear" has an attribute called "myattr" with value "you" |
