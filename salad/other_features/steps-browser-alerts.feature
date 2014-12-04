Feature: Ensuring that the alert/prompt steps work
    In order to make sure that the page module works
    As a developer
    I test against the page test files


    Scenario Outline: 1. Alerts and prompts work
        Given I visit the salad test url "browser/page.html"
         When I click on the link with the text "<text>"
         Then I should see a <dialog_type> within 3 seconds
    Examples:
        | text    | dialog_type |
        | Alert   | alert       |
        | Prompt  | prompt      |
        | Confirm | alert       |


    Scenario Outline: 2. Alert and prompt negation works
        Given I visit the salad test url "browser/page.html"
         When I click on the link with the text "Nothing"
         Then I should not see a <dialog_type> within 3 seconds
    Examples:
        | dialog_type |
        | alert       |
        | prompt      |


    Scenario Outline: 3. Alert and prompt text-checking (with and without negation) works
        Given I visit the salad test url "browser/page.html"
         When I click on the link with the text "<linktext>"
         Then I should see a <dialog_type> with the text "<infotext>" within 3 seconds
         When I click on the link with the text "<linktext>"
         Then I should see a <dialog_type> that says "<infotext>" within 3 seconds
         When I click on the link with the text "<linktext>"
         Then I should see a <dialog_type> with text that contains "<partial_infotext>" within 3 seconds
         When I click on the link with the text "<linktext>"
          And I should not see a <dialog_type> with the text "Some other text" within 3 seconds
    Examples:
        | linktext | dialog_type | infotext                         | partial_infotext |
        | Alert    | alert       | Alert! Do you like this alert?   | Do you like this |
        | Prompt   | prompt      | What's a number you like?        | a number         |
        | Confirm  | alert       | Confirm! Do you like this alert? | Do you like this |


    Scenario: 4. Prompt entry works (alerts don't have an entry field)
        Given I visit the salad test url "browser/page.html"
         When I click on the link with the text "Prompt"
          And I enter "6" into the prompt
         Then I should see that the element with the id "response_area" has the text "You entered 6"


    Scenario: 5. Prompt entry with stored value works
        Given I visit the salad test url "browser/page.html"
         When I store a random string of length 10 as "some_text"
          And I click on the link with the text "Prompt"
          And I enter the stored value of "some_text" into the prompt
         Then I should see that the element with the id "response_area" has the text "You entered"
          And I should see that the text of the element with the id "response_area" contains the stored value of "some_text"


    Scenario: 6. Confirm confirmation works
        Given I visit the salad test url "browser/page.html"
         When I click on the link with the text "Confirm"
         Then I should see an alert
          And I should see that the element with the id "response_area" has the text "you liked it"


    Scenario Outline: 7. Confirm dialog and prompt cancelling works
        Given I visit the salad test url "browser/page.html"
         When I click on the link with the text "<linktext>"
          And I cancel the <dialog_type>
         Then I should see that the element with the id "response_area" has the text "<response>"
    Examples:
        | linktext | dialog_type | response            |
        | Prompt   | prompt      | Cancelled!          |
        | Confirm  | alert       | you did not like it |


    Scenario Outline: 8. Remembering the content of alerts and prompts works with case option
        Given I visit the salad test url "browser/page.html"
         When I click on the link with the text "<linktext>"
          And I <action> the <case> text of the <dialog_type> as "text"
          And I accept the <dialog_type>
          And I fill in the field with the id "fill_me_in" with the stored value of "text"
         Then I should see that the value of the element with the id "fill_me_in" is "<text>"
    Examples:
        | linktext | dialog_type | action   | case      | text                             |
        | Prompt   | prompt      | store    | uppercase | WHAT'S A NUMBER YOU LIKE?        |
        | Prompt   | prompt      | store    | lowercase | what's a number you like?        |
        | Prompt   | prompt      | remember | uppercase | WHAT'S A NUMBER YOU LIKE?        |
        | Prompt   | prompt      | remember | lowercase | what's a number you like?        |
        | Alert    | alert       | store    | uppercase | ALERT! DO YOU LIKE THIS ALERT?   |
        | Alert    | alert       | store    | lowercase | alert! do you like this alert?   |
        | Alert    | alert       | remember | uppercase | ALERT! DO YOU LIKE THIS ALERT?   |
        | Alert    | alert       | remember | lowercase | alert! do you like this alert?   |
        | Confirm  | alert       | store    | uppercase | CONFIRM! DO YOU LIKE THIS ALERT? |
        | Confirm  | alert       | store    | lowercase | confirm! do you like this alert? |
        | Confirm  | alert       | remember | uppercase | CONFIRM! DO YOU LIKE THIS ALERT? |
        | Confirm  | alert       | remember | lowercase | confirm! do you like this alert? |


    Scenario Outline: 9. Remembering the content of alerts and prompts works
        Given I visit the salad test url "browser/page.html"
         When I click on the link with the text "<linktext>"
          And I <action> the text of the <dialog_type> as "text"
          And I accept the <dialog_type>
          And I fill in the field with the id "fill_me_in" with the stored value of "text"
         Then I should see that the value of the element with the id "fill_me_in" is "<text>"
    Examples:
        | linktext | dialog_type | action   | text                             |
        | Prompt   | prompt      | store    | What's a number you like?        |
        | Alert    | alert       | store    | Alert! Do you like this alert?   |
        | Confirm  | alert       | store    | Confirm! Do you like this alert? |
        | Prompt   | prompt      | remember | What's a number you like?        |
        | Alert    | alert       | remember | Alert! Do you like this alert?   |
        | Confirm  | alert       | remember | Confirm! Do you like this alert? |


    Scenario Outline: 10. Seeing stored values in alerts with case option
        Given I visit the salad test url "browser/page.html"
         When I store a random string of length 10 as "some_text"
          And I store a random string of length 10 as "some_other_text"
          And I fill in the field with the id "fill_me_in" with the stored value of "some_text"
          And I click on the element with the id "make_custom_<dialog_type>"
         Then I should see an alert text that <method> the stored value of "some_text" within 3 seconds
         When I click on the element with the id "make_custom_<dialog_type>"
          And I should not see an alert text that <method> the stored value of "some_other_text" within 3 seconds
         When I click on the element with the id "make_custom_<dialog_type>_upper"
         Then I should see an alert text that <method> the stored uppercase value of "some_text"
         When I click on the element with the id "make_custom_<dialog_type>_lower"
         Then I should see an alert text that <method> the stored lowercase value of "some_text"
         When I click on the element with the id "make_custom_<dialog_type>_random"
         Then I should see an alert text that <method> the stored case independent value of "some_text"
    Examples:
        | dialog_type | method   |
        | alert       | is       |
        | prompt      | is       |
        | confirm     | is       |
        | alert_ex    | contains |
        | prompt_ex   | contains |
        | confirm_ex  | contains |


    Scenario Outline: 11. Accepting alerts and prompt works
        Given I visit the salad test url "browser/page.html"
         When I click on the link with the text "<text>"
         Then I accept the <dialog_type>
    Examples:
        | text    | dialog_type |
        | Alert   | alert       |
        | Prompt  | prompt      |
        | Confirm | alert       |
