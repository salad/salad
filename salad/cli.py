import sys
import argparse

from lettuce.bin import main as lettuce_main
from lettuce import world
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from salad.steps.everything import *
from salad.terrains.everything import *

BROWSER_CHOICES = [browser.lower()
                   for browser in DesiredCapabilities.__dict__.keys()
                   if not browser.startswith('_')]
BROWSER_CHOICES.append('zope.testbrowser')
BROWSER_CHOICES.sort()
DEFAULT_BROWSER = 'firefox'

class store_driver_and_version(argparse.Action):
    drivers = BROWSER_CHOICES

    def __call__(self, parser, namespace, values, option_string=None):
        driver_info = values.split('-')
        if driver_info[0] not in self.drivers:
            args = {'driver': driver_info[0],
                    'choices': ', '.join(map(repr, self.drivers))}
            message = 'invalid choice: %(driver)r (choose from %(choices)s)'
            raise argparse.ArgumentError(self, message % args)
        setattr(namespace, self.dest, driver_info[0])
        if len(driver_info) > 1:
            setattr(namespace, 'version', driver_info[1])
        if len(driver_info) > 2:
            setattr(namespace, 'platform', driver_info[2].replace('_', ' '))

def main(args=sys.argv[1:]):
    parser = argparse.ArgumentParser(prog="Salad", description='BDD browswer-automation made tasty.')

    parser.add_argument('--browser', default=DEFAULT_BROWSER,
                        action=store_driver_and_version, metavar='BROWSER',
                        help=('Browser to use. Options: %s Default is %s.' %
                              (BROWSER_CHOICES, DEFAULT_BROWSER)))
    parser.add_argument('--remote-url',
                        help='Selenium server url for remote browsers')

    (parsed_args, leftovers) = parser.parse_known_args()
    world.drivers = [parsed_args.browser]
    world.remote_url = parsed_args.remote_url
    world.remote_capabilities = {}
    if 'version' in parsed_args:
        world.remote_capabilities['version'] = parsed_args.version
    if 'platform' in parsed_args:
        world.remote_capabilities['platform'] = parsed_args.platform
    lettuce_main(args=leftovers)

if __name__ == '__main__':
    main()
