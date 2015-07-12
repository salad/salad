Feature: Testing mouse actions
    In order to make sure that the mouse module works
    As a developer
    I test against the page test files

    # WHAT ARE THE MOUSE EVENTS ?
    # click, double-click // mouse over
    # check with link and element finders
    # right click and mouse out go to a different feature, because phantomjs does not support these actions

    Scenario: 1. Check click actions against element finder (without right click)
        Given I visit the salad test url "browser/mouse-actions.html"
          And I click on the element with the id "clear"
         Then I should see the <element> within 5 seconds
         When I <click_action> the <element>
         Then I should see that the element with the id "click_action" has the text "<expected_result>" within 5 seconds

    Examples:
        | click_action  | expected_result | element                                            |
        # element by id
        | click on      | clicked         | element with the id "click_target"                 |
        | double click  | double clicked  | element with the id "click_target"                 |
        | double-click  | double clicked  | element with the id "click_target"                 |
        | doubleclick   | double clicked  | element with the id "click_target"                 |
        # element by css
        | click on      | clicked         | element with the css selector "#click_target"      |
        | double click  | double clicked  | element with the css selector "#click_target"      |
        | double-click  | double clicked  | element with the css selector "#click_target"      |
        | doubleclick   | double clicked  | element with the css selector "#click_target"      |
        # element by name
        | click on      | clicked         | element named "click_target"                       |
        | double click  | double clicked  | element named "click_target"                       |
        | double-click  | double clicked  | element named "click_target"                       |
        | doubleclick   | double clicked  | element named "click_target"                       |
        # element by xpath
        | click on      | clicked         | element with the xpath "//div[@id='click_target']" |
        | double click  | double clicked  | element with the xpath "//div[@id='click_target']" |
        | double-click  | double clicked  | element with the xpath "//div[@id='click_target']" |
        | doubleclick   | double clicked  | element with the xpath "//div[@id='click_target']" |
        # element by value
        | click on      | clicked         | element with the value "some_value"                |
        | double click  | double clicked  | element with the value "some_value"                |
        | double-click  | double clicked  | element with the value "some_value"                |
        | doubleclick   | double clicked  | element with the value "some_value"                |


    Scenario: 2. Check click actions against link finder (without right click)
        Given I visit the salad test url "browser/mouse-actions.html"
          And I click on the element with the id "clear"
         Then I should see the <element> within 5 seconds
         When I <click_action> the <element>
         Then I should see that the element with the id "click_action" has the text "<expected_result>" within 5 seconds

    Examples:
        | click_action  | expected_result | element                                        |
        # link with the text
        | click on      | clicked         | link with the text "Click Link Target"         |
        | double click  | double clicked  | link with the text "Click Link Target"         |
        | double-click  | double clicked  | link with the text "Click Link Target"         |
        | doubleclick   | double clicked  | link with the text "Click Link Target"         |
        # link with text that contains
        | click on      | clicked         | link with text that contains "Click Link"      |
        | double click  | double clicked  | link with text that contains "Click Link"      |
        | double-click  | double clicked  | link with text that contains "Click Link"      |
        | doubleclick   | double clicked  | link with text that contains "Click Link"      |
        # link to the url
        | click on      | clicked         | link to "#clicktargetlink"                     |
        | double click  | double clicked  | link to "#clicktargetlink"                     |
        | double-click  | double clicked  | link to "#clicktargetlink"                     |
        | doubleclick   | double clicked  | link to "#clicktargetlink"                     |
        # link to a url that contains
        | click on      | clicked         | link to a url that contains "#clicktargetlink" |
        | double click  | double clicked  | link to a url that contains "#clicktargetlink" |
        | double-click  | double clicked  | link to a url that contains "#clicktargetlink" |
        | doubleclick   | double clicked  | link to a url that contains "#clicktargetlink" |


    Scenario: 3. Check mouse over against element finder
        Given I visit the salad test url "browser/mouse-actions.html"
          And I click on the element with the id "clear"
         Then I should see the <element> within 5 seconds
         # make sure the mouse is in place for the subsequent mouse action
         When I click on the <element>
          And I <mouse_action> the <element>
         Then I should see that the element with the id "mouse_action" has the text "<expected_result>" within 5 seconds

    Examples:
        | mouse_action  | expected_result | element                                            |
        # element by id
        | mouse over    | moused over     | element with the id "mouse_target"                 |
        | mouse-over    | moused over     | element with the id "mouse_target"                 |
        | mouseover     | moused over     | element with the id "mouse_target"                 |
        # element by css
        | mouse over    | moused over     | element with the css selector "#mouse_target"      |
        | mouse-over    | moused over     | element with the css selector "#mouse_target"      |
        | mouseover     | moused over     | element with the css selector "#mouse_target"      |
        # element by name
        | mouse over    | moused over     | element named "mouse_target"                       |
        | mouse-over    | moused over     | element named "mouse_target"                       |
        | mouseover     | moused over     | element named "mouse_target"                       |
        # element by xpath
        | mouse over    | moused over     | element with the xpath "//div[@id='mouse_target']" |
        | mouse-over    | moused over     | element with the xpath "//div[@id='mouse_target']" |
        | mouseover     | moused over     | element with the xpath "//div[@id='mouse_target']" |
        # element by value
        | mouse over    | moused over     | element with the value "mouse_value"               |
        | mouse-over    | moused over     | element with the value "mouse_value"               |
        | mouseover     | moused over     | element with the value "mouse_value"               |


    Scenario: 4. Check mouse over against link finder
        Given I visit the salad test url "browser/mouse-actions.html"
          And I click on the element with the id "clear"
         Then I should see the <element> within 5 seconds
         # make sure the mouse is in place for the subsequent mouse action
         When I click on the <element>
          And I <mouse_action> the <element>
         Then I should see that the element with the id "mouse_action" has the text "<expected_result>" within 5 seconds

    Examples:
        | mouse_action  | expected_result | element                                            |
        # link with the text
        | mouse over    | moused over     | link with the text "Mouse Link Target"             |
        | mouse-over    | moused over     | link with the text "Mouse Link Target"             |
        | mouseover     | moused over     | link with the text "Mouse Link Target"             |
        # link with text that contains
        | mouse over    | moused over     | link with text that contains "Mouse Link"          |
        | mouse-over    | moused over     | link with text that contains "Mouse Link"          |
        | mouseover     | moused over     | link with text that contains "Mouse Link"          |
        # link to the url
        | mouse over    | moused over     | link to "#mousetargetlink"                         |
        | mouse-over    | moused over     | link to "#mousetargetlink"                         |
        | mouseover     | moused over     | link to "#mousetargetlink"                         |
        # link to a url that contains
        | mouse over    | moused over     | link to a url that contains "#mousetargetlink"     |
        | mouse-over    | moused over     | link to a url that contains "#mousetargetlink"     |
        | mouseover     | moused over     | link to a url that contains "#mousetargetlink"     |
