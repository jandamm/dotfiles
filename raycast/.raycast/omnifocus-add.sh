#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add to OmniFocus
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/omnifocus.png
# @raycast.packageName OmniFocus
# @raycast.argument1 { "type": "text", "placeholder": "title" }
# @raycast.argument2 { "type": "text", "placeholder": "note", "optional": true }

# @Documentation:
# @raycast.author Jan Damm
# @raycast.authorURL https://github.com/jandamm

osascript -e "tell front document of application \"OmniFocus\" to make new inbox task with properties {name:\"$1\",note:\"$2\"}" >/dev/null
