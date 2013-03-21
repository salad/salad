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
        When I drag the element with the id "drag_handler" and drop it on the element named "drag_target_name2"
        Then I should see "Dropped on me 2!" somewhere in the page

    Scenario Outline: Drag and drop selectors work
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I drag the 2nd element with the css selector ".drag_handler_class" and drop it on the 1st element with the css selector ".drag_target_class"
        Then I should see "Dropped on me!" somewhere in the page

     Scenario Outline: Drag and drop to a non-target
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I drag the element named "drag_handler_name" and drop it on the element named "drag_not_target_name"
        Then I should not see "Dropped on me!" somewhere in the page

     Scenario Outline: Drag and drop to a non-target
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I drag the first element named "drag_handler_name2" and drop it on the last element with css selector ".drag_target_class"
        Then I should see "Dropped on me 4!" somewhere in the page

     Scenario Outline: Drag and drop to a non-target
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I drag the 4th element with css selector ".drag_handler_class" and drop it on the 3rd element with css selector ".drag_target_class"
        Then I should see "Dropped on me 3!" somewhere in the page
