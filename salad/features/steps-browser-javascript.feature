Feature: Ensuring that the javascript steps work
    In order to make sure that the javascript module works
    As a developer
    I test against the javascript test files

    Scenario: 1. Run js works
        Given I visit the salad test url "browser/js.html"
         When I run the javascript "document.getElementById('js_block').innerHTML = 'js works!';"
         Then I should see "js works!" somewhere in the page

    Scenario: 2. Evaluate js works
        Given I visit the salad test url "browser/js.html"
         When I look around
         Then I should see that running the javascript "1+1" returns "2"

    Scenario: 3. Evaluate js negation works
        Given I visit the salad test url "browser/js.html"
         When I look around
         Then I should not see that running the javascript "1+1" returns "4"

    Scenario: 4. Within X seconds works
        Given I visit the salad test url "browser/js.html"
         When I look around
         Then I should not see the element with the id "js2_block"
          And I should see that running the javascript "document.getElementById('js2_block').style.visibility" returns "hidden"
          And I should see that running the javascript "document.getElementById('js2_block').style.visibility" returns "visible" within 5 seconds
          And I should see the element with the id "js2_block" within 5 seconds
          And I should not see that running the javascript "1+1" returns "3" within 3 seconds
