Feature: Testing mouse actions
    In order to make sure that the mouse module works
    As a developer
    I test against the page test files

    # WHAT ARE THE MOUSE EVENTS HERE?
    # right click mouse out
    # check with link and element finders

    Scenario: 1. Check right click against link finder and element finder
        Given I visit the salad test url "browser/mouse-actions.html"
          And I click on the element with the id "clear"
         Then I should see the <element> within 5 seconds
         When I <click_action> the <element>
         Then I should see that the element with the id "click_action" has the text "<expected_result>" within 5 seconds

    Examples:
        | click_action  | expected_result | element                                            |
        # element by id
        | right click   | right clicked   | element with the id "click_target"                 |
        | right-click   | right clicked   | element with the id "click_target"                 |
        | rightclick    | right clicked   | element with the id "click_target"                 |

        # element by css
        | right click   | right clicked   | element with the css selector "#click_target"      |
        | right-click   | right clicked   | element with the css selector "#click_target"      |
        | rightclick    | right clicked   | element with the css selector "#click_target"      |

        # element by name
        | right click   | right clicked   | element named "click_target"                       |
        | right-click   | right clicked   | element named "click_target"                       |
        | rightclick    | right clicked   | element named "click_target"                       |
        # element by xpath
        | right click   | right clicked   | element with the xpath "//div[@id='click_target']" |
        | right-click   | right clicked   | element with the xpath "//div[@id='click_target']" |
        | rightclick    | right clicked   | element with the xpath "//div[@id='click_target']" |
        # element by value
        | right click   | right clicked   | element with the value "some_value" |
        | right-click   | right clicked   | element with the value "some_value" |
        | rightclick    | right clicked   | element with the value "some_value" |
        # link with the text
        | right click   | right clicked   | link with the text "Click Link Target" |
        | right-click   | right clicked   | link with the text "Click Link Target" |
        | rightclick    | right clicked   | link with the text "Click Link Target" |
        # link with text that contains
        | right click   | right clicked   | link with text that contains "Click Link" |
        | right-click   | right clicked   | link with text that contains "Click Link" |
        | rightclick    | right clicked   | link with text that contains "Click Link" |
        # link to the url
        | right click   | right clicked   | link to "#clicktargetlink" |
        | right-click   | right clicked   | link to "#clicktargetlink" |
        | rightclick    | right clicked   | link to "#clicktargetlink" |
        # link to a url that contains
        | right click   | right clicked   | link to a url that contains "#clicktargetlink" |
        | right-click   | right clicked   | link to a url that contains "#clicktargetlink" |
        | rightclick    | right clicked   | link to a url that contains "#clicktargetlink" |


    Scenario: 2. Check mouse out against link finder and element finder
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
        | mouse out  | moused out         | element with the id "mouse_target"                 |
        | mouse-out  | moused out         | element with the id "mouse_target"                 |
        | mouseout   | moused out         | element with the id "mouse_target"                 |
        # element by css
        | mouse out  | moused out         | element with the css selector "#mouse_target"      |
        | mouse-out  | moused out         | element with the css selector "#mouse_target"      |
        | mouseout   | moused out         | element with the css selector "#mouse_target"      |
        # element by name
        | mouse out  | moused out         | element named "mouse_target"                       |
        | mouse-out  | moused out         | element named "mouse_target"                       |
        | mouseout   | moused out         | element named "mouse_target"                       |
        # element by xpath
        | mouse out  | moused out         | element with the xpath "//div[@id='mouse_target']" |
        | mouse-out  | moused out         | element with the xpath "//div[@id='mouse_target']" |
        | mouseout   | moused out         | element with the xpath "//div[@id='mouse_target']" |
        # element by value
        | mouse out  | moused out         | element with the value "mouse_value"                |
        | mouse-out  | moused out         | element with the value "mouse_value"                |
        | mouseout   | moused out         | element with the value "mouse_value"                |
        # link with the text
        | mouse out  | moused out         | link with the text "Mouse Link Target"             |
        | mouse-out  | moused out         | link with the text "Mouse Link Target"             |
        | mouseout   | moused out         | link with the text "Mouse Link Target"             |
        # link with text that contains
        | mouse out  | moused out         | link with text that contains "Mouse Link"          |
        | mouse-out  | moused out         | link with text that contains "Mouse Link"          |
        | mouseout   | moused out         | link with text that contains "Mouse Link"          |
        # link to the url
        | mouse out  | moused out         | link to "#mousetargetlink"                         |
        | mouse-out  | moused out         | link to "#mousetargetlink"                         |
        | mouseout   | moused out         | link to "#mousetargetlink"                         |
        # link to a url that contains
        | mouse out  | moused out         | link to a url that contains "#mousetargetlink"     |
        | mouse-out  | moused out         | link to a url that contains "#mousetargetlink"     |
        | mouseout   | moused out         | link to a url that contains "#mousetargetlink"     |
