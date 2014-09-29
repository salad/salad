Feature: Ensuring that the forms steps work
    In order to make sure that the form focus/blure module works
    As a developer
    I test against the form test files

    Scenario: Focusing works
        Given I am using chrome
          And I visit the salad test url "browser/form.html"
         When I click on the field named "focus_me_name"
          And I click on the field named "focus_me_name"
          And I wait 2 seconds
         Then I should see "Focused!" somewhere in the page

    Scenario: Blurring works
        Given I am using chrome
          And I visit the salad test url "browser/form.html"
         When I click on the field named "focus_me_name"
          And I wait 1 seconds
          And I click on the element named "input_target_name"
          And I wait 2 seconds
         Then I should see "Blurred!" somewhere in the page
