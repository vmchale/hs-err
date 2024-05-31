au FileType hsc,cpphs setl syntax=haskell
au FileType haskell,cabal,happy,alex,chaskell,hsc,cpphs setl commentstring=--\ %s
au FileType haskell,hsc,cpphs,chs,happy,alex nnoremap K :Hoogle<CR> 

au FileType cabal setl makeprg=cabal\ check

fun Hlint()
    call job_start(["/bin/bash", "-c", "hlint " . expand ('%') . ' > /tmp/lints'])
endfun

fun CabalAsync()
    call job_start(["/bin/bash", "-c", "echo '' | cabal repl &> /tmp/errors"])
endfun
fun HsPop()
    exec 'cg /tmp/errors'
    exec 'caddf /tmp/lints'
    exec 'cw'
endfun

command! CabalBuild call CabalAsync()

command! Cw call HsPop()

au FileType haskell,chaskell,happy,alex,hsc,cpphs setl makeprg=echo\ ''\ \\\|\ cabal\ repl

au FileType haskell,chaskell,happy,alex,hsc,cpphs setl errorformat+=%f:%l:%c:\ %trror:\ [GHC-%n]
au FileType haskell,chaskell,happy,alex,hsc,cpphs setl errorformat+=%f:%l:%c:\ %tarning:\ [GHC-%n]%m
au FileType haskell,cpphs setl errorformat+=%E%f:%l:%c-%m
