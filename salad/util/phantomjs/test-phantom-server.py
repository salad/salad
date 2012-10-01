import datetime
import requests

num_loops = 100
url_to_open = "http://www.google.com"
# url_to_open = "http://127.0.0.1:8000"


def open_site_with_phantom():
    r = requests.get('http://127.0.0.1:8080?url=%s' % url_to_open)
    # print r.json
    assert r.json["status"] == "success"

start_time = datetime.datetime.now()
for n in range(0, num_loops):
    open_site_with_phantom()

print "Elapsed: %ss" % ((datetime.datetime.now() - start_time),)
