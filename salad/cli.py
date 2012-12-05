import sys
import argparse

from lettuce.bin import main as lettuce_main
from lettuce import world
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

BROWSER_CHOICES = [browser.lower()
                   for browser in DesiredCapabilities.__dict__.keys()
                   if not browser.startswith('_')]
DEFAULT_BROWSER = 'firefox'


def main(args=sys.argv[1:]):
    parser = argparse.ArgumentParser(prog="Salad", description='BDD browswer-automation made tasty.')

    parser.add_argument('--browser', default=DEFAULT_BROWSER,
                        metavar='BROWSER', choices=BROWSER_CHOICES,
                        help=('Browser to use. Default is %s.' %
                              DEFAULT_BROWSER))
    parser.add_argument('--remote-url',
                        help='Selenium server url for remote browsers')
    parser.add_argument('args', nargs=argparse.REMAINDER)

    parsed_args = parser.parse_args()
    world.drivers = [parsed_args.browser]
    world.remote_url = parsed_args.remote_url
    lettuce_main(args=parsed_args.args)

if __name__ == '__main__':
    main()
