## Software
* OS
  - OS X Lion
* Terminal
  - [iTerm 2](http://www.iterm2.com/)
* Shell
  - `zsh`
* Multiplexer
  - `tmux`
* Text editor
  - `vim`
* Font
  - [Inconsolata](http://levien.com/type/myfonts/inconsolata.html)
* Colorscheme 
  - [Solarized](/altercation/solarized)
* Essential applications
  - [Homebrew](/mxcl/homebrew/)
  - [Alfred](http://alfredapp.com)
  - [Moom](http://manytricks.com/moom/)

## How I store my dotfiles
Here is how I sync my dotfiles across machines.

They're all in `~/Dropbox/config/dotfiles`
And I use `homesick` to perform the symlinking

    $ ln -s ~/Dropbox/config/dotfiles ~/.homesick/repos/dotfiles

Perform the symlinking 

    $ homesick symlink dotfiles

Voila!

Check out [homesick](/technicalpickles/homesick) for more
details about the project.
	
## Screenshots
Because, everybody loves them!

Simple `vim` session in iTerm2
![](http://f.cl.ly/items/2Q1W343b3v2e1b2h3R2e/Screen%20Shot%202012-08-19%20at%2020.15.37.png)

As complicated as a prompt need to be
![](http://f.cl.ly/items/1q3r3b1V2a383V3k091U/Screen%20Shot%202012-08-19%20at%2020.20.39.png)

`tmux` hacking session
![](http://f.cl.ly/items/2x2H163n0y0m2o3h2b1z/Screen%20Shot%202012-08-19%20at%2020.25.29.png)
