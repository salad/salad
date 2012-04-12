"""Email backend that writes messages to a pre-set file,
so the runner and server can both access it."""

import os

from django.conf import settings
from django.core.mail.backends.filebased import EmailBackend as FileEmailBackend


class SaladOutbox(object):

    @property
    def _outbox_filename(self):
        if not hasattr(self, "_cached_outbox_filename"):
            self._cached_outbox_filename = getattr(settings, "SALAD_OUTBOX_FILE", "/tmp/salad.outbox.log")

        return self._cached_outbox_filename

    @property
    def outbox_file(self):
        if not hasattr(self, "_outbox_file"):
            self._outbox_file = open(self._outbox_filename, 'a+')
        return self._outbox_file

    @property
    def contents(self):
        self.outbox_file.seek(0)
        return self.outbox_file.read()

    @property
    def inbox_count(self):
        return self.contents.count("Content-Type")

    def empty_outbox(self):
        self.close_outbox()
        os.remove(self._outbox_filename)

    def close_outbox(self):
        self.outbox_file.close()

    def add_to_outbox(self, content):
        self.outbox_file.write(content)
        self.outbox_file.flush
        os.fsync(self.outbox_file.fileno())


class EmailBackend(FileEmailBackend, SaladOutbox):

    def send_messages(self, messages, *args, **kwargs):
        """Copy messages to the salad outbox"""
        for m in messages:
            self.add_to_outbox('%s\n' % m.message().as_string())

        return super(EmailBackend, self).send_messages(messages, *args, **kwargs)

    def close(self):
        super(EmailBackend, self).close()
        self.close_outbox()
