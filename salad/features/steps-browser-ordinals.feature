Feature: Ensuring that selecting the XX. element of something works
    In order to make sure that the elements module works
    As a developer
    I test against the form test files

# Key Generator
    Scenario Outline: Hitting keys in fields works.
        Given I visit the salad test url "browser/form.html"
          And I look around
         When I click on the <ordinal> element named "keyup_target_name"
          And I wait 1 second
          And I hit the up key in the "<ordinal>" element named "keyup_target_name"
         Then I should see "<text>" somewhere in the page within 3 seconds

    Examples:
        | ordinal | text      |
        | 1st     | first up  |
        | 2nd     | second up |

# Visibility
    Scenario Outline: Visibility of elements
        Given I visit the salad test url "browser/invisible_elements.html"
         When I look around
         Then I should not see the <ordinal> element with css selector ".invisible"

    Examples:
        | ordinal                                    |
        | first                                      |
        | last                                       |
        | 1st                                        |
        | 2nd                                        |

# Content and Attributes
    Scenario Outline: Content of an element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see that the 1st element with css selector ".i_contain_class" contains "has"
         And I should not see that the last element with css selector ".i_contain_class" contains "has"

# Select Generator
    Scenario: Selecting works with "with the value".
        Given I visit the salad test url "browser/form.html"
        When I select the option with the value "option 3" from the field with id "nr_select_1"
        Then I should see "Selected 3 in Selector 1!" somewhere in the page

    Scenario: Selecting works with "with the value" and ordinal.
        Given I visit the salad test url "browser/form.html"
        When I select the option with the value "option 2" from the <ordinal> field named "nr_select_name"
        Then I should see "Selected 2 in Selector <nr>!" somewhere in the page

        Examples:
            | ordinal | nr |
            | last    | 4  |
            | 1st     | 1  |
            | 3rd     | 3  |

# Value Generator
    Scenario Outline: i should see that the value is ....
        Given I visit the salad test url "browser/form.html"
         When I look around
         Then I should see that the value of the <ordinal> element named "some_text_name" is "<output>"

    Examples:
        | ordinal   | output         |
        | first     | some text 1    |
        | 1st       | some text 1    |
        | 2nd       | some text 2    |
        | last      | some text 2    |

# Fill Generator
    Scenario Outline: Filling in a field works.
        Given I visit the salad test url "browser/form.html"
        When I fill in the <ordinal> element with css selector ".input_target_class" with "my test text"
        Then I should see "Filled" somewhere in the page
         And I should see that the value of the <ordinal> element with css selector ".input_target_class" is "my test text"
         And I should not see that the value of the <ordinal> element named "input_target_name" is "Hahaha ich bin's nicht!"

    Examples:
        | ordinal                                       |
        | first                                         |
        | last                                          |
        | 1st                                           |
        | 2nd                                           |

# Attach Generator
    Scenario Outline: Attaching a file in <ordinal> fields works.
        Given I visit the salad test url "browser/form.html"
        When I attach "/tmp/temp_lettuce_test" onto the <ordinal> field named "test_file_name"
        Then I should see "Attached <nr>" somewhere in the page

    Examples:
        | ordinal   | nr  |
        | 2rd       | 2   |
        | last      | 2   |

# Type Generator # (slowly) typing in a field
    Scenario: Slowly typing in a field works.
        Given I visit the salad test url "browser/form.html"
         When I slowly type "my test text" into the field with the id "input_target"
         Then I should see "Filled" somewhere in the page

    Scenario Outline: Slowly typing in a field works.
        Given I visit the salad test url "browser/form.html"
         When I type "my test text" into the <ordinal> field named "input_target_name"
         Then I should see "<output>" somewhere in the page
          And I should see that the value of the <ordinal> field named "input_target_name" is "my test text"

    Examples:
        | ordinal          |output         |
        | first            |Filled!        |
        | 2nd              |Filled 1!      |

    Scenario Outline: Mouse over some ordinal element works
        Given I am using Chrome
          And I visit the salad test url "browser/mouse.html"
        When I mouseover the <ordinal> element named "mouse_target_name"
        Then I should see "<expected_results>" somewhere in the page

# Mouse
    Examples:
        | ordinal   | expected_results |
        | first     | Moused over      |
        | 1st       | Moused over      |
        | 2nd       | Moused over 2    |
        | last      | Moused over 2    |
