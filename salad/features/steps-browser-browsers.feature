Feature: Ensuring that other browsers work
    In order to make sure that other browsers work
    As a developer
    I search for the Wieden+Kennedy website using zope and firefox

    Scenario: Searching for W+K on Google with JS disabled does not auto-load the search results
        Given I am using zope
        When I visit the salad test url "browser/js.html"
        Then I should not see "Test" somewhere in the page

    Scenario: Searching for W+K on Google with JS enabled (firefox) does auto-load the search results
        Given I am using firefox
        When I visit the salad test url "browser/js.html"
          And I wait 1 second
        Then I should see "Test" somewhere in the page

    Scenario: Searching for W+K on Google with JS enabled (chrome) does auto-load the search results
        Given I am using chrome
        When I visit the salad test url "browser/js.html"
          And I wait 1 second
        Then I should see "Test" somewhere in the page