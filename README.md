## Software
<table>
  <tr>
    <th> Shell </th>
    <th> Editor </th>
    <th> Colorscheme </th>
    <th> Version control </th>
    <th> Multiplexer </th>
    <th> Font </th>
  </tr>
  <tr>
    <td> zsh </td>
    <td> vim </td>
    <td> Solarized Light </td>
    <td> git </td>
    <td> tmux </td>
    <td> <a href=http://blogs.adobe.com/typblography/2012/09/source-code-pro.html>Source Code Pro 14pt</a> </td>
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
