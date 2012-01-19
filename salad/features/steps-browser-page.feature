Feature: Ensuring that the page steps work
    In order to make sure that the page module works
    As a developer
    I test against the page test files

    Scenario: Page title works
        Given I access the salad test url "browser/basic.html"
        When I look around
        Then I should see that the page is titled "My Test Title"

    Scenario: Page title negation works
        Given I access the salad test url "browser/basic.html"
        When I look around
        Then I should not see that the page is titled "Some random thing"

    Scenario: Page url works
        Given I access the salad test url "browser/basic.html"
        When I look around
        Then I should see that the url is "http://localhost:9990/browser/basic.html"

    Scenario: Page url negation works
        Given I access the salad test url "browser/basic.html"
        When I look around
        Then I should not see that the url is "google.com"

    Scenario: Page body works
        Given I access the salad test url "browser/basic.html"
        When I look around
        Then I should see that the page html is "<html><head><title>My Test Title</title></head><body></body></html>"

    Scenario: Page body negation works
        Given I access the salad test url "browser/basic.html"
        When I look around
        Then I should not see that the page html is "some random text"