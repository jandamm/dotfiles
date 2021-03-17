#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Dash
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/dash.png
# @raycast.packageName Dash
# @raycast.argument1 { "type": "text", "placeholder": "search term", "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "scope", "optional": true }

# @Documentation:
# @raycast.author Jan Damm
# @raycast.authorURL https://github.com/jandamm

open "dash-plugin://keys=$2,query=$1"
