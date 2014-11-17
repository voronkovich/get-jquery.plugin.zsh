get-jquery.plugin.zsh
=====================

Plugin for fast downloading jQuery library from code.jquery.com

Installation
------------

Antigen:
    
    antigen bundle voronkovich/get-jquery.plugin.zsh

Or clone this repo and add this into your .zshrc:

    fpath=(path/to/cloned/repo $fpath)

Usage:
------

    get-jquery [options...] [target directory or file] 

Options:

    -v, --jquery-version  set jQuery version
    -u, --uncompressed    get uncompressed (development) version
    -h, --h, --help       show this output

Examples:

    get-jquery -u -v1.0.1 js/jquery-latest.js
    get-jquery . # will get the latest jQuery release and save into the current directory

Demo
----

![gif](http://i.imgur.com/X599HC2.gif)

License
-------

Copyright (c) Voronkovich Oleg. Distributed under the Unlicense.
