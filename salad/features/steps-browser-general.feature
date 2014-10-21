Feature: Test the general steps

    Scenario: 1. Test the general steps
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should see the element with the id "i_contain"
         When I wait 1 second
         Then I print out "hello world"
         When I remember the text of the element with the id "i_contain" as "my_text"
         Then I print out the stored value of "my_text"

    Scenario: 2. This test should fail!
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I should fail because "This step does not make sense"
