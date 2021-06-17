``` 
     _                    _            ____        _    __ _ _           
    | | ___  _ __  _ __  ( ) ___      |  _ \  ___ | |_ / _(_) | ___  ___ 
 _  | |/ _ \| '_ \| '_ \  V / __|     | | | |/ _ \| __| |_| | |/ _ \/ __|
| |_| | (_) | | | | | | |   \__ \     | |_| | (_) | |_|  _| | |  __/\__ \
 \___/ \___/|_| |_|_| |_|   |___/     |____/ \___/ \__|_| |_|_|\___||___/
```

# Dotfiles
Dotfiles, scripts, and linux settings accumulated over many years of terminal work.

# Disclaimers

You _*must*_ follow the steps in the installation section for these to work properly.

## Platform / Support

Everything here is desinged to work in Bourne Again Shell (BASH).
If it doesn't work in your shell, you're on your own (but most of it should be OK).

I use both Mac and Linux computers.  Most of these contents will work for
both systems.  Some don't.  I haven't labeled what will and won't work in 
each.  Good luck.

Notes: 
 - *To install this code, `python` must be installed and on your path.*
 - Many features in this set of scripts rely on foundational programs to be installed (e.g. `mail`).  Some things won't work without their dependencies.  These dependencies are not documented.  

## OBLIGATORY HIGH-LEVEL WARNING
**USE THIS REPOSITORY AT YOUR OWN PERIL!**

**READ EVERYTHING BEFORE RUNNING ANY OF IT!**

**IT COULD LEAD YOU TO RUIN OR GLORY!**

**YOU HAVE BEEN WARNED!**

# Summary

This dotfiles repo is like many others, but has some key features you must
know about before using it.

As per usual this contains default settings for many programs used at the 
command-line.  This includes things like `vim`, `grep`, `git`, `svn`, and
many, many others.  It's worth combing through everything here to see what
everything is and how it works.

Where this particular setup diverges from most other repos for dotfiles is
that this setup automatically sources many files upon login.  Many of these sourced 
files are normal settings files (e.g. `~/.bashrc`), but there are other files that
are sourced on login which define custom aliases and functions to be used in the 
terminal.  Importantly, these files are sourced en masse by being in certain 
subfolders within this repo (e.g. `dotfiles_root/FUNCTIONS`).  

I have opted for this level of automation so that I can easily script out 
anthing I'm going to do more than twice.

## SECURITY WARNING

The above description should sound dangerous to you.  This _is_ somewhat dangerous.  By building
this repo in this manner I'm sacrificing some security for a lot of convenience.

Be warned - using this setup makes you more vulnerable to certain attacks / nefarious 
activity.

# Features
There are several notable features this repo provides that you should be aware of.

 - A "nice" terminal prompt.
 - A plugin framework for functions and aliases.
 - A plugin framework for prompt updates (e.g. git repo information).

## Plugins
Shell script function plugins live in the `dotfiles_root/FUNCTIONS` folder.  
Any script in that folder will be sourced at login.  

There are other plugin folders and scripts that I will document at a later date.

## Highlighted Functions
 - `epochConvert` - Timestamp conversion
 - `reverseComplement` - Function to reverse complement base strings (supports IUPAC bases).
 - `openGsPath` - Opens the given Google Cloud `gs://` URL in your default web browser.
 - `getGsPath` - Converts between Google Cloud `gs://` and `https://` URLs for ingestion by different tools.
 - `notify` - sends you an email with certain contents
   - This is useful if you have a long running job and you want to know when it's done.  For example:
   ```
   let i=0
   while [ $i -lt 10000 ] ; do 
     sleep 1
     let i=$i+1
   done
   notify
   ```
## Highlighted Aliases

 - `getl` - Print the contents on the given line number from the given file.
 - `stats` - Print stats of a list of numbers supplied via `stdin`.
 - `gitpp` - `git pull && git push`
 - `saytify` - Speaks a message to the user based on the last command run using `say` (outputs audio via your computer's speakers; similar to `notify`).
 - `zotify` - Displays a message to the user based on the last command run using `zenity` (similar to `notify`).

# Installation Procedure
To install Jonn's Dotfiles, download / clone this repo, run the  
`dotfiles_root/install.sh` script in your terminal and follow the instructions.

You will have to provide an email address.  This address is used for things
like `notify`, which will send you emails when jobs are done.  I'm not collecting
it.  I don't want your email address - I have my own.

As part of the installation process, symbolic links will be made to files inside the
`dotfiles_root` folder, so you should probably put this repo / that folder in a 
place where it can live for a long time.

This will backup and replace the following files:

  - ~/.bashrc
  - ~/.gitconfig
  - ~/.screenrc
  - ~/.vimrc
  - ~/.tmux.config

# Acknowledgments
Credit where credit is due.  I have tried to cite the sources for any code
that I have borrowed.  I fully admit that I may have not done that in all
cases (typically for code I found when I was much younger than I am now).

I would be remiss without crediting [@adamhotep](https://github.com/adamhotep) as the person who first introduced
me to the glory of a customized `$PS1` prompt way back when we were proto-adults.

It is also likely that I have written many solutions that are similar to other 
people's work.


Good night and good luck.

