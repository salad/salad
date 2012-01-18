Feature: Ensuring that other browsers work
    In order to make sure that other browsers work
    As a developer
    I search for the Wieden+Kennedy website using zope and firefox

    Scenario: Opening the W+K website works
        Given I am using zope
         And I access the url "http://www.google.com/"
        When I I fill in "q" with "Wieden Kennedy"
          And I wait 1 second
        Then I should not see "www.wk.com"

    Scenario: Opening the W+K website works
        Given I am using firefox
          And I access the url "http://www.google.com/"
        When I I fill in "q" with "Wieden Kennedy"
          And I wait 1 second
        Then I should see "www.wk.com"