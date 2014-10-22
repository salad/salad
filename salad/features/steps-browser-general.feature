Feature: Test the general steps and take screenshot step

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


    Scenario: 3. Take a screenshot
        Given I visit the salad test url "browser/elements.html"
         When I look around
         Then I take a screenshot
          And I take a screenshot named "my_screenshot"
          And I take a screenshot with timestamp
          And I take a screenshot named "bla" with timestamp
