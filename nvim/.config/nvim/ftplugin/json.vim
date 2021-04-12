call my#lint#enable('jsonlint')

command! -buffer Pretty %!jq .
