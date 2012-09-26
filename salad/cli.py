import sys
import argparse

from lettuce.bin import main as lettuce_main

BROWSER_CHOICES = ["firefox", "chrome", "zope"]
DEFAULT_BROWSER = BROWSER_CHOICES[:1]


class CommaSeparatedBrowserAction(argparse.Action):
    def __call__(self, parser, namespace, values, option_string=None):
        browsers = namespace.browsers
        for v in values.split(","):
            if v in BROWSER_CHOICES:
                if not v in browsers:
                    browsers.append(v)
            else:
                raise argparse.ArgumentTypeError("Unknown browser '%s'" % v)
        setattr(namespace, 'browsers', browsers)


def main(args=sys.argv[1:]):
    parser = argparse.ArgumentParser(prog="Salad", description='BDD browswer-automation made tasty.')

    parser.add_argument('--browsers', default=DEFAULT_BROWSER,
                     action=CommaSeparatedBrowserAction,
                     help="""Comma-separated list of browsers to use. Default is %s. Options:
                             firefox\n
                             chrome\n
                             zope""" % DEFAULT_BROWSER[0])
    parser.add_argument('args', nargs=argparse.REMAINDER)

    parsed_args = parser.parse_args()
    lettuce_main(args=parsed_args.args)

if __name__ == '__main__':
    main()
