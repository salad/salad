Feature: Ensuring that salad works, and Google's website loads
    In order to make sure that lettuce works
    As a developer
    I open the Google website using lettuce

    Scenario: Opening the google website works
        Given I am using firefox
          And I visit the url "http://www.google.com/"
        When I look around
        Then I should see "About Google" somewhere in the page

