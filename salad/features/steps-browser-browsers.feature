Feature: Ensuring that other browsers work
    In order to make sure that other browsers work
    As a developer
    I search for the Wieden+Kennedy website using zope and firefox

    Scenario: Searching for W+K on Google with JS disabled does not auto-load the search results
        Given I am using zope
         And I visit the url "http://www.google.com/"
        When I fill in the field named "q" with "Wieden Kennedy"
          And I wait 1 second
        Then I should not see "www.wk.com" somewhere in the page

    Scenario: Searching for W+K on Google with JS enabled (firefox) does auto-load the search results
        Given I am using firefox
          And I visit the url "http://www.google.com/"
        When I fill in the field named "q" with "Wieden Kennedy"
          And I wait 1 second
        Then I should see "www.wk.com" somewhere in the page

    Scenario: Searching for W+K on Google with JS enabled (chrome) does auto-load the search results
        Given I am using chrome
          And I visit the url "http://www.google.com/"
        When I fill in the field named "q" with "Wieden Kennedy"
          And I wait 1 second
        Then I should see "www.wk.com" somewhere in the page