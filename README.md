Salad is a helpful mix of some great BDD packages like lettuce and splinter, seasoned with some common modules.  Its goal is to get rid of any excuses you had for not writing acceptance tests.


Installing
==========


Usage
=====

Salad is mostly lettuce.
------------------------

Salad is mostly lettuce.  So, you should use [great documentation](http://lettuce.it/) with gusto.  If you're interacting with the browser, you're doing it through [splinter](http://splinter.cobrateam.info/docs/), and their docs are great as well.

Salad Steps and Terrains
------------------------

To make it even easier to test, salad includes a number of common steps and terrains you can import into your files and use.

For example, if you're writing a django app, you can:

my_app_steps.py
```
from salad.steps.common import *
from salad.steps.django import *
```

and

my_app_terrain.py
```
from salad.terrains.browser import *
from salad.terrains.django import *
```


Writing your first lettuce feature
----------------------------------

1. Create a "features" directory in your app.

    ```mkdir features```

1. Inside the features directory, create a filename with `.feature` as its extension.

    ```touch our-website-is-up.feature```

1. Write your first feature.

    ```
    Feature: Ensuring that Lettuce works, and W+K's website loads
    In order to make sure that lettuce works
    As a developer
    I open the Wieden+Kennedy website using lettuce

    Scenario: Opening the W+K website works
        Given I access the url "http://www.wk.com/"
        When I look around
        Then I should see "Wieden+Kennedy"
    ```

1. Create a steps file for this feature.
    
    ```touch our-website-is-up.py```

1. In `touch our-website-is-up.py`, import the `salad` libraries

    ```
    from salad.steps.common import *
    ```

1. Create a terrain file for all features in this project
    
    ```
    from salad.terrains.common import *
    ```


That's it, you're ready to run the tests!


Running your first lettuce test
-------------------------------


In the directory above features (your project root), run:

```
lettuce
```

That should be it!


Keeping tests organized
-----------------------


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

Code credits for salad itself are in the AUTHORS file