au FileType hsc,cpphs setl syntax=haskell
au FileType haskell,cabal,happy,alex,chaskell,hsc,cpphs setl commentstring=--\ %s
au FileType haskell,hsc,cpphs,chs,happy,alex nnoremap K :Hoogle<CR> 

au FileType cabal setl makeprg=cabal\ check

fun HaskTags()
    call job_start('ghc-tags --ctags')
endfun

fun Hlint()
    call job_start(["/bin/bash", "-c", "hlint " . expand ('%') . ' > /tmp/lints'])
endfun

if executable('ja')
    let s:efm_filt = expand('<sfile>:p:h') . '/../jac/efm.jac'
    fun CabalAsync()
        call job_start(["/bin/zsh", "-c", "echo '' | cabal repl |& ja run " . s:efm_filt . ' > /tmp/errors'])
    endfun
    au FileType haskell,chaskell,happy,alex,hsc,cpphs setl errorformat+=%C\ %m,%E:%f:%l:%c-,%Z\ %.%#
else
    fun CabalAsync()
        call job_start(["/bin/bash", "-c", "echo '' | cabal repl &> /tmp/errors"])
    endfun

    au FileType haskell,chaskell,happy,alex,hsc,cpphs setl errorformat+=%-G[%.%#
    au FileType haskell,chaskell,happy,alex,hsc,cpphs setl errorformat+=%-G(%.%#
    au FileType haskell,chaskell,happy,alex,hsc,cpphs setl errorformat+=%-G\ -\ %.%#

    au FileType haskell,chaskell,happy,alex,hsc,cpphs setl errorformat+=%f:%l:%c:\ %trror:\ [GHC-%n]
    au FileType haskell,chaskell,happy,alex,hsc,cpphs setl errorformat+=%f:%l:%c:\ %tarning:\ [GHC-%n]%m
    au FileType haskell,cpphs setl errorformat+=%E%f:%l:%c-%m
    au FileType haskell,chaskell,happy,alex,hsc,cpphs setl errorformat+=%-G%[A-Z]%.%#
endif

fun HsPop()
    exec 'cg /tmp/errors'
    if filereadable('/tmp/lints')
        exec 'silent caddf /tmp/lints'
    endif
    exec 'cw'
endfun

command! CabalBuild call CabalAsync()
command! Cw call HsPop()
command! HaskTags call HaskTags()

if executable('ghc-tags')
    au BufRead,BufWritePost *.x,*.y,*.chs,*.hsc call HaskTags()
endif

au FileType haskell,chaskell,happy,alex,hsc,cpphs setl makeprg=echo\ ''\ \\\|\ cabal\ repl
