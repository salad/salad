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

Salad is mostly lettuce.  So, you should use their [great documentation](http://lettuce.it/) with gusto.  If you're interacting with the browser, you're doing it through [splinter](http://splinter.cobrateam.info/docs/), and their docs are great as well.

Salad includes some steps and terrains
--------------------------------------

To make it even easier to test, salad includes a number of common steps and terrains you can import into your files and use.

For example, if you're writing a django app, you can:

my_app_steps.py

```python
from salad.steps.common import *
from salad.steps.browser import *
from salad.steps.djangoify import *
```

and

my_app_terrain.py

```python
from salad.terrains.browser import *
from salad.terrains.djangoify import *
```

and you're done. If you don't care about importing too much, there's always

```python
from salad.steps.everything import *
```

and

```python
from salad.terrains.everything import *
```


The source is pretty friendly, and always accurate. Check it out to see what steps and terrains salad's got.


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
        Given I access the url "http://www.wk.com/"
        When I look around
        Then I should see "Wieden+Kennedy"
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
    Given I access the url "http://www.wk.com/"               # features/our-website-is-up-steps.py:8
    When I look around                                        # features/our-website-is-up-steps.py:80
    Then I should see "Wieden+Kennedy"                        # features/our-website-is-up-steps.py:37

1 feature (1 passed)
1 scenario (1 passed)
3 steps (3 passed)
```

Easy.

Salad Built-ins:
================

Please read the steps and terrain source code for details, but for a high-level look at the built-ins, here's what salad has:

Steps
-----

* `browser` - Lots of page-element checking, form-interacting goodness
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



Tips and Tricks
===============

Keeping tests organized
-----------------------

As you've noticed above, we use the convention of naming the steps file the same as the feature file, with `-steps` appended.  It's worked well so far. For django apps, it's also been easiest to keep the features for each app within the app structure.

We're still early in using lettuce on larger projects, and as better advice comes out, we'll be happy to share it.  If you have advice, type it up in a pull request, or open an issue!


Using an alternate browser
--------------------------

Salad ships with support for chrome, firefox, and zope's headless javascript-free browser.  Firefox is the default, but using one of the other browsers is pretty straightforward.  Here's an example using zope and chrome, to test differing behaviors when javascript is disabled.

*terrain.py*

```python
from salad.terrains.everything import *
```

*steps.py*

```python
from salad.steps.everything import *
```

*other_browsers_work.feature*

```gherkin
Feature: Ensuring that other browsers work
    In order to make sure that other browsers work
    As a developer
    I search for the Wieden+Kennedy website using zope and firefox

    Scenario: Opening the W+K website works
        Given I am using zope
         And I access the url "http://www.google.com/"
        When I I fill in "q" with "Wieden Kennedy"
          And I wait 1 second
        Then I should not see "www.wk.com"

    Scenario: Opening the W+K website works
        Given I am using firefox
          And I access the url "http://www.google.com/"
        When I I fill in "q" with "Wieden Kennedy"
          And I wait 1 second
        Then I should see "www.wk.com"
```


Django and South
----------------

Salad plays nicely with both django and south, but doesn't require them.  

Include the django steps and terrains into your steps and terrains, and you're all set. `manage.py harvest` and all of the lettuce goodies should just work. 

*Gotcha alert:*  If you're serving static media with `staticfiles`, you'll want to pass `-d` to harvest, to run in debug mode (and enable static media.)


Updates and Roadmap
===================

Roadmap
-------

We use salad to test our projects, and it's a fairly new component.  As such it'll continue to evolve and improve.  There's not a specific development map - anything that makes it easier and faster to write BDD tests is on the table. Pull requests are welcome!


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

All of the hard work was done by the brilliant folks who wrote lettuce and splinter and cucumber.  Our goals with this package was to make it dead-simple to get everything up and running for a sweet BDD setup.

All copyrights and licenses for lettuce and splinter remain with their authors, and this package (which doesn't include their source) makes no claim to their code.

Code credits for salad itself are in the AUTHORS file.