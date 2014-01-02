Feature: Ensuring that the forms steps work
    In order to make sure that the forms module works
    As a developer
    I test against the form test files

    Scenario Outline: Filling in a field with random content and recalling the content
        Given I visit the salad test url "browser/form.html"
          And I look around
         When I store a random <thing> of length 15 as "<name1>"
          And I store a random <thing> as "<name2>"
          And I store a random <thing> of length 5 with suffix " restaurant" as "<name3>"
          And I store a random <thing> with suffix " SUFFIX" as "<name4>"
          And I fill in the 1st element named "fill_me_in" with the stored value of "<name1>"
          And I fill in the 2nd field with the xpath "//div[@id='fill_in']/input" with the stored value of "<name2>"
          And I fill in the 3rd field named "fill_me_in" with the stored value of "<name3>"
          And I fill in the 4th field named "fill_me_in" with the stored value of "<name4>"
         Then I should see the stored value of "<name1>" in the field named "fill_me_in"
          And I should see the stored value of "<name2>" in the 2nd field with the xpath "//div[@id='fill_in']/input"
          And I should see the stored value of "<name3>" in the 3rd field named "fill_me_in"
          And I should see the stored value of "<name4>" in the 4th field named "fill_me_in"

    Examples:
        | thing           | name1               | name2               |
        | string          | my_string1          | my_string2          |
        | email           | my_email1           | my_email2           |
        | name            | my_name1            | my_name2            |


    Scenario Outline: Filling in a field works.
        Given I visit the salad test url "browser/form.html"
        When I fill in the field <finder> with "my test text"
        Then I should see "Filled!" somewhere in the page
          And I should see that the value of the field <finder> is "my test text"

    Examples:
        | finder                                        |
        | named "input_target_name"                     |
        | with the id "input_target"                    |
        | with the css selector ".input_target_class"   |

    Scenario Outline: Typing in a field works.
        Given I visit the salad test url "browser/form.html"
        When I type "my test text" into the field <finder>
        Then I should see "Filled!" somewhere in the page
          And I should see that the value of the field <finder> is "my test text"

    Examples:
        | finder                                        |
        | named "input_target_name"                     |
        | with the id "input_target"                    |
        | with the css selector ".input_target_class"   |

    Scenario Outline: Slowly typing in a field works.
        Given I visit the salad test url "browser/form.html"
        When I slowly type "my test text" into the field <finder>
        Then I should see "Filled!" somewhere in the page
          And I should see that the value of the field <finder> is "my test text"

    Examples:
        | finder                                        |
        | named "input_target_name"                     |
        | with the id "input_target"                    |
        | with the css selector ".input_target_class"   |

   Scenario: Typing into the current field
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
    Scenario Outline: Filling in a textarea works.
        Given I visit the salad test url "browser/form.html"
        When I fill in the textarea <finder> with "my test text"
        Then I should see "Filled!" somewhere in the page

    Examples:
        | finder                                         |
        | named "test_textarea_name"                     |
        | with the id "test_textarea"                    |
        | with the css selector ".test_textarea_class"   |

    Scenario Outline: Typing in a textarea works.
        Given I visit the salad test url "browser/form.html"
        When I type "my test text" into the textarea <finder>
        Then I should see "Filled!" somewhere in the page

    Examples:
        | finder                                         |
        | named "test_textarea_name"                     |
        | with the id "test_textarea"                    |
        | with the css selector ".test_textarea_class"   |

# Attach
    Scenario Outline: Attaching a file works.
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
    Scenario: Choosing a radio button works.
        Given I visit the salad test url "browser/form.html"
        When I click the radio button with id "test_radio_1"
        Then I should see "Chosen!" somewhere in the page

    Scenario: Choosing a radio button by label works.
        Given I visit the salad test url "browser/form.html"
        When I click the label with css selector "label[for=test_radio_2]"
        Then I should see "Chosen!" somewhere in the page

# Checkboxes
    Scenario Outline: Checking works.
        Given I visit the salad test url "browser/form.html"
        When I click the checkbox <finder>
        Then I should see "Checked!" somewhere in the page

    Examples:
        | finder                                         |
        | named "unchecked_box_name"                     |
        | with the id "unchecked_box"                    |
        | with the css selector ".unchecked_box_class"   |

    Scenario Outline: Unchecking works.
        Given I visit the salad test url "browser/form.html"
        When I click the checkbox <finder>
        Then I should see "Checked!" somewhere in the page

    Examples:
        | finder                                       |
        | named "checked_box_name"                     |
        | with the id "checked_box"                    |
        | with the css selector ".checked_box_class"   |

# Select
    Scenario Outline: Selecting works.
        Given I visit the salad test url "browser/form.html"
        When I select the option named "My test text" from the field <finder>
        Then I should see "Selected!" somewhere in the page

    Examples:
        | finder                                         |
        | named "test_select_name"                     |
        | with the id "test_select"                    |
        | with the css selector ".test_select_class"   |

    Scenario Outline: Selecting works.
        Given I visit the salad test url "browser/form.html"
        When I select the option with the value "my test value" from the field <finder>
        Then I should see "Selected!" somewhere in the page

    Examples:
        | finder                                         |
        | named "test_select_name"                     |
        | with the id "test_select"                    |
        | with the css selector ".test_select_class"   |

    Scenario Outline: Hitting keys generally works.
        Given I visit the salad test url "browser/hitkey.html"
        When I hit the <key> key
        Then I should see "<output>" somewhere in the page

    Examples:
        | key       | output      |
        | enter     | Entered!    |
        | return    | Entered!    |
        | up        | Up Arrow!   |
        | down      | Down Arrow! |
        | left      | Left Arrow! |
        | right     | Right Arrow!|
        | escape    | Escaped!    |
        | space     | Spaced Out! |
        | control   | Controlled! |
        | alt       | Altered!    |
        | tab       | Tabbed!     |
        | shift     | Shifted!    |
        | backspace | Backspaced! |
        | home      | Homed!      |
        | end       | Ended!      |
        | insert    | Inserted!   |
        | delete    | Deleted!    |
        | page up   | Page Upped! |
        | page down | Page Downed!|
        | f1        | F1ed!       |
        | f12       | F12ed       |


    Scenario: Focusing works
        Given I am using chrome
        Given I visit the salad test url "browser/form.html"
        When I click on the field named "focus_me_name"
          And I click on the field named "focus_me_name"
          And I wait 2 seconds
        Then I should see "Focused!" somewhere in the page

    Scenario: Blurring works
        Given I am using chrome
        Given I visit the salad test url "browser/form.html"
        When I click on the field named "focus_me_name"
          And I wait 1 seconds
          And I click on the element named "input_target_name"
          And I wait 2 seconds
        Then I should see "Blurred!" somewhere in the page
