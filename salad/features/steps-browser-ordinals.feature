Feature: Ensuring that selecting the XX. element of something works
    In order to make sure that the elements module works
    As a developer
    I test against the form test files

# Key Generator
    Scenario Outline: Hitting keys in fields works.
        Given I visit the salad test url "browser/form.html"
        When I hit the up key in the <ordinal> element named "keyup_target_name"
        Then I should see "<output>" somewhere in the page

    Examples:
        | ordinal   | output      |
        | first     | first up    |
        | last      | last up     |
        | 1st       | first up    |
        | 2st       | second up   |
        | 3st       | third up    |
        | 4st       | forth up    |
        | 5th       | last up     |


    Scenario Outline: Visibility of elements
        Given I visit the salad test url "browser/invisible_elements.html"
         When I look around
         Then I should not see the element with css selector ".invisible"
         Then I should not see the <ordinal> element with css selector ".invisible"

    Examples:
        | ordinal                                    |
        | first                                      |
        | last                                       |
        | 1st                                        |
        | 2nd                                        |
        | 3rd                                        |
        | 4th                                        |
        | 5th                                        |


    Scenario Outline: Content of an element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see that the <ordinal> element with css selector ".i_contain_class" contains "has"

    Examples:
        | ordinal                                    |
        | first                                      |
        | 1st                                        |
        | 2nd                                        |
        | 3rd                                        |
        | 4th                                        |
        | 5th                                        |

    Scenario: Non-Content of an element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see that the 6th element with css selector ".i_contain_class" contains "has"

    Scenario Outline: Attribute of an element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see that the <ordinal> element with css selector ".i_contain_class" has an attribute called "class"

    Examples:
        | ordinal                                    |
        | first                                      |
        | 1st                                        |
        | 2nd                                        |
        | 3rd                                        |
        | 4th                                        |
        | 5th                                        |

    Scenario: Non-Attribute of an element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see that the last element with css selector ".i_contain_class" has an attribute called "label"

    Scenario: Content of an <ordnial-number> element
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see that the 6th element with css selector ".i_contain_class" is exactly "But I have."

    Scenario Outline: Attribute on an element with value
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should see that the <ordinal> element with css selector ".i_attr_class" has an attribute called "my_attr" with value "me!"

    Examples:
        | ordinal                                    |
        | first                                      |
        | 1st                                        |
        | 2nd                                        |
        | 3rd                                        |
        | 4th                                        |
        | 5th                                        |

    Scenario: Attribute not on a element with value
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see that the 6th element with css selector ".i_attr_class" has an attribute called "my_attr" with value "me!"

    Scenario: Attribute not on a element with value
        Given I visit the salad test url "browser/elements.html"
        When I look around
        Then I should not see that the 7th element with css selector ".i_attr_class" has an attribute called "my_attr" with value "me!"

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
            | first   | 1  |
            | last    | 4  |
            | 1st     | 1  |
            | 2nd     | 2  |
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
        | 3rd       | some text 3    |
        | 4th       | some text 4    |
        | 5th       | some text 5    |
        | last      | some text 5    |

# Fill Generator
    Scenario Outline: Filling in a field works.
        Given I visit the salad test url "browser/form.html"
        When I fill in the <ordinal> element with css selector ".input_target_class" with "my test text"
        Then I should see "Filled" somewhere in the page
         And I should see that the value of the <ordinal> element with css selector ".input_target_class" is "my test text"
         And I should see that the value of the <ordinal> element with css selector ".input_target_class" is "my test text"
         And I should see that the value of the <ordinal> element with css selector ".input_target_class" is not "Hahaha ich bin's nicht!"
        When I attach "/tmp/temp_lettuce_test" onto the first field named "test_file_name"

    Examples:
        | ordinal                                       |
        | first                                         |
        | last                                          |
        | 1st                                           |
        | 2nd                                           |
        | 3rd                                           |
        | 4th                                              |

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


# Attach Generator
    Scenario Outline: Attaching a file works.
        Given I visit the salad test url "browser/form.html"
        When I attach "/tmp/temp_lettuce_test" onto the <ordinal> field named "test_file_name"
        Then I should see "Attached" somewhere in the page
        When I fill in the first element with css selector ".input_target_class" with "my test text"

    Examples:
        | ordinal                                     |
        | first                                       |
        | 5th                                         |
        | last                                        |

    Scenario: Attaching a file works.
        Given I visit the salad test url "browser/form.html"
        When I attach "/tmp/temp_lettuce_test" onto the 2nd field named "test_file_name"
        Then I should see "Attached 2" somewhere in the page
        When I attach "/tmp/temp_lettuce_test" onto the 3rd field named "test_file_name"
        Then I should see "Attached 3" somewhere in the page
        When I attach "/tmp/temp_lettuce_test" onto the 4th field named "test_file_name"
        Then I should see "Attached 4" somewhere in the page

# Type Generator # (slowly) typing in a field
    Scenario: Slowly typing in a field works.
        Given I visit the salad test url "browser/form.html"
         When I slowly type "my test text" into the field with the id "input_target"
         Then I should see "Filled" somewhere in the page

    Scenario Outline: Slowly typing in a field works.
        Given I visit the salad test url "browser/form.html"
         When I type "my test text" into the <ordinal> field named "input_target_name"
          And I wait 1 seconds
         Then I should see "<output>" somewhere in the page
          And I should see that the value of the <ordinal> field named "input_target_name" is "my test text"

    Examples:
        | ordinal          |output                   |nr |
        | last             |Filled!                  |4  |
        | 2nd              |Filled 1!                |1  |
        | 3rd              |Filled 2!                |2  |
        | 4th              |Filled 3!                |3  |
        | 5th              |Filled!                  |4  |

