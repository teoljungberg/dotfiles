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
    <td>Solarized Dark</td>
    <td>git</td>
    <td>tmux</td>
    <td><a href="http://www.levien.com/type/myfonts/inconsolata.html">Inconsolata</a> 13pt</td>
  </tr>
</table>


## Setup
I use `linker.sh` to perform the symlinking

```bash
$ mkdir -p ~/.cache/vim/{undo,backup,swap}
$ git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
$ vim +NeoBundleInstall +qall
```

[homesick_home]:http://github.com/technicalpickles/homesick
