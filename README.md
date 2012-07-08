## Software
* OS
  - Mac OS X Lion (desktop)
  - Arch Linux (server)
* Terminal
  - [iTerm2](http://www.iterm2.com/)
* Shell
  - `zsh`
* Text editor
  - `vim`
  - [MacVim](/b4winckler/macvim)
* Colorscheme 
  - [Solarized](/altercation/solarized)
* Misc
  - [F.lux](http://stereopsis.com/flux/)
  - [Alfred](http://alfredapp.com)
  - [Dropbox](http://db.tt/jy1BQci) *pst referal link pst*
  - [Homebrew](/mxcl/homebrew/)

## How I store my dotfiles
Here is how I sync my dotfiles across machines.

They're all in `~/Dropbox/dotfiles`
And I use `homesick` to perform the symlinking

  % ln -s ~/Dropbox/dotfiles ~/.homesick/repos/dotfiles

Perform the symlinking 

  % homesick symlink dotfiles

Voila!
Check out [homesick](/technicalpickles/homesick) for more
details about the project.
	
## PS1 Format
`[ pwd ] % command`

