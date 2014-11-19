import argparse
import os
import sys

from lettuce.bin import main as lettuce_main
from lettuce import world
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from salad.steps.everything import *
from salad.terrains.everything import *

BROWSER_CHOICES = [browser.lower()
                   for browser in list(DesiredCapabilities.__dict__.keys())
                   if not browser.startswith('_')]
BROWSER_CHOICES.sort()
DEFAULT_BROWSER = 'firefox'
DEFAULT_PLATFORM = 'Linux'
PLATFORM_CHOICES = ['Linux', 'OS X 10.6', 'Windows XP', 'Windows 7',
                    'Windows 8', 'Windows 8.1']


def main(args=sys.argv[1:]):
    parser = argparse.ArgumentParser(prog="Salad",
                                     description=("BDD browswer-automation "
                                                  "made tasty."))

    parser.add_argument('-V', action='store_true', default=False,
                        help="show program's version number and exit")

    parser.add_argument('--browser', default=DEFAULT_BROWSER,
                        metavar='BROWSER',
                        help=('Browser to use. Options: %s Default is %s.' %
                              (BROWSER_CHOICES, DEFAULT_BROWSER)))

    parser.add_argument('--browserversion', help=('Browser version to use.'))

    parser.add_argument('--platform', default=DEFAULT_PLATFORM,
                        help=('Platform to use. Options: %s Default is %s.' %
                              (PLATFORM_CHOICES, DEFAULT_PLATFORM)))

    parser.add_argument('--remote-url',
                        help='Selenium server url for remote browsers')

    parser.add_argument('--name',
                        help=('Give your job a name so it '
                              'can be identified on saucelabs'))

    parser.add_argument('--timeout',
                        help=("Set the saucelabs' idle-timeout for the job"))

    parser.add_argument('--scenarios', '-s',
                        help=("Limit to the specified scenarios"))

    (parsed_args, leftovers) = parser.parse_known_args()
    world.drivers = [parsed_args.browser]
    world.remote_url = parsed_args.remote_url

    # prepare the remote capabilities
    world.remote_capabilities = {}
    world.remote_capabilities['version'] = parsed_args.browserversion
    world.remote_capabilities['platform'] = parsed_args.platform
    world.remote_capabilities['trustAllSSLCertificates'] = True
    world.remote_capabilities['acceptSslCerts'] = True

    # name
    name = _get_current_timestamp() + " -  "
    if not parsed_args.name:
        name += "unnamed job"
    else:
        name += parsed_args.name
    world.remote_capabilities['name'] = name

    # timeout
    if parsed_args.timeout:
        world.remote_capabilities['idle-timeout'] = parsed_args.timeout
    else:
        world.remote_capabilities['idle-timeout'] = 120

    # travis job number
    if os.environ.get('TRAVIS_JOB_NUMBER'):
        world.remote_capabilities['tunnel-identifier'] = (
            os.environ.get('TRAVIS_JOB_NUMBER'))

    # scenarios
    if parsed_args.scenarios:
        scenarios = set()
        for part in parsed_args.scenarios.split(','):
            x = part.split('-')
            scenarios.update(list(range(int(x[0]), int(x[-1])+1)))
        scenarios = [str(x) for x in sorted(scenarios)]
        leftovers.append('-s %s' % (','.join(scenarios)))
        del parsed_args.scenarios

    print world.remote_capabilities
    lettuce_main(args=leftovers)


def _get_current_timestamp():
    from time import strftime
    import datetime
    return datetime.datetime.strftime(datetime.datetime.now(),
                                      '%d.%m.%Y %H:%M')

if __name__ == '__main__':
    main()
