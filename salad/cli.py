import sys

from lettuce.bin import main as lettuce_main


def main(args=sys.argv[1:]):
    # Right now, this doesn't do anything but alias.  More useful is coming though!
    lettuce_main(args=sys.argv[1:])

if __name__ == '__main__':
    main()
