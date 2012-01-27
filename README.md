Salad is a helpful mix of some great BDD packages like lettuce and splinter, seasoned with some common modules.  Its goal is to make writing acceptance tests downright fun.


Installing
==========

We like simple things.

```bash
pip install salad
```

If you want django integration, 

```bash
pip install django django-extensions
```

```python
INSTALLED_APPS += ("lettuce.django",)
```


Usage
=====

Salad is mostly lettuce.
------------------------

Salad is mostly [lettuce](http://lettuce.it/).  So, you should use their [great documentation](http://lettuce.it/contents.html) with gusto.  If you're interacting with the browser, you're doing it through the awesome [splinter](http://splinter.cobrateam.info/), and their [docs](http://splinter.cobrateam.info/docs/) are great as well.


Salad includes helpful steps and terrains.
------------------------------------------

There's a detailed description below on all of the included modules, but if you just want to get up and running quickly, you can:

*steps.py*

```python
from salad.steps.everything import *
```

*terrains.py*

```python
from salad.terrains.everything import *
```

And you're done.


Salad 101
=========

Writing your first lettuce feature
----------------------------------

1. Create a "features" directory in your app.

    ```bash
    mkdir features
    ```

1. Inside the features directory, create a `our-website-is-up.feature` file, with these contents:

    ```gherkin
    Feature: Ensuring that Lettuce works, and W+K's website loads
    In order to make sure that lettuce works
    As a developer
    I open the Wieden+Kennedy website using lettuce

    Scenario: Opening the W+K website works
        Given I visit the url "http://www.wk.com/"
        When I look around
        Then I should see "Wieden+Kennedy" somewhere in the page
    ```

1. Inside the features directory, create a steps file, `our-website-is-up-steps.py`, that imports the salad terrains, like:
    
    ```python
    from salad.steps.everything import *
    ```

1. Also 1. Inside the features directory, create a `terrain.py`, that imports the salad steps, like:
    
    ```python
    from salad.terrains.everything import *
    ```


That's it, you're ready to run the tests!


Running your first lettuce test
-------------------------------


In the directory above features (your project root), run:

```
lettuce
```

That should be it - you should see:

```
Feature: Ensuring that Lettuce works, and W+K's website loads # features/our-website-is-up.feature:1
  In order to make sure that lettuce works                    # features/our-website-is-up.feature:2
  As a developer                                              # features/our-website-is-up.feature:3
  I open the Wieden+Kennedy website using lettuce             # features/our-website-is-up.feature:4

  Scenario: Opening the W+K website works                     # features/our-website-is-up.feature:6
    Given I visit the url "http://www.wk.com/"                # features/our-website-is-up-steps.py:8
    When I look around                                        # features/our-website-is-up-steps.py:80
    Then I should see "Wieden+Kennedy" somewhere in the page  # features/our-website-is-up-steps.py:37

1 feature (1 passed)
1 scenario (1 passed)
3 steps (3 passed)
```

Easy.

Salad Built-ins:
================

The steps and terrain source files are your best source of information, but here's a high-level look at salad's built-ins:

Steps
-----

* `browser` - Broken into submodules. Importing `browser` gets them all.
    * `alerts` - Handle alerts and prompts.
    * `browers` - Switch between browsers.
    * `elements` - Verify that elements exist, have expected contents or attributes.
    * `finders` - No actual steps - just helper functions to find elements.
    * `forms` - Interact with form fields - type, focus, select, fill in, and the like.
    * `javascript` - Run javascript and verify results.
    * `mouse` - Click, mouse over, mouse out, drag and drop.
    * `navigation` - Visit a URL, back, forward, refresh.
    * `page` - Page title, URL, full html.
* `common` - A few utility steps, like wait and look around.
* `djangoify` - Django-focused steps, helping with url reversing and the like.
* `everything` - browser, common, and django.

Terrains
--------

* `common` - Nothing, at the moment.
* `djangoify` - Setup/teardown a test database for django, including south migrations if south is installed.
* `browser` - Sets up a browser at `world.browser`. Uses firefox.
* `firefox` - Same up a firefox browser at `world.firefox`.
* `chrome` - Same up a chrome browser at `world.chrome`.
* `zope` - Same up a zope browser (no javascript) at `world.zope`.
* `everything` - Includes everything above.


Step syntax
-----------

The built-in steps are designed to be flexible in syntax, and implement all of the actions supported by splinter.  Generally, your best bet is to simply read the steps to see what's supported.  However, for parts of `elements`, `forms`, and `mouse`, the code is a bit opaque, so here's a better explanation of how those parts work:

Generally, when you're interacting with forms, page elements, or the mouse, you can think of salad's steps as having a subject, and an action.

Subjects
--------

For any element in the page, you can use this phrasing to specify the subject

```gherkin
<action> the <element|thing|field|textarea|radio button|button|checkbox|label> named "my_name"'
<action> the <element|thing|field|textarea|radio button|button|checkbox|label> with the id "my_id"
<action> the <element|thing|field|textarea|radio button|button|checkbox|label> with the css selector ".my_css_selector>"
<action> the <element|thing|field|textarea|radio button|button|checkbox|label> with the value "my value"

```

If you're just looking for a link, you can use:

```gherkin
<action> the link to "some text"
<action> the link to a url that contains "someurl.com"
<action> the link with(?: the)? text "some text"
<action> the link with text that contains "some t"
```



Actions
-------

The second part is actions.  To verify presence and content, you can use these actions:

```gherkin
should (not) see <subject>
should (not) see that the <subject> contains "some text"
should (not) see that the <subject> contains exactly "some text"
should (not) see that the <subject> has an attribute called "attr_name"
should (not) see that the <subject> has an attribute called "attr_name" with the value "attr value"
should (not) see "some text" anywhere in the page
```

To interact with forms, you can use these:

```gherkin
fill in the <subject> with "some text"
(slowly) type "some text" into the <subject>
attach "some/file.name" onto the <subject>
select the option named "option name" from the <subject>
select the option with the value "option_value" from the <subject>
focus on the the <subject>
blur from the <subject>
see that the value <subject> is (not) "some text"
```

To use the mouse, you've got:

```gherkin
click on the <subject>
mouse over the <subject>
mouse out the <subject>
double click the <subject>
right click the <subject>
drag the <subject_1> and drop it on the <subject_2>
```


Together, it's quite a flexible system - you can say things like:

```gherkin
Given I visit "http://www.my-test-site.com"
When I select the option named "Cheese" from the radio button named "shops"
  And I click on first link with text that contains "Go"
Then I should see an element with the css selector ".cheese_shop_banner"
  And I should not see "MeatCo" anywhere in the page.
```

Using an alternate browser
--------------------------

Salad ships with support for chrome, firefox, and zope's headless javascript-free browser.  Firefox is the default, but using one of the other browsers is pretty straightforward.  To switch what browser you're using, you simply:

```gherkin
Given I am using chrome
```


Tips and Tricks
===============

Keeping tests organized
-----------------------

As you've noticed above, we use the convention of naming the steps file the same as the feature file, with `-steps` appended.  It's worked well so far. For django apps, it's also been easiest to keep the features for each app within the app structure.

We're still early in using lettuce on larger projects, and as better advice comes out, we'll be happy to share it.  If you have advice, type it up in a pull request, or open an issue!

Using Chrome
------------

If you run into problems using Google Chrome in testing (and you have it installed), you probably need to download and install the chrome webdriver.

If you're using a mac, you can:

```bash
brew install chromedriver
```

Otherwise, you can find for your operating system here: http://code.google.com/p/chromium/downloads/list

Django and South
----------------

Salad plays nicely with both django and south, but doesn't require them.  

Include the django steps and terrains into your steps and terrains, and you're all set. `manage.py harvest` and all of the lettuce goodies should just work. 

*Gotcha alert:*  If you're serving static media with `staticfiles`, you'll want to pass `-d` to harvest, to run in debug mode (and enable static media.)


The built-in steps are a helper, not a crutch
----------------------------------------------

Cucumber and salad make BDD beautiful by allowing us to write tests in natural, human language.  Please don't let salad's built-ins drive how your tests read. They're there for convienence, if the syntax they use fits your scenario's needs.  One of the great gains of gherkin syntax is the ability to make a scenario that reads `then I should see that I'm logged in`.  Don't lose that beauty!


Updates and Roadmap
===================

Roadmap
-------

We use salad to test our projects, and it's a fairly new component.  As such it'll continue to evolve and improve.  There's not a specific development map - anything that makes it easier and faster to write BDD tests is on the table. Pull requests are welcome!

0.4.1
-----

* Bugfix in finding element code for single links.

0.4
---

* Massive upgrade to the included steps.  There are now steps for almost everything you can do in splinter, with friendly, consistent syntax!
* Features written for all of salad's steps. That's 100% test coverage, folks!
* `browser` steps are now a module, organized by the area of interaction (forms, mouse, etc).  `import steps.browser` will still behave as before.
* Future-proofing: `I access the url` is now deprecated in favor of the friendlier `I visit the url`.  "visit", "access" and "open" will all be valid actions for visiting a web page going forward.
* Backwards-incompatable: `should see "some text"` has changed meaning.  
    
    * If you mean *this text should appear somewhere in the HTML for this page*, use `should see "some text" somewhere in the page`.
    * If you mean *the element that I am about to describe should be in the page and be visible*, use `should see <subject>`
    * Note: Backwards-incompatable changes will not be the norm around here - at the moment, I'm fairly sure I know everywhere salad is being used, so I'd rather make the jump and get things right.  Future backwards-incompatible changes will go through a deprecation schedule.


0.3
---

* Added the ability to choose your browser, using the "Given that I am using zope/firefox/chrome" step.
* Added `zope.testbrowser` to the required libs
* Salad's own lettuce tests now run, and have coverage of the browser loading.

0.2
---
* Initial dev



Credits:
========

All of the hard work was done by the brilliant folks who wrote [lettuce](http://lettuce.it) and [splinter](http://splinter.cobrateam.info/) and [cucumber](http://cukes.info/).  Our goals with this package was to make it dead-simple to get everything up and running for a sweet BDD setup.

All copyrights and licenses for lettuce and splinter remain with their authors, and this package (which doesn't include their source) makes no claim to their code.

Code credits for salad itself are in the AUTHORS file.