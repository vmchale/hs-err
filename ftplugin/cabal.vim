setl makeprg=cabal\ check
setl errorformat=%E%f:%l:%c:\ %trror%m,%Z%m
setl errorformat+=Warning:\ [parser-%tarning]\ %f:%l:%c:%m
setl errorformat+=Warning:\ [doc-place]\ %m
setl errorformat+=Warning:\ [no-modules-exposed]\ %m
setl errorformat+=Error:\ [no-default-language]\ %m
