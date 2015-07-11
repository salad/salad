Feature: Ensuring that selecting the XX. element of something works
    In order to make sure that the elements module works
    As a developer
    I test against the form test files

    Scenario Outline: Mouse over some ordinal element works
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I mouseover the <ordinal> element named "mouse_target_name"
        Then I should see "<expected_results>" somewhere in the page

# Mouse
    Examples:
        | ordinal   | expected_results |
        | first     | Moused over      |
        | 1st       | Moused over      |
        | 2nd       | Moused over 2    |
        | last      | Moused over 2    |
