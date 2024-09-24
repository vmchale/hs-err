:set rs:=/(\^(\.{3})?\n|\[[\d\sof]+\] Compiling.*\n)/;
:set fs:=/\n/;

fn process(err) :=
  let
    val file := option '' [x] (err->1)
    val lc := option '' [':'+x] (err->2)
    val msg := [x+'\n'+y]|>(err->3)
  in sprintf '%s%s-%i\n%s' (file.lc.(err->4).msg) end;

process¨
  {%/^\n*[\p{Letter}\/\.]+:/}
    {(`1 ~* 1 /^([\p{Letter}\/\.]+)/
    . `1 ~* 1 /(\d+:\d+)/
    . ([x~/^\s+(\p{Letter}|•|_|\()/]#.`$)
    . option 0 # (`* ~* 1 /(\^+)/)
    )}
