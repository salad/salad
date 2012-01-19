Feature: Ensuring that all of salad's steps behave as they're expected to
    In order to make sure that lettuce works
    As a developer
    I run the suite that tests all of its steps

    Scenario: Running the first test.
        Given I access the url "http://www.google.com/"
        When I look around
        Then I should fail because "this test isn't done."

