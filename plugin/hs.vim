au FileType hsc,cpphs setl syntax=haskell
au FileType haskell,cabal,happy,alex,chaskell,hsc,cpphs setl commentstring=--\ %s
au FileType haskell,hsc,cpphs,chs,happy,alex nnoremap K :Hoogle<CR> 

au FileType cabal setl makeprg=cabal\ check

au BufWritePost *.hs,*.chs,*.hsc,*.cpphs call job_start('ghc-tags --ctags')

fun CabalAsync()
    call job_start(["/bin/bash", "-c", "echo '' | cabal repl &> /tmp/errors"])
endfun
fun Pop()
    exec 'cg /tmp/errors'
    exec 'cw'
endfun

au BufRead,BufWritePost *.hs,*.x,*.y,*.chs,*.hsc,*.cpphs call CabalAsync()

command! Cw call Pop()

au FileType haskell,chaskell,happy,alex,hsc,cpphs setl makeprg=echo\ ''\ \\\|\ cabal\ repl

au FileType haskell,chaskell,happy,alex,hsc,cpphs setl errorformat+=%f:%l:%c:\ %trror:\ [GHC-%n]
au FileType haskell,chaskell,happy,alex,hsc,cpphs setl errorformat+=%f:%l:%c:\ %tarning:\ [GHC-%n]%m
