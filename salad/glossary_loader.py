import sys
import os

from lettuce.fs import FileSystem

base_dir = os.path.join(os.path.dirname(os.curdir), 'features')
glossary_filenames = FileSystem.locate(base_dir, "glossary.py")

sys.path.insert(0, base_dir)
for g_file in glossary_filenames:
    print g_file
    to_load = FileSystem.filename(g_file, with_extension=False)
    print to_load
    try:
        # module = __import__(to_load, globals(), locals(), ["SALAD_GLOSSARY", ])
        module = __import__(to_load)
        reload(module)
    except Exception, e:
        print "Exception: %s" % e
        pass

sys.path.remove(base_dir)

SALAD_GLOSSARY = getattr(module, "SALAD_GLOSSARY", {})
