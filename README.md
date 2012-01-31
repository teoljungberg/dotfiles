# Metamorfos' Dotfiles
These dotfiles are heavily inspired by [Sirupsen](/Sirupsen)  
The files are based upon his and modified to my liking. Go check out his and be amazed [Sirupsen/dotfiles](http://github.com/Sirupsen/dotfiles/)

## Software
* OS
    - Mac OS X Lion (desktop)
    - Arch Linux (server)
* Terminal
    - [iTerm2](http://www.iterm2.com/)
* Shell
    - `bash`
* Font
    - `monaco`
* Text editor
    - `vim`
    - [MacVim](b4winckler/macvim)
* Colorscheme 
    - [Solarized](altercation/solarized)
* Misc
    - [F.lux](http://stereopsis.com/flux/)
    - [Alfred](http://alfredapp.com)
    - [Dropbox](http://db.tt/jy1BQci) *pst referal link pst*
    - [Homebrew](http://mxcl.github.com/homebrew/)

## How I store my dotfiles
Here is how I sync my dotfiles across machines.

They're all in `~/Dropbox/dotfiles`
And I use `homesick` to perform the symlinking

    $ ln -s ~/Dropbox/dotfiles ~/.homesick/repos/dotfiles

Perform the symlinking 

    $ homesick symlink dotfiles

Since I use two differnt platforms I have aliases that doesn't match
Therefore I have divided them into `osx_aliases` and `linux_aliases`
If the file `~/.osx` exists, bash loads the OS X specific aliases
The same goes for `~/.linux`
The aliases are located inside `~/.aliases`

If you are on a mac

    $ touch ~/.osx

and on linux:

    $ touch ~/.linux

Check out [homesick](http://github.com/technicalpickles/homesick) for more
details about the project. I friggin love it!
	
## PS1 Format
`[pwd] > command`

## Screenshots
Who doesn't love them?

    $ ls -F --color=auto / 

![](http://f.cl.ly/items/0S291q0C3a3N441C191Q/screenshot%202011-12-30%20kl.%2014.09.42.PNG)

Plain `vim` session

![](http://f.cl.ly/items/1U0X2u0W0C0R0Q1x083s/screenshot%202011-12-30%20kl.%2014.10.41.PNG)
