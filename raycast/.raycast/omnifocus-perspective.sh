#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Show perspective in OmniFocus
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/omnifocus.png
# @raycast.packageName OmniFocus
# @raycast.argument1 { "type": "text", "placeholder": "Perspective", "percentEncoded": true }

# @Documentation:
# @raycast.author Jan Damm
# @raycast.authorURL https://github.com/jandamm

open "omnifocus:///perspective/$1"
