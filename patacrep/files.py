# -*- coding: utf-8 -*-
"""File system utilities."""

from contextlib import contextmanager
import fnmatch
import os
import posixpath

def recursive_find(root_directory, pattern):
    """Recursively find files matching a pattern, from a root_directory.

    Return a list of files matching the pattern.
    """
    if not os.path.isdir(root_directory):
        return []

    matches = []
    with chdir(root_directory):
        for root, __ignored, filenames in os.walk(os.curdir):
            for filename in fnmatch.filter(filenames, pattern):
                matches.append(os.path.join(root, filename))
    return matches

def relpath(path, start=None):
    """Return relative filepath to path if a subpath of start."""
    if start is None:
        start = os.curdir
    if os.path.abspath(path).startswith(os.path.abspath(start)):
        return os.path.relpath(path, start)
    else:
        return os.path.abspath(path)


def path2posix(string):
    """"Convert path from local format to posix format."""
    if not string or string == "/":
        return string
    if os.path.splitdrive(string)[1] == "\\":
        # Assuming DRIVE:\
        return string[0:-1]
    (head, tail) = os.path.split(string)
    return posixpath.join(
            path2posix(head),
            tail)

@contextmanager
def chdir(path):
    """Locally change dir

    Can be used as:

        with chdir("some/directory"):
            do_stuff()
    """
    olddir = os.getcwd()
    if path:
        os.chdir(path)
        yield
        os.chdir(olddir)
    else:
        yield