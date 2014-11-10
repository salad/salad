Feature: Ensuring that the page steps work
    In order to make sure that the page module works
    As a developer
    I test against the page test files


    Scenario: 1. Page title works with negation and within x seconds
        Given I visit the salad test url "browser/basic.html"
         When I look around
         Then I should see that the page is titled "My Test Title"
          And I should see that the page title contains "Test"
          And I should not see that the page is titled "Some other title"
          And I should not see that the page title contains "other"
          And I should see that the page is titled "Some other title" within 5 seconds
          And I should not see that the page is titled "My Test Title" within 2 seconds


    Scenario: 2. Page url works with negation and within x seconds
        Given I visit the salad test url "browser/basic.html"
         When I look around
         Then I should see that the url is "http://localhost:9090/browser/basic.html"
          And I should see that the url contains "browser/basic"
          And I should not see that the url is "google.com"
          And I should not see that the url contains "google"
         When I click on the element with the css selector "input"
         Then I should see that the url is "http://localhost:9090/other-url" within 5 seconds
          And I should see that the url contains "other-url" within 5 seconds
          And I should not see that the url is "http://localhost:9090/browser/basic.html" within 2 seconds
          And I should not see that the url contains "browser/basic" within 2 seconds


    Scenario: 3. Page body works with negation and within x seconds
        Given I visit the salad test url "browser/basic.html"
         When I look around
         Then I should see that the page html contains "<title>My Test Title</title>"
          And I should not see that the page html contains "<title>Some other title</title>"
          And I should see that the page html contains "<title>Some other title</title>" within 5 seconds
          And I should not see that the page html is "some random text"


    Scenario: 4. Switching to an iframe works
        Given I visit the salad test url "browser/iframe.html"
         When I switch to the iframe "my_iframe"
         Then I should see "iFrame Page" somewhere in the page
          And I should not see "Main Page" somewhere in the page


    Scenario: 5. Switching to an iframe, then back to the parent frame works
        Given I visit the salad test url "browser/iframe.html"
         When I switch to the iframe "my_iframe"
          And I switch back to the parent frame
         Then I should see "Main Page" somewhere in the page
          And I should not see "iFrame Page" somewhere in the page
