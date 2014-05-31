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
    <td>zsh</td>
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
$ mkdir -p ~/.cache/vim/undo
$ git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
$ vim +NeoBundleInstall +qall
```

[homesick_home]:http://github.com/technicalpickles/homesick
