Feature: Drag and Drop does not work on remote Firefox

    Scenario: 1. Drag and drop selectors by name work
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the element named "drag_handler_name"
         When I drag the element named "drag_handler_name" and drop it on the element named "drag_target_name"
         Then I should see "Dropped on me!" somewhere in the page

    Scenario: 2. Drag and drop selectors by id work
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the element with the id "drag_handler"
         When I drag the element with the id "drag_handler" and drop it on the element named "drag_target_name2"
         Then I should see "Dropped on me 2!" somewhere in the page

    Scenario: 3. Drag and drop selectors by css work
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the element with the css selector ".drag_handler_class"
        When I drag the 2nd element with the css selector ".drag_handler_class" and drop it on the 1st element with the css selector ".drag_target_class"
        Then I should see "Dropped on me!" somewhere in the page

     Scenario: 4. Drag and drop to a non-target by name
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the element named "drag_handler_name"
         When I drag the element named "drag_handler_name" and drop it on the element named "drag_not_target_name"
         Then I should not see "Dropped on me!" somewhere in the page

    Scenario: 5. Drag and drop to a non-target with first/last
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the first element named "drag_handler_name"
         When I drag the first element named "drag_handler_name2" and drop it on the last element with css selector ".drag_target_class"
         Then I should see "Dropped on me 4!" somewhere in the page

     Scenario: 6. Drag and drop to a non-target with ordinals
        Given I visit the salad test url "browser/mouse.html"
         When I look around
         Then I should see the 4th element with the css selector ".drag_handler_class"
         When I drag the 4th element with css selector ".drag_handler_class" and drop it on the 3rd element with css selector ".drag_target_class"
         Then I should see "Dropped on me 3!" somewhere in the page
