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


    Scenario: 3. Not seeing text that should not be in the page
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
          And I should see a link to the url "http://example.com"
          And I should see a link to the partial url "example.com"
          And I should see a link to a url that contains "example.com"


    Scenario: 6. Waiting for links in the page by url and partial url
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see a link to "http://example.com" within 10 seconds
          And I should see a link to the url "http://example.com" within 5 seconds
          And I should see a link to the partial url "example.com" within 5 seconds
          And I should see a link to a url that contains "example.com" within 5 seconds


    Scenario: 7. Not seeing links that should not be in the page by (partial) url
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see a link to "http://google.com"
          And I should not see a link to the url "http://google.com"
          And I should not see a link to the partial url "google.com"
          And I should not see a link to a url that contains "google.com"


    Scenario: 8. Wait to not see links that should not be in the page by (partial) url
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see a link to "http://google.com" within 3 seconds
          And I should not see a link to the url "http://google.com" within 3 seconds
          And I should not see a link to the partial url "google.com" within 3 seconds
          And I should not see a link to a url that contains "google.com" within 3 seconds


    Scenario: 9. Seeing links in the page by link text / partial link text
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see a link called "example"
          And I should see a link with the text "example"
          And I should see a link with text "example"
          And I should see a link with the partial text "ample"
          And I should see a link with text that contains "ample"


    Scenario: 10. Waiting to see links in the page by (partial) link text
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see a link called "example" within 5 seconds
         Then I should see a link with text "example" within 5 seconds
          And I should see a link with the text "example" within 5 seconds
          And I should see a link with the partial text "ample" within 5 seconds
          And I should see a link with text that contains "ample" within 5 seconds


    Scenario: 11. Not seeing links that should not be in the page by (partial) link text
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see a link called "google"
         Then I should not see a link with text "google"
          And I should not see a link with the text "google"
          And I should not see a link with the partial text "oogle"
          And I should not see a link with text that contains "oogle"


    Scenario: 12. Wait to not see links that should not be in the page by (partial) link text
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see a link called "google" within 3 seconds
         Then I should not see a link with text "google" within 3 seconds
          And I should not see a link with the text "google" within 3 seconds
          And I should not see a link with the partial text "oogle" within 3 seconds
          And I should not see a link with text that contains "oogle" within 3 seconds


    Scenario Outline: 13. Positive test for the "Visibility pattern"
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see <thing> <finder>
          And I should see <thing> <finder> within 3 seconds

    Examples:
        | finder                                       | thing       |
        | named "i_exist_name"                         | the element |
        | with the id "i_exist"                        | the element |
        | with the css selector ".i_exist_class"       | the element |
        | with the xpath "//div[@name='i_exist_name']" | the element |
        | with the value "this is the value"           | the element |
        | to "http://example.com"                      | the link    |
        | to the url "http://example.com"              | the link    |
        | to the partial url "example.com"             | the link    |
        | to a url that contains "example.com"         | the link    |
        | with text "example"                          | the link    |
        | with the text "example"                      | the link    |
        | called "example"                             | the link    |
        | with the partial text "ample"                | the link    |
        | with text that contains "ample"              | the link    |


    Scenario Outline: 14. Negative Test for the "visibility pattern"
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see <thing> <finder>
          And I should not see <thing> <finder> within 3 seconds

    Examples:
        | finder                                              | thing       |
        | named "i_do_not_exist_name"                         | the element |
        | with the id "i_do_not_exist"                        | the element |
        | with the css selector ".i_do_not_exist_class"       | the element |
        | with the xpath "//div[@name='i_do_not_exist_name']" | the element |
        | with the value "not existing value"                 | the element |
        | to "http://amazon.com"                              | the link    |
        | to the url "http://amazon.com"                      | the link    |
        | to the partial url "amazon.com"                     | the link    |
        | to a url that contains "amazon.com"                 | the link    |
        | with text "amazon"                                  | the link    |
        | with the text "amazon"                              | the link    |
        | called "amazon"                                     | the link    |
        | with the partial text "amazon"                      | the link    |
        | with text that contains "amazon"                    | the link    |


    Scenario Outline: 15. Test for the "contains pattern"
        Given I visit the salad test url "browser/elements.html"
         When I look around
         # positive. timed and not timed
         Then I should see that the <finder> contains "<content>"
          And I should see that the <finder> contains the text "<content>"
          And I should see that the <finder> has "<content>"
          And I should see that the <finder> has the text "<content>"
          And I should see that the <finder> contains "<content>" within 3 seconds
          And I should see that the <finder> contains the text "<content>" within 3 seconds
          And I should see that the <finder> has "<content>" within 3 seconds
          And I should see that the <finder> has the text "<content>" within 3 seconds
         # negative. timed and not timed
          And I should not see that the <finder> contains "haz"
          And I should not see that the <finder> contains the text "haz"
          And I should not see that the <finder> has the text "haz"
          And I should not see that the <finder> has "haz"
          And I should not see that the <finder> contains "haz" within 3 seconds
          And I should not see that the <finder> contains the text "haz" within 3 seconds
          And I should not see that the <finder> has the text "haz" within 3 seconds
          And I should not see that the <finder> has "haz" within 3 seconds

    Examples:
        | finder                                                   | content |
        | element named "i_contain_name"                           | has     |
        | element with the id "i_contain"                          | has     |
        | element with the css selector ".i_contain_class"         | has     |
        | element with the xpath "//div[@class='i_contain_class']" | has     |
        | element with the value "x"                               | has     |
        | link to "http://example.com"                             | ample   |
        | link to the url "http://example.com"                     | ample   |
        | link to the partial url "example.com"                    | ample   |
        | link to a url that contains "example.com"                | ample   |
        | link with text "example"                                 | ample   |
        | link with the text "example"                             | ample   |
        | link called "example"                                    | ample   |
        | link with the partial text "ample"                       | ample   |
        | link with text that contains "ample"                     | ample   |


    Scenario: 16. Positive test for "contains exactly pattern"
        Given I visit the salad test url "browser/elements.html"
         When I look around
         # not timed
         Then I should see that the element named "i_contain_name" contains exactly "I has."
          And I should see that the element with the id "i_contain" contains exactly "I has."
          And I should see that the element with the css selector ".i_contain_class" contains exactly "I has."
          And I should see that the element with the xpath "//div[@class='i_contain_class']" contains exactly "I has."
          And I should see that the link to "http://example.com" contains exactly "example"
          And I should see that the link to the url "http://example.com" contains exactly "example"
          And I should see that the link to the partial url "example.com" contains exactly "example"
          And I should see that the link to a url that contains "example.com" contains exactly "example"
          And I should see that the link with text "example" contains exactly "example"
          And I should see that the link with the text "example" contains exactly "example"
          And I should see that the link called "example" contains exactly "example"
          And I should see that the link with the partial text "ample" contains exactly "example"
          And I should see that the link with text that contains "ample" contains exactly "example"
         # timed
          And I should see that the element named "i_contain_name" contains exactly "I has." within 3 seconds
          And I should see that the element with the id "i_contain" contains exactly "I has." within 3 seconds
          And I should see that the element with the css selector ".i_contain_class" contains exactly "I has." within 3 seconds
          And I should see that the element with the xpath "//div[@class='i_contain_class']" contains exactly "I has." within 3 seconds
          And I should see that the link to "http://example.com" contains exactly "example" within 3 seconds
          And I should see that the link to the url "http://example.com" contains exactly "example" within 3 seconds
          And I should see that the link to the partial url "example.com" contains exactly "example" within 3 seconds
          And I should see that the link to a url that contains "example.com" contains exactly "example" within 3 seconds
          And I should see that the link with text "example" contains exactly "example" within 3 seconds
          And I should see that the link with the text "example" contains exactly "example" within 3 seconds
          And I should see that the link called "example" contains exactly "example" within 3 seconds
          And I should see that the link with the partial text "ample" contains exactly "example" within 3 seconds
          And I should see that the link with text that contains "ample" contains exactly "example" within 3 seconds


    Scenario: 17. Negative test for "contains exactly pattern"
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should not see that the element named "i_contain_name" contains exactly "I have."
          And I should not see that the element with the id "i_contain" contains exactly "I have."
          And I should not see that the element with the css selector ".i_contain_class" contains exactly "I have."
          And I should not see that the element with the xpath "//div[@class='i_contain_class']" contains exactly "I have."
          And I should not see that the link to "http://amazon.com" contains exactly "amazon"
          And I should not see that the link to the url "http://amazon.com" contains exactly "amazon"
          And I should not see that the link to the partial url "amazon.com" contains exactly "amazon"
          And I should not see that the link to a url that contains "amazon.com" contains exactly "amazon"
          And I should not see that the link with text "amazon" contains exactly "amazon"
          And I should not see that the link with the text "amazon" contains exactly "amazon"
          And I should not see that the link called "amazon" contains exactly "amazon"
          And I should not see that the link with the partial text "ample" contains exactly "amazon"
          And I should not see that the link with text that contains "ample" contains exactly "amazon"
         # timed
          And I should not see that the element named "i_contain_name" contains exactly "I have." within 3 seconds
          And I should not see that the element with the id "i_contain" contains exactly "I have." within 3 seconds
          And I should not see that the element with the css selector ".i_contain_class" contains exactly "I have." within 3 seconds
          And I should not see that the element with the xpath "//div[@class='i_contain_class']" contains exactly "I have." within 3 seconds
          And I should not see that the link to "http://amazon.com" contains exactly "amazon" within 3 seconds
          And I should not see that the link to the url "http://amazon.com" contains exactly "amazon" within 3 seconds
          And I should not see that the link to the partial url "amazon.com" contains exactly "amazon" within 3 seconds
          And I should not see that the link to a url that contains "amazon.com" contains exactly "amazon" within 3 seconds
          And I should not see that the link with text "amazon" contains exactly "amazon" within 3 seconds
          And I should not see that the link with the text "amazon" contains exactly "amazon" within 3 seconds
          And I should not see that the link called "amazon" contains exactly "amazon" within 3 seconds
          And I should not see that the link with the partial text "ample" contains exactly "amazon" within 3 seconds
          And I should not see that the link with text that contains "ample" contains exactly "amazon" within 3 seconds


    Scenario Outline: 18.Positive test for the "attribute pattern"
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see that the <finder> has an attribute of "my_attr"
          And I should see that the <finder> has the attribute of "my_attr"
          And I should see that the <finder> has an attribute named "my_attr"
          And I should see that the <finder> has the attribute named "my_attr"
          And I should see that the <finder> has an attribute called "my_attr"
          And I should see that the <finder> has the attribute called "my_attr"
          And I should not see that the <finder> has an attribute of "blub"
          And I should not see that the <finder> has the attribute of "blub"
          And I should not see that the <finder> has an attribute named "blub"
          And I should not see that the <finder> has the attribute named "blub"
          And I should not see that the <finder> has an attribute called "blub"
          And I should not see that the <finder> has the attribute called "blub"
          # timed
          And I should see that the <finder> has an attribute of "my_attr" within 3 seconds
          And I should see that the <finder> has the attribute of "my_attr" within 3 seconds
          And I should see that the <finder> has an attribute named "my_attr" within 3 seconds
          And I should see that the <finder> has the attribute named "my_attr" within 3 seconds
          And I should see that the <finder> has an attribute called "my_attr" within 3 seconds
          And I should see that the <finder> has the attribute called "my_attr" within 3 seconds
          And I should not see that the <finder> has an attribute of "blub" within 3 seconds
          And I should not see that the <finder> has the attribute of "blub" within 3 seconds
          And I should not see that the <finder> has an attribute named "blub" within 3 seconds
          And I should not see that the <finder> has the attribute named "blub" within 3 seconds
          And I should not see that the <finder> has an attribute called "blub" within 3 seconds
          And I should not see that the <finder> has the attribute called "blub" within 3 seconds

    Examples:
        | finder                                                   |
        | element named "i_contain_name"                           |
        | element with the id "i_contain"                          |
        | element with the css selector ".i_contain_class"         |
        | element with the xpath "//div[@class='i_contain_class']" |
        | element with the value "x"                               |
        | link to "http://example.com"                             |
        | link to the url "http://example.com"                     |
        | link to the partial url "example.com"                    |
        | link to a url that contains "example.com"                |
        | link with text "example"                                 |
        | link with the text "example"                             |
        | link called "example"                                    |
        | link with the partial text "ample"                       |
        | link with text that contains "ample"                     |


    Scenario Outline: 19. Test for "attribute value pattern"
        Given I visit the salad test url "browser/elements.html"
         When I look around
         # not timed
         Then I should see that the <finder> has an attribute called "my_attr" with value "me!"
          And I should see that the <finder> has the attribute called "my_attr" with value "me!"
          And I should see that the <finder> has an attribute of "my_attr" with value "me!"
          And I should see that the <finder> has the attribute of "my_attr" with value "me!"
          And I should see that the <finder> has an attribute named "my_attr" with value "me!"
          And I should see that the <finder> has the attribute named "my_attr" with value "me!"
          And I should not see that the <finder> has an attribute called "my_attr" with value "you"
          And I should not see that the <finder> has the attribute called "my_attr" with value "you"
          And I should not see that the <finder> has an attribute of "my_attr" with value "you"
          And I should not see that the <finder> has the attribute of "my_attr" with value "you"
          And I should not see that the <finder> has an attribute named "my_attr" with value "you"
          And I should not see that the <finder> has the attribute named "my_attr" with value "you"
         # timed
          And I should see that the <finder> has an attribute called "my_attr" with value "me!" within 3 seconds
          And I should see that the <finder> has the attribute called "my_attr" with value "me!" within 3 seconds
          And I should see that the <finder> has an attribute of "my_attr" with value "me!" within 3 seconds
          And I should see that the <finder> has the attribute of "my_attr" with value "me!" within 3 seconds
          And I should see that the <finder> has an attribute named "my_attr" with value "me!" within 3 seconds
          And I should see that the <finder> has the attribute named "my_attr" with value "me!" within 3 seconds
          And I should not see that the <finder> has an attribute called "my_attr" with value "you" within 3 seconds
          And I should not see that the <finder> has the attribute called "my_attr" with value "you" within 3 seconds
          And I should not see that the <finder> has an attribute of "my_attr" with value "you" within 3 seconds
          And I should not see that the <finder> has the attribute of "my_attr" with value "you" within 3 seconds
          And I should not see that the <finder> has an attribute named "my_attr" with value "you" within 3 seconds
          And I should not see that the <finder> has the attribute named "my_attr" with value "you" within 3 seconds

    Examples:
        | finder                                                |
        | element named "i_attr_name"                           |
        | element with the id "i_attr"                          |
        | element with the css selector ".i_attr_class"         |
        | element with the xpath "//div[@class='i_attr_class']" |
        | element with the value "x"                            |
        | link to "http://example.com"                          |
        | link to the url "http://example.com"                  |
        | link to the partial url "example.com"                 |
        | link to a url that contains "example.com"             |
        | link with text "example"                              |
        | link with the text "example"                          |
        | link called "example"                                 |
        | link with the partial text "ample"                    |
        | link with text that contains "ample"                  |


    Scenario: 20. Visibility of elements
        Given I visit the salad test url "browser/invisible_elements.html"
          And I should see the element with the id "loading_status" within 3 seconds
         When I look around
         Then I should see the element with the id "ready_status" within 5 seconds
          And I should not see the element with the id "loading_status"


    Scenario: 21. Element polling for disappearance
        Given I visit the salad test url "browser/element_waiter.html"
         When I look around
         Then I should see the element with the id "disappear_ele"
          And I should not see the element with the id "appear_ele"
          And I should not see the element with the id "disappear_ele" within 10 seconds
          And I should see the element with the id "appear_ele" within 10 seconds


    Scenario: 22. Element attribute / text polling for disappearance
        Given I visit the salad test url "browser/element_waiter.html"
         When I look around
         Then I should see <thing>
          And I should not see <thing> within 10 seconds

    Examples:
        | thing                                                                                           |
        | that the element with the id "disappear_attr" has an attribute called "myattr" with value "you" |
        | that the element with the id "disappear_attr" contains exactly "appearances"                    |


    Scenario Outline: 23. Element attribute / text polling for appearance
        Given I visit the salad test url "browser/element_waiter.html"
         When I look around
         Then I should not see <thing>
          And I should see the element with the id "appear_attr"
          And I should see that the element with the id "appear_attr" has an attribute called "myattr"
          And I should see <thing> within 10 seconds

    Examples:
        | thing                                                                                        |
        | that the element with the id "appear_attr" contains exactly "can be deceiving"               |
        | that the element with the id "appear_attr" has an attribute called "myattr" with value "you" |
