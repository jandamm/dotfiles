autocmd Filetype swift if !empty(globpath(getcwd(), '*.xcodeproj')) | set filetype=ios.swift | endif
