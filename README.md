## Software
<table>
  <tr>
    <th>Shell</th>
    <th>Editor</th>
    <th>Colorscheme</th>
    <th>Version control</th>
    <th>Multiplexer</th>
    <th>Font</th>
  </tr>
  <tr>
    <td>bash</td>
    <td>vim</td>
    <td>Solarized Light</td>
    <td>git</td>
    <td>tmux</td>
    <td><a href="https://github.com/adobe/source-code-pro">Source Code Pro</a> 14pt</td>
  </tr>
</table>


## Setup
I use `linker.sh` to perform the symlinking

```bash
$ git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
$ vim +NeoBundleInstall +qall
```

## Selecta
I use [selecta][selecta] to act as my fuzzy-matcher, install it with

```bash
$ brew install selecta
```

[selecta]:http://github.com/garybernhardt/selecta
