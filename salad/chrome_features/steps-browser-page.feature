Feature: Ensuring that the page steps work
    In order to make sure that the page module works
    As a developer
    I test against the page test files

    Scenario: Page body works
        # FF does weird things to the header.
        Given I am using chrome
          And visit the salad test url "browser/basic.html"
        When I look around
        Then I should see that the page html is "<html><head><title>My Test Title</title></head><body></body></html>"

