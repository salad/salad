Feature: Ensuring that the page steps work
    In order to make sure that the page module works
    As a developer
    I test against the page test files

    Scenario: Page title works
        Given I visit the salad test url "browser/basic.html"
        When I look around
        Then I should see that the page is titled "My Test Title"

    Scenario: Page title negation works
        Given I visit the salad test url "browser/basic.html"
        When I look around
        Then I should not see that the page is titled "Some random thing"

    Scenario: Page url works
        Given I visit the salad test url "browser/basic.html"
        When I look around
        Then I should see that the url is "http://localhost:9090/browser/basic.html"

    Scenario: Page url negation works
        Given I visit the salad test url "browser/basic.html"
        When I look around
        Then I should not see that the url is "google.com"

    Scenario: Page body negation works
        Given I visit the salad test url "browser/basic.html"
        When I look around
        Then I should not see that the page html is "some random text"

    Scenario: Alerts work
        Given I visit the salad test url "browser/page.html"
        When I click on the link with the text "Alert"
        Then I should see an alert

    Scenario: Alert negation works
        Given I visit the salad test url "browser/page.html"
        When I click on the link with the text "Nothing"
        Then I should not see an alert

    Scenario: Alert text checking works
        Given I visit the salad test url "browser/page.html"
        When I click on the link with the text "Alert"
        Then I should see an alert with the text "My Test Alert"

    Scenario: Alert text checking works
        Given I visit the salad test url "browser/page.html"
        When I click on the link with the text "Alert"
        Then I should not see an alert with the text "Someone else's alert"

    Scenario: Prompts work
        Given I visit the salad test url "browser/page.html"
        When I click on the link with the text "Prompt me"
        Then I should see a prompt

    Scenario: Prompt negation works
        Given I visit the salad test url "browser/page.html"
        When I click on the link with the text "Nothing"
        Then I should not see a prompt

    Scenario: Prompts text-checking works
        Given I visit the salad test url "browser/page.html"
        When I click on the link with the text "Prompt me"
        Then I should see a prompt with the text "What's a number you like?"

    Scenario: Prompts text-checking negation works
        Given I visit the salad test url "browser/page.html"
        When I click on the link with the text "Nothing"
        Then I should not see a prompt

    Scenario: Prompt entry works
        Given I visit the salad test url "browser/page.html"
        When I click on the link with the text "Prompt me"
          And I enter "5" into the prompt
        Then I should see "You entered 5" somewhere in the page.

    Scenario: Prompts cancelling works
        Given I visit the salad test url "browser/page.html"
        When I click on the link with the text "Prompt me"
          And I cancel the prompt
        Then I should see "Cancelled!" somewhere in the page.

    Scenario: Switching to an iframe works
        Given I visit the salad test url "browser/iframe.html"
        When I switch to the iframe "my_iframe"
        Then I should see "iFrame Page" somewhere in the page.
          And I should not see "Main Page" somewhere in the page.

    Scenario: Switching to an iframe, then back to the parent frame works
        Given I visit the salad test url "browser/iframe.html"
        When I switch to the iframe "my_iframe"
          And I switch back to the parent frame
        Then I should see "Main Page" somewhere in the page.
          And I should not see "iFrame Page" somewhere in the page.
