Feature: Ensuring that the page steps work
    In order to make sure that the page module works
    As a developer
    I test against the page test files

    Scenario: Going to a page works
        Given I access the salad test url "browser/basic.html"
        When I look around
        Then I should see that the page is titled "My Test Title"

    Scenario: Going back works
        Given I access the salad test url "browser/basic.html"
        When I look around
        Then I should see that the page is titled "My Test Title"

    Scenario: Going forward works
        Given I access the salad test url "browser/basic.html"
        When I look around
        Then I should see that the page is titled "My Test Title"

    Scenario: Refreshing works
        Given I access the salad test url "browser/basic.html"
        When I look around
        Then I should see that the page is titled "My Test Title"
