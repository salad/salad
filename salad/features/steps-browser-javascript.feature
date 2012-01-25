Feature: Ensuring that the javascript steps work
    In order to make sure that the javascript module works
    As a developer
    I test against the javascript test files

    Scenario: Run js works
        Given I visit the salad test url "browser/js.html"
        When I run the javascript "document.getElementById('js_block').innerHTML = 'js works!';"
        Then I should see "js works!" somewhere in the page

    Scenario: Evaluate js works
        Given I visit the salad test url "browser/js.html"
        When I look around
        Then I should see that running the javascript "1+1" returns "2"

    Scenario: Evaluate js negation works
        Given I visit the salad test url "browser/js.html"
        When I look around
        Then I should not see that running the javascript "1+1" returns "4"

    Scenario: Run js does not work in a js-disabled browser
        Given I am using zope
          And visit the salad test url "browser/js.html"
        When I run the javascript "document.getElementById('js_block').innerHTML = 'js works!';"
        Then I should not see "js works!" somewhere in the page
