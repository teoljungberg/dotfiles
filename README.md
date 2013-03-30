## Software
<table>
  <tr>
    <th> OS </th>
    <th> Terminal </th>
    <th> Shell </th>
    <th> Editor </th>
    <th> Colorscheme </th>
    <th> Version control </th>
    <th> Multiplexer </th>
  </tr>
  <tr>
    <td> OS X Lion </td>
    <td> iTerm 2 </td>
    <td> zsh </td>
    <td> vim </td>
    <td> Solarized Light </td>
    <td> git </td>
    <td> tmux </td>
  </tr>
</table>


## Setup
I use [homesick][homesick_home] to perform the symlinking

```bash
$ homesick clone metamorfos/dotfiles
$ homesick symlink metamorfos/dotfiles
$ mkdir -p ~/.cache/vim/{undo,backup,swap}
$ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
$ vim +BundleInstall +qall
```

[homesick_home]:http://github.com/technicalpickles/homesick
