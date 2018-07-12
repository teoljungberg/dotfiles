let g:ftplugin_rust_source_path =
      \ "$(rustc --print sysroot)/lib/rustlib/src/rust/src"
let g:racer_cmd = "$HOME/.cargo/bin/racer"

setlocal iskeyword+=!

nmap <buffer> K <Plug>(rust-doc)
