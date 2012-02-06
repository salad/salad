import sys
import os

from lettuce import lettuce_cli
from lettuce.fs import FileSystem


def main(args=sys.argv[1:]):
    # set up glossary
    base_dir = os.path.join(os.path.dirname(os.curdir), 'features')
    glossary_filenames = FileSystem.locate(base_dir, "glossary.py")

    sys.path.insert(0, base_dir)
    for g_file in glossary_filenames:
        print g_file
        to_load = FileSystem.filename(g_file, with_extension=False)
        print to_load
        try:
            module = __import__(to_load, globals(), locals(), ["SALAD_GLOSSARY", ])
        except Exception, e:
            print "Exception: %s" % e
            pass

        reload(module)
        globals()['SALAD_GLOSSARY'] = module.SALAD_GLOSSARY
    sys.path.remove(base_dir)

    lettuce_cli.main(*args)

if __name__ == '__main__':
    main()
