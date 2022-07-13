xdgenv
######

Runtime agnostic xdg environment variables initializer for applications
------------------------------------------------------------------------

:Manual section: 1
:Date: 2017-07-02
:Author: Jan Matějka yac@blesmrt.net
:Manual group: xdgenv manual

SYNOPSIS
========

  xdgenv <command> [<args>]

DESCRIPTION
===========

Only supported command is ``exec`` - ``xdgenv exec [<prefix> <dir> --] <command> [<argument>...]``
which

1. initializes the XDG variables to their default values if they are
   not already defined and non-empty

2. exports them into the process environment

3. and executes the given ``command``

If ``prefix`` and ``dir`` were given, it additionally initializes
application specific xdg based variables where ``prefix`` replaces the
``XDG`` in variable name and ``dir`` is a subdirectory appended to the
variable.

Suppose you have an application foo where you want to ensure subcommands
have pre-initialized environment, then::

  xdgenv exec FOO foo -- foo-bar

will initialize the XDG variables plus variables like
``FOO_CONFIG_HOME=${XDG_CONFIG_HOME}/foo`` and executes ``foo-bar``.

However, variables ``XDG_RUNTIME_DIR`` is omitted since it can't be
reasonably implemented properly here.

Note there is no way to only source the variables into current shell
because it is impossible to implement the application specific variables
without resorting to eval due to missing indirect variable reference in
posix shell. Furthermore the exec way is more general (works for
non-shell-based programs) and less error-prone (argv bleed-through,
unexpected shell opts, etc).

BUILD & INSTALLATION
====================

$ make && make check && make install

DEPENDENCIES
============

Build:

* python-docutils

* GNU make

Tests:

* ``dram <https://git.sr.ht/~rne/dram>``

Runtime:

* zsh

.. include:: common-foot.rst
