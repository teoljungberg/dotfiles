## Software
<table>
  <tr>
    <th> OS </th>
    <th> Terminal </th>
    <th> Shell </th>
    <th> Editor </th>
    <th> Version control </th>
    <th> Multiplexer </th>
  </tr>
  <tr>
    <td> OS X Lion </td>
    <td> iTerm 2 </td>
    <td> zsh </td>
    <td> vim </td>
    <td> git </td>
    <td> tmux </td>
  </tr>
</table>

## How I store my dotfiles
I use [homesick][homesick_home] to perform the symlinking

```bash
$ homesick clone metamorfos/dotfiles
$ homesick symlink metamorfos/dotfiles
```

[homesick_home]:http://github.com/technicalpickles/homesick
