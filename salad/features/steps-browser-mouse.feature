Feature: Ensuring that the page steps work
    In order to make sure that the page module works
    As a developer
    I test against the page test files

    Scenario Outline: Mouse events by id works.
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I <action> the element with id "mouse_target"
        Then I should see "<expected_results>" somewhere in the page

    # Elements

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |
    
    Scenario Outline: Mouse events by name works.
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I <action> the element named "mouse_target_name"
        Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |

    Scenario Outline: Mouse events by css works.
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I <action> the element with the css selector ".mouse_target_class"
        Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |

    # Find by value currently broken in splinter
    # https://github.com/cobrateam/splinter/pull/83
    #Scenario Outline: Mouse events by value work.
    #    Given I am using Firefox
    #      And I visit the salad test url "browser/mouse.html"
    #    When I <action> the element with the value "mouse input target value"
    #    Then I should see "<expected_results>" somewhere in the page

    #Examples:
    #    | action        | expected_results |
    #    | click on      | Clicked          |
    #    | mouse over    | Moused over      |
    #    | mouse-over    | Moused over      |
    #    | mouseover     | Moused over      |

    # Links
    Scenario Outline: Mouse events for links by id work.
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I <action> the link to "#mousetargetlink"
        Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |
    
    Scenario Outline: Mouse events for links by name work.
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I <action> the link to a url that contains "argetlink"
        Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |

    Scenario Outline: Mouse events for links by css work.
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I <action> the link with the text "Mouse Target Link"
        Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |

    Scenario Outline: Mouse events for links by css work.
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I <action> the link with text that contains "Target Link"
        Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | click on      | Clicked          |
        | mouse over    | Moused over      |
        | mouse-over    | Moused over      |
        | mouseover     | Moused over      |



    Scenario Outline: Mouse out works
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I mouse over the element with id "mouse_target" 
          And I <action> the element with id "mouse_target"
        Then I should see "<expected_results>" somewhere in the page

    Examples:
        | action        | expected_results |
        | mouse out     | Moused out       |
        | mouse-out     | Moused out       |
        | mouseout      | Moused out       |


    Scenario: Doubleclick works
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I click the element with id "double_click"
          And I click the element with id "double_click"
        Then I should see "Double-clicked" somewhere in the page

    