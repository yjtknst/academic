#!/bin/sh
export EMACS="/Applications/Emacs-build/Emacs.app/Contents/MacOS/Emacs"
$EMACS --batch --no-init-file --load  build-site.el
