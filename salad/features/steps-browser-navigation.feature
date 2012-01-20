Feature: Ensuring that the page steps work
    In order to make sure that the page module works
    As a developer
    I test against the page test files

    Scenario: Going to a page works
        Given I visit the salad test url "browser/1.html"
        When I look around
        Then I should see "Page 1 Body" somewhere in the page

    Scenario: Going back works
        Given I visit the salad test url "browser/1.html"
          And I visit the salad test url "browser/2.html"
        When I go back
        Then I should see "Page 1 Body" somewhere in the page

    Scenario: Going forward works
        Given I visit the salad test url "browser/2.html"
          And I visit the salad test url "browser/1.html"
        When I go forward
        Then I should see "Page 1 Body" somewhere in the page

    Scenario: Refreshing works
        Given I visit the salad test url "browser/1.html"
        When I refresh the page
        Then I should see "Page 1 Body" somewhere in the page
