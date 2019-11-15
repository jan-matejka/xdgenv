check the variables we'll look for are not already set
======================================================

  $ env | grep XDG
  [1]
  $ env | grep FOO
  [1]

setup XDG variables
===================

  $ xdgenv exec env | grep XDG | sort
  XDG_CACHE_HOME=/*/.cache (glob)
  XDG_CONFIG_DIRS=/etc/xdg
  XDG_CONFIG_HOME=/*/.config (glob)
  XDG_DATA_DIRS=/usr/local/share:/usr/share
  XDG_DATA_HOME=/*/.local/share (glob)

setup application variables
===========================

  $ . xdgenv-exec FOO foo -- env | grep FOO | sort
  FOO_CACHE_HOME=/*/.cache/foo (glob)
  FOO_CONFIG_DIRS=/etc/xdg/foo
  FOO_CONFIG_HOME=/*/.config/foo (glob)
  FOO_DATA_DIRS=/usr/local/share/foo:/usr/share/foo
  FOO_DATA_HOME=/*/.local/share/foo (glob)

parent environment takes precedence
===================================

  $ export XDG_CONFIG_HOME=/t1
  $ export FOO_CONFIG_HOME=/t2

  $ xdgenv-exec FOO foo -- env | grep -P '(XDG|FOO)_CONFIG_HOME' | sort
  FOO_CONFIG_HOME=/t2
  XDG_CONFIG_HOME=/t1

missing command
===============

  $ xdgenv-exec
  xdgenv-exec: fatal: missing argument command
  [1]

invalid command
===============

  $ xdgenv-exec blergh
  xdgenv-exec: fatal: cannot execute blergh
  [1]
