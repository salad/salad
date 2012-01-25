Feature: Ensuring that the page steps work
    In order to make sure that the page module works
    As a developer
    I test against the page test files

    # Test selection of drag & drop
    Scenario Outline: Drag and drop selectors work
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I drag the element named "drag_handler_name" and drop it on the element named "drag_target_name"
        Then I should see "Dropped on me!" somewhere in the page


    Scenario Outline: Drag and drop selectors work
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I drag the element with the id "drag_handler" and drop it on the element with the id "drag_target"
        Then I should see "Dropped on me!" somewhere in the page


    Scenario Outline: Drag and drop selectors work
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I drag the element with the css selector ".drag_handler_class" and drop it on the element with the css selector ".drag_target_class"
        Then I should see "Dropped on me!" somewhere in the page


     Scenario Outline: Drag and drop to a non-target
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I drag the element named "drag_handler_name" and drop it on the element named "drag_not_target_name"
        Then I should not see "Dropped on me!" somewhere in the page



