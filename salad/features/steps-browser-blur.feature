Feature: Make sure the focus and blur steps work


    Scenario: 17. Focusing and blurring works
        Given I visit the salad test url "browser/form.html"
         When I look around
         Then I should see the element named "focus_me_name"
          And I should not see "Focused!" anywhere in the page
         When I focus on the element named "focus_me_name"
         Then I should see "Focused!" somewhere in the page within 5 seconds
          And I should see that running the javascript "document.activeElement.tagName" returns "INPUT"
         When I <blur_wording> from the element named "input_target_name"
         Then I should see "Blurred!" somewhere in the page within 5 seconds
          And I should see that running the javascript "document.activeElement.tagName" returns "BODY"

    Examples:
        | blur_wording |
        | blur         |
        | move         |
