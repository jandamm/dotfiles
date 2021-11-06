autocmd Filetype swift if !empty(glob(getcwd(), '*.xcodeproj')) | set filetype=ios.swift | endif
