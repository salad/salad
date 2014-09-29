Feature: Ensuring that javascript works in all supported browsers
    In order to make sure that javascript works
    As a developer
    I visit a page with javascript and the script should be executed

    Scenario Outline: The javascript rendered "Test" should be visible
        Given I am using <browser>
         When I visit the salad test url "browser/js.html"
          And I wait 1 second
         Then I should see "Test" somewhere in the page

    Examples:
    | browser   |
    | chrome    |
    | firefox   |
    | phantomjs |
