Feature: Ensuring that the forms steps work
    In order to make sure that the forms module works
    As a developer
    I test against the form test files

    Scenario Outline: 1. Seeing things in fields
        Given I visit the salad test url "browser/form.html"
         When I look around
         Then I should see that the <what> of the element with the css selector "<finder>" is "<value>"
          And I should not see that the <what> of the element with the css selector "<finder>" is "this is not it"

    Examples:
        | what  | finder            | value                            |
        | value | fieldset input    | This is the value                |
        | text  | fieldset textarea | This is the text: 123!                |
        | html  | fieldset legend   | Element with value / html / text |


    Scenario Outline: 2. Filling in a field
        Given I visit the salad test url "browser/form.html"
         When I fill in the field <finder> with "my test text"
         Then I should see "Filled!" somewhere in the page
          And I should see that the value of the field <finder> is "my test text"
          And I should not see that the value of the field <finder> is "my not test text"

    Examples:
        | finder                                        |
        | named "input_target_name"                     |
        | with the id "input_target"                    |
        | with the css selector ".input_target_class"   |

    Scenario Outline: 3. Typing in a field works.
        Given I visit the salad test url "browser/form.html"
         When I type "my test text" into the field <finder>
         Then I should see "Filled!" somewhere in the page
          And I should see that the value of the field <finder> is "my test text"

    Examples:
        | finder                                        |
        | named "input_target_name"                     |
        | with the id "input_target"                    |
        | with the css selector ".input_target_class"   |

    Scenario Outline: 4. Slowly typing in a field works.
        Given I visit the salad test url "browser/form.html"
         When I slowly type "my test text" into the field <finder>
         Then I should see "Filled!" somewhere in the page
          And I should see that the value of the field <finder> is "my test text"

    Examples:
        | finder                                        |
        | named "input_target_name"                     |
        | with the id "input_target"                    |
        | with the css selector ".input_target_class"   |

    Scenario: 5. Typing into the current field
        Given I visit the salad test url "browser/form.html"
         When I fill in the field <finder> with "my test text"
         Then I should see "Filled!" somewhere in the page
          And I should see that the value of the field <finder> is "my test text"

    Examples:
        | finder                                        |
        | named "input_target_name"                     |
        | with the id "input_target"                    |
        | with the css selector ".input_target_class"   |

# Textareas
    Scenario Outline: 6. Filling in a textarea works.
        Given I visit the salad test url "browser/form.html"
        When I fill in the textarea <finder> with "my test text"
        Then I should see "Filled!" somewhere in the page

    Examples:
        | finder                                         |
        | named "test_textarea_name"                     |
        | with the id "test_textarea"                    |
        | with the css selector ".test_textarea_class"   |

    Scenario Outline: 7. Typing in a textarea works.
        Given I visit the salad test url "browser/form.html"
         When I type "my test text" into the textarea <finder>
         Then I should see "Filled!" somewhere in the page

    Examples:
        | finder                                         |
        | named "test_textarea_name"                     |
        | with the id "test_textarea"                    |
        | with the css selector ".test_textarea_class"   |

# Attach
    Scenario Outline: 8. Attaching a file works.
        Given I am using firefox
          And I visit the salad test url "browser/form.html"
         When I attach "/tmp/temp_lettuce_test" onto the field <finder>
         Then I should see "Attached!" somewhere in the page

    Examples:
        | finder                                     |
        | named "test_file_name"                     |
        | with the id "test_file"                    |
        | with the css selector ".test_file_class"   |

# Radio
    Scenario: 9. Choosing a radio button works.
        Given I visit the salad test url "browser/form.html"
         When I click the radio button with id "test_radio_1"
         Then I should see "Chosen!" somewhere in the page

    Scenario: 10. Choosing a radio button by label works.
        Given I visit the salad test url "browser/form.html"
         When I click the label with css selector "label[for=test_radio_2]"
         Then I should see "Chosen!" somewhere in the page

# Checkboxes
    Scenario Outline: 11. Checking works.
        Given I visit the salad test url "browser/form.html"
         When I click the checkbox <finder>
         Then I should see "Checked!" somewhere in the page

    Examples:
        | finder                                         |
        | named "unchecked_box_name"                     |
        | with the id "unchecked_box"                    |
        | with the css selector ".unchecked_box_class"   |

    Scenario Outline: 12. Unchecking works.
        Given I visit the salad test url "browser/form.html"
         When I click the checkbox <finder>
         Then I should see "Checked!" somewhere in the page

    Examples:
        | finder                                       |
        | named "checked_box_name"                     |
        | with the id "checked_box"                    |
        | with the css selector ".checked_box_class"   |

# Select
    Scenario Outline: 13. Selecting works
        Given I visit the salad test url "browser/select.html"
         When I look around
         Then I should see the element with the id "test_single"
         When I select the option with the <finder> "<selector>" from the element with the id "test_single"
         Then I should see that running the javascript "$('#<id>').is(':selected')" returns "True" within 3 seconds

    Examples:
        | finder | selector  | id  |
        | value  | bar_value | bar |
        | text   | Foo       | foo |
        | index  | 2         | baz |


    Scenario Outline: 14. Deselecting all options works
        Given I visit the salad test url "browser/select.html"
         Then I should see that running the javascript "$('#anna').is(':selected')" returns "True" within 5 seconds
          And I should see that running the javascript "$('#laura').is(':selected')" returns "True"
          And I should see that running the javascript "$('#nina').is(':selected')" returns "True"
         When I deselect all options from the element <finder> "<selector>"
         Then I should see that running the javascript "$('#anna').is(':selected')" returns "False"
          And I should see that running the javascript "$('#laura').is(':selected')" returns "False"
          And I should see that running the javascript "$('#nina').is(':selected')" returns "False"

    Examples:
        | finder                | selector                               |
        | with the id           | test_multiple                          |
        | named                 | test_multiple                          |
        | with the css selector | .test_multiple_class                    |
        | with the xpath        | //select[@class='test_multiple_class'] |


    Scenario Outline: 15. Hitting keys generally works.
        Given I visit the salad test url "browser/hitkey.html"
         When I look around
          And I hit the <key> key
         Then I should see "<output>" somewhere in the page within 3 seconds

    Examples:
        | key       | output      |
        | home      | Homed!      |
        | end       | Ended!      |
        | insert    | Inserted!   |
        | delete    | Deleted!    |
        | page up   | Page Upped! |
        | page down | Page Downed!|
        | f1        | F1ed!       |
        | f12       | F12ed       |
        | backspace | Backspaced! |
        | tab       | Tabbed!     |
        | return    | Entered!    |


    Scenario Outline: 16. Hitting keys generally works.
        Given I visit the salad test url "browser/hitkey.html"
         When I look around
          And I hit the <key> key
         Then I should see "<output>" somewhere in the page within 3 seconds

    Examples:
        | key       | output      |
        | shift     | Shifted!    |
        | enter     | Entered!    |
        | up        | Up Arrow!   |
        | down      | Down Arrow! |
        | left      | Left Arrow! |
        | right     | Right Arrow!|
        | escape    | Escaped!    |
        | space     | Spaced Out! |
        | control   | Controlled! |
        | alt       | Altered!    |
