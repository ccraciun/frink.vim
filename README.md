# vim-frink

Vim syntax highlighting for [Frink](https://frinklang.org)

## Installation

* With [Pathogen][vim pathogen]

        cd ~/.vim/bundle
        git clone git://github.com/ccraciun/frink.vim.git

* With [Vundle][vim vundle]

        " .vimrc
        Bundle 'ccraciun/frink.vim'

[vim pathogen]: http://www.vim.org/scripts/script.php?script_id=2332
[vim vundle]: https://github.com/gmarik/vundle
[frink syntax]: https://frinklang.org/#NumericTypes

## Usage

I use [vim-pipe](https://github.com/krisajenkins/vim-pipe) to run code semi-interactively

Ideally a more robust system where the user could run code then drop into interactive mode or pass frink
the file name.

## TODOs

- highlight stdlib functions.
- Configurable highlighting of {units,functions}
- indentation.
- Compile and run from file.
