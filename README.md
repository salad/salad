Salad is a helpful mix of some great BDD packages like lettuce and splinter, seasoned with some common modules.  Its goal is to make writing acceptance tests downright fun.


Installing
==========

We like simple things.

```bash
pip install salad
```

If you want django integration, 

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

1. Inside the features directory, create a filename with `.feature` as its extension.

    ```bash
    touch our-website-is-up.feature
    ```

1. Write your first feature.

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

1. Inside the features directory, create a steps file for this feature.
    
    ```bash
    touch our-website-is-up-steps.py
    ```

1. In `our-website-is-up-steps.py`, import the `salad` libraries

    ```python
    from salad.steps.common import *
    ```

1. Also inside the features directory, create a terrain file, to be used for all features in the folder
    
    ```python
    from salad.terrains.common import *
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

Tips and Tricks
===============

Keeping tests organized
-----------------------

As you've noticed above, we use the convention of naming the steps file the same as the feature file, with `-steps` appended.  It's worked well so far. For django apps, it's also been easiest to keep the features for each app within the app structure.

We're still early in using lettuce on larger projects, and as better advice comes out, we'll be happy to share it.  If you have advice, type it up in a pull request, or open an issue!


Django and South
----------------

Salad plays nicely with both django and south, but doesn't require them.  

Include the django steps and terrains into your steps and terrains, and you're all set. `manage.py harvest` and all of the lettuce goodies should just work. 


Roadmap
=======

We use salad to test our projects, and it's a fairly new component.  As such it'll continue to evolve and improve.  There's not a specific development map - anything that makes it easier and faster to write BDD tests is on the table. Pull requests are welcome!


Credits:
========

All of the hard work was done by the brilliant folks who wrote lettuce and splinter and cucumber.  Our goals with this package was to make it dead-simple to get everything up and running for a sweet BDD setup.

All copyrights and licenses for lettuce and splinter remain with their authors, and this package (which doesn't include their source) makes no claim to their code.

Code credits for salad itself are in the AUTHORS file.