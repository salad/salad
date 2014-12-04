Feature: Testing mouse actions
    In order to make sure that the mouse module works
    As a developer
    I test against the page test files


    Scenario: 1. Do nothing
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the element with the id "mouse_target"
          And I wait 1 second


    Scenario Outline: 2. Mouse events for links by css work.
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the link with text that contains "Target Link" within 5 seconds
          And I should see the link with the partial text "Target Link"
          And I should see the link with the text "Mouse Target Link"
         When I <action> the link with the text "Mouse Target Link"
         Then I should see that the element with the id "mouse_action" has the text "<expected_result>" within 5 seconds

    Examples:
        | action        | expected_result |
        | click on      | Clicked         |
        | mouse over    | Moused over     |
        | mouse-over    | Moused over     |
        | mouseover     | Moused over     |


    Scenario: 3. Do nothing
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the element with the id "mouse_target"
          And I wait 1 second


    Scenario Outline: 4. Mouse events by id works.
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the element with the id "mouse_target"
         When I <action> the element with id "mouse_target"
         Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |


    Scenario Outline: 5. Mouse events by name works.
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the element named "mouse_target_name"
         When I <action> the element named "mouse_target_name"
         Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |


    Scenario Outline: 6. Mouse events by css works.
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the element with the css selector ".mouse_target_class"
         When I <action> the element with the css selector ".mouse_target_class"
         Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |


    Scenario Outline: 7. Doubleclick works
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the element with the id "double_click"
         When I <action> the element with id "double_click"
         Then I should see "<expected_result>" somewhere in the page within 5 seconds

    Examples:
        | action       | expected_result |
        | double click | Double-clicked  |
        | double-click | Double-clicked  |
        | doubleclick  | Double-clicked  |


    Scenario Outline: 8. Mouse events by value work.
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the element with the value "mouse input target value"
         When I <action> the element with the value "mouse input target value"
         Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |


    Scenario Outline: 9. Mouse events for links by id work.
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the link to "#mousetargetlink"
         When I <action> the link to "#mousetargetlink"
         Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |


    Scenario Outline: 10. Mouse events for links by name work.
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the link to a url that contains "argetlink"
          And I should see the link to the partial url "argetlink"
         When I <action> the link to a url that contains "argetlink"
         Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |


    Scenario Outline: 11. Mouse out works
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the element with the id "mouse_target"
         When I mouse over the element with id "mouse_target"
          And I <action> the element with id "mouse_target"
         Then I should see "<expected_results>" somewhere in the page within 5 seconds

    Examples:
        | action        | expected_results |
        | mouse out     | Moused out       |
        | mouse-out     | Moused out       |
        | mouseout      | Moused out       |


    Scenario Outline: 12. Mouse events for links by css work.
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the link with the text "Mouse Target Link"
         When I <action> the link with the text "Mouse Target Link"
         Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |


    Scenario: 13. Do nothing
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the element with the id "mouse_target"
          And I wait 1 second
