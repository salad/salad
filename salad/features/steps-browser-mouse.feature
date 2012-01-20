Feature: Ensuring that the page steps work
    In order to make sure that the page module works
    As a developer
    I test against the page test files

    # Only Chrome supports mouse events.
    # It's only necessary to switch to chrome in the first scenario - it remains after that.
    Scenario: Click by id works
        Given I am using Chrome  
          and I visit the salad test url "browser/mouse.html"
        When I click on the element with id "mouse_target"
        Then I should see "Clicked" somewhere in the page

 