# Metamorfos' Dotfiles
These dotfiles are heavily inspired by [Sirupsen](Sirupsen)  
The files are based upon his and modified to my liking. Go check out his and be amazed [Sirupsen/dotfiles](Sirupsen/dotfiles/)

## Software
* OS
    - Mac OS X Lion 
    - Arch Linux
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

![](http://f.cl.ly/items/3x1t2U3t3Z410c33131Z/screenshot%202012-02-06%20kl.%2023.28.14.PNG)

Plain `vim` session

![](http://f.cl.ly/items/3x1t2U3t3Z410c33131Z/screenshot%202012-02-06%20kl.%2023.28.14.PNG)
