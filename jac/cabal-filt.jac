:set rs:=/(\^(\.{3})?\n|\[[\d\sof]+\] Compiling.*\n)/;

[x ~? /^\n?[\p{Letter}\/\.]+:/]:?$0
