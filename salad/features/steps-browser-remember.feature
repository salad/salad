Feature: Ensuring that the remember / recall steps work
    In order to make sure that the remember part of the form module works
    As a developer
    I test against the form test files

    Scenario: 1. Filling in a field with random content and recalling the partial content
        Given I visit the salad test url "browser/form.html"
          And I look around
         # --- string with length
         # --- test element contains string / element is string
         When I store a random <what> of length 20 as "string_with_length"
          And I fill in the 1st element named "fill_me_in" with the stored value of "string_with_length"
          And I fill in the 2nd element named "fill_me_in" with the stored value of "string_with_length"
          And I run the javascript "document.getElementsByName('fill_me_in')[0].value = 'blablabla' + document.getElementsByName('fill_me_in')[0].value + 'blablabla';"
         Then I should see that the value of the field named "fill_me_in" contains the stored value of "string_with_length"
          And I should not see that the value of the field named "fill_me_in" is the stored value of "string_with_length"
         # --- test element is lowercase string
         When I run the javascript "document.getElementsByName('fill_me_in')[0].value = document.getElementsByName('fill_me_in')[1].value.toLowerCase();"
         Then I should see that the value of the element named "fill_me_in" is the stored lowercase value of "string_with_length"
          And I should see that the value of the element named "fill_me_in" contains the stored lowercase value of "string_with_length"
         # --- test element contains lowercase string
         When I run the javascript "document.getElementsByName('fill_me_in')[0].value = 'blablabla' + document.getElementsByName('fill_me_in')[1].value.toLowerCase() + 'blablabla';"
         Then I should see that the value of the element named "fill_me_in" contains the stored lowercase value of "string_with_length"
          And I should not see that the value of the element named "fill_me_in" is the stored lowercase value of "string_with_length"
          And I fill in the 2nd element named "fill_me_in" with ""
         # --- string without length or suffix
         When I store a random <what> as "string"
          And I fill in the 2nd element with the xpath "//div[@id='fill_in']/input" with the stored value of "string"
         Then I should see that the value of the 2nd field named "fill_me_in" is the stored value of "string"
         # --- string with suffix
         When I store a random <what> with suffix " suffix" as "string_with_suffix"
          And I fill in the 3rd element named "fill_me_in" with the stored value of "string_with_suffix"
         Then I should see that the value of the 3rd field named "fill_me_in" is the stored value of "string_with_suffix"
         # --- string with length and suffix
         When I store a random <what> of length 10 with suffix " restaurant" as "string_with_length_and_suffix"
          And I fill in the 4th element named "fill_me_in" with the stored value of "string_with_length_and_suffix"
         Then I should see that the value of the last field named "fill_me_in" is the stored value of "string_with_length_and_suffix"

    Examples:
        | what   |
        | string |
        | email  |
        | name   |


    Scenario: 2. Filling in a field with random uppercase/lowercase content
        Given I visit the salad test url "browser/form.html"
          And I look around
         When I store a random <upper_lower> <what> as "my_random_thing"
          And I fill in the 1st element named "fill_me_in" with the stored value of "my_random_thing"
          And I run the javascript "$('#free_fill_space').text($('#fill_in_1').val())"

    Examples:
        | upper_lower | what                        |
        | uppercase   | email of length 10          |
        | uppercase   | email                       |
        | uppercase   | email with suffix "SUFFIX"  |
        | lowercase   | email of length 10          |
        | lowercase   | email                       |
        | lowercase   | email with suffix "SUFFIX"  |
        | uppercase   | name of length 10           |
        | uppercase   | name                        |
        | uppercase   | name with suffix "SUFFIX"   |
        | lowercase   | name of length 10           |
        | lowercase   | name                        |
        | lowercase   | name with suffix "SUFFIX"   |
        | uppercase   | string of length 10         |
        | uppercase   | string                      |
        | uppercase   | string with suffix "SUFFIX" |
        | lowercase   | string of length 10         |
        | lowercase   | string                      |
        | lowercase   | string with suffix "SUFFIX" |


    Scenario Outline: 3. Remembering content of elements and recalling it
        Given I visit the salad test url "browser/form.html"
          And I look around
         When I <wording> the <what> of the element with the css selector "<finder>" as "<name>"
         Then I should see that the <what> of the element with the css selector "<finder>" is the stored value of "<name>"
          And I should see that the <what> of the element with the css selector "<finder>" is "<value>"

    Examples:
        | what  | name     | value                            | finder            | wording  |
        | value | my_value | This is the value                | fieldset input    | store    |
        | text  | my_text  | This is the text: 123!           | fieldset textarea | store    |
        | html  | my_html  | Element with value / html / text | fieldset legend   | store    |
        | value | my_value | This is the value                | fieldset input    | remember |
        | text  | my_text  | This is the text: 123!           | fieldset textarea | remember |
        | html  | my_html  | Element with value / html / text | fieldset legend   | remember |


    Scenario Outline: 4. Remembering uppercase/lowercase content of elements and recalling it
        Given I visit the salad test url "browser/form.html"
          And I look around
         When I remember the <upper_lower> <what> of the element with the css selector "<finder>" as "<name>"
          And I fill in the field named "fill_me_in" with the stored value of "<name>"
         Then I should not see that the <what> of the element with the css selector "<finder>" is the stored value of "<name>"
          And I should see that the <what> of the element with the css selector "<finder>" is "<value>"
          And I should not see that the <what> of the element with the css selector "<finder>" is "<value_with_case>"
          And I should see that the value of the element named "fill_me_in" is the stored value of "<name>"
          And I should see that the value of the element named "fill_me_in" is "<value_with_case>"

    Examples:
        | what        | name           | value                                             | finder            | upper_lower | value_with_case                                   |
        | value       | my_value       | This is the value                                 | fieldset input    | uppercase   | THIS IS THE VALUE                                 |
        | text        | my_text        | This is the text: 123!                            | fieldset textarea | uppercase   | THIS IS THE TEXT: 123!                            |
        | html        | my_html        | Element with value / html / text                  | fieldset legend   | uppercase   | ELEMENT WITH VALUE / HTML / TEXT                  |
        | outer html  | my_outer_html  | <legend>Element with value / html / text</legend> | fieldset legend   | uppercase   | <LEGEND>ELEMENT WITH VALUE / HTML / TEXT</LEGEND> |
        | value       | my_value       | This is the value                                 | fieldset input    | lowercase   | this is the value                                 |
        | text        | my_text        | This is the text: 123!                            | fieldset textarea | lowercase   | this is the text: 123!                            |
        | html        | my_html        | Element with value / html / text                  | fieldset legend   | lowercase   | element with value / html / text                  |
        | outer html  | my_outer_html  | <legend>Element with value / html / text</legend> | fieldset legend   | lowercase   | <legend>element with value / html / text</legend> |


    Scenario Outline: 5. Remembering a value and seeing it in some element as lowercase / uppercase / case independent / original string
        Given I visit the salad test url "browser/form.html"
         When I look around
         Then I should see the element with the css selector "fieldset input"
         When I fill in the element named "fill_me_in" with "Jana Banana"
          And I store the value of the element named "fill_me_in" as "my_input"
          And I remember a random string as "not_my_input"
         # --- lowercase
          And I fill in the element named "fill_me_in" with "<lower>"
         Then I should see that the value of the element named "fill_me_in" <type_of_match> the stored lowercase value of "my_input" within 2 seconds
          And I should not see that the value of the element named "fill_me_in" <type_of_match> the stored lowercase value of "not_my_input" within 2 seconds
          And I should see that the value of the element named "fill_me_in" <type_of_match> "jana banana" within 2 seconds
          And I should not see that the value of the element named "fill_me_in" <type_of_match> "captain rodriguez" within 2 seconds
         # --- uppercase
         When I fill in the element named "fill_me_in" with "<upper>"
         Then I should see that the value of the element named "fill_me_in" <type_of_match> the stored uppercase value of "my_input"
          And I should see that the value of the element named "fill_me_in" <type_of_match> "JANA BANANA"
         # --- case independent
         When I fill in the element named "fill_me_in" with "<independent>"
         Then I should see that the value of the element named "fill_me_in" <type_of_match> the stored case independent value of "my_input"
          And I should see that the value of the element named "fill_me_in" <type_of_match> "jAnA BAnaNa"
         # --- original value
         When I fill in the element named "fill_me_in" with "<original>"
         Then I should see that the value of the element named "fill_me_in" <type_of_match> the stored value of "my_input"
          And I should see that the value of the element named "fill_me_in" <type_of_match> "Jana Banana"

    Examples:
        | type_of_match | original              | lower                 | upper                 | independent           |
        | is            | Jana Banana           | jana banana           | JANA BANANA           | jAnA BAnaNa           |
        | contains      | Lala Jana Banana laLa | Lala jana banana laLa | Lala JANA BANANA laLa | Lala jAnA BAnaNa laLa |


    Scenario Outline: 6. Remembering a string and seeing it in some html / text / value as lowercase / uppercase / case independent / original string
        Given I visit the salad test url "browser/form.html"
         When I look around
         Then I should see the element with the css selector "div[id='98kls43mk'] textarea"
         When I fill in the element named "fill_me_in" with "Jana Banana"
          And I store the value of the element named "fill_me_in" as "my_input"
          And I remember a random string as "not_my_input"
         # --- fill in the html of an element with the string we want to see
          And I run the javascript "$('#98kls43mk textarea').html('<lower>')"
         # --- lowercase
         Then I should see that the <what> of the element with the css selector "div[id='98kls43mk'] textarea" <type_of_match> the stored lowercase value of "my_input" within 2 seconds
          And I should see that the <what> of the element with the css selector "div[id='98kls43mk'] textarea" <type_of_match> "jana banana" within 2 seconds
          And I should not see that the <what> of the element with the css selector "div[id='98kls43mk'] textarea" <type_of_match> the stored lowercase value of "not_my_input" within 2 seconds
          And I should not see that the <what> of the element named "fill_me_in" <type_of_match> "captain rodriguez" within 2 seconds
         # --- uppercase
         When I run the javascript "$('#98kls43mk textarea').html('<upper>')"
         Then I should see that the <what> of the element with the css selector "div[id='98kls43mk'] textarea" <type_of_match> the stored uppercase value of "my_input"
          And I should see that the <what> of the element with the css selector "div[id='98kls43mk'] textarea" <type_of_match> "JANA BANANA"
         # --- case independent
         When I run the javascript "$('#98kls43mk textarea').html('<independent>')"
         Then I should see that the <what> of the element with the css selector "div[id='98kls43mk'] textarea" <type_of_match> the stored case independent value of "my_input"
          And I should see that the <what> of the element with the css selector "div[id='98kls43mk'] textarea" <type_of_match> "jAnA BAnaNa"
         # --- original value
         When I run the javascript "$('#98kls43mk textarea').html('<original>')"
         Then I should see that the <what> of the element with the css selector "div[id='98kls43mk'] textarea" <type_of_match> the stored value of "my_input"
          And I should see that the <what> of the element with the css selector "div[id='98kls43mk'] textarea" <type_of_match> "Jana Banana"

    Examples:
        | type_of_match | original              | lower                 | upper                 | independent           | what  |
        | is            | Jana Banana           | jana banana           | JANA BANANA           | jAnA BAnaNa           | html  |
        | contains      | Lala Jana Banana laLa | Lala jana banana laLa | Lala JANA BANANA laLa | Lala jAnA BAnaNa laLa | html  |
        | is            | Jana Banana           | jana banana           | JANA BANANA           | jAnA BAnaNa           | value |
        | contains      | Lala Jana Banana laLa | Lala jana banana laLa | Lala JANA BANANA laLa | Lala jAnA BAnaNa laLa | value |
        | is            | Jana Banana           | jana banana           | JANA BANANA           | jAnA BAnaNa           | text  |
        | contains      | Lala Jana Banana laLa | Lala jana banana laLa | Lala JANA BANANA laLa | Lala jAnA BAnaNa laLa | text  |


    Scenario Outline: 7. Remembering a string and seeing it in some outer html as lowercase / uppercase / case independent / original string
        Given I visit the salad test url "browser/form.html"
         When I look around
         Then I should see the element with the css selector "div[id='98kls43mk'] textarea"
         When I run the javascript "$('#98kls43mk textarea').replaceWith('<original>')"
          And I store the outer html of the element with the css selector "div[id='98kls43mk'] textarea" as "my_html"
          And I store the text of the element with the css selector "div[id='98kls43mk'] textarea" as "my_input"
          And I remember a random string as "not_my_input"
         # --- lowercase
          And I run the javascript "$('#98kls43mk textarea').html('<lower_input>')"
         Then I should see that the outer html of the element with the css selector "div[id='98kls43mk'] textarea" contains the stored lowercase value of "my_input" within 2 seconds
          And I should see that the outer html of the element with the css selector "div[id='98kls43mk'] textarea" is "<lower>"
          And I should see that the outer html of the element with the css selector "div[id='98kls43mk'] textarea" contains "<lower_input>"
         # --- also test negative case
          And I should not see that the outer html of the element with the css selector "div[id='98kls43mk'] textarea" is the stored lowercase value of "not_my_input" within 2 seconds
          And I should not see that the outer html of the element named "fill_me_in" is "captain rodriguez"
         # --- uppercase
         When I run the javascript "$('#98kls43mk textarea').html('<upper_input>')"
         Then I should see that the outer html of the element with the css selector "div[id='98kls43mk'] textarea" contains the stored uppercase value of "my_input" within 2 seconds
          And I should see that the outer html of the element with the css selector "div[id='98kls43mk'] textarea" contains "<upper_input>"
         # --- case independent
         When I run the javascript "$('#98kls43mk textarea').html('<mixed_input>')"
          And I should see that the outer html of the element with the css selector "div[id='98kls43mk'] textarea" contains the stored case independent value of "my_input" within 2 seconds
          And I should see that the outer html of the element with the css selector "div[id='98kls43mk'] textarea" contains "<mixed_input>"
         # --- original value
         When I run the javascript "$('#98kls43mk textarea').html('<orig_input>')"
          And I should see that the outer html of the element with the css selector "div[id='98kls43mk'] textarea" is the stored value of "my_html" within 2 seconds
          And I should see that the outer html of the element with the css selector "div[id='98kls43mk'] textarea" contains the stored value of "my_input" within 2 seconds
          And I should see that the outer html of the element with the css selector "div[id='98kls43mk'] textarea" contains "<orig_input>"

    Examples:
        | lower_input | upper_input | mixed_input | orig_input  | original                         | lower                            |
        | jana banana | JANA BANANA | jAnA BAnaNa | Jana Banana | <textarea>Jana Banana</textarea> | <textarea>jana banana</textarea> |
