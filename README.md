# reek.vim

Code smell detector for Ruby in Vim.

> [Reek](https://github.com/troessner/reek) is a tool that examines Ruby
> classes, modules and methods and reports any code smells it finds.

### Usage

Open any Ruby file and you will be able to see the messages using the location
list (e.g. by invoking `:lopen` or `:ll`). See more about location using 
`:help location-list` or see the 
[online documention](http://vimdoc.sourceforge.net/htmldoc/quickfix.html).

### Installation

Place the `plugin/reek.vim` file in your `.vim/plugin` directory.
Please make sure that `reek` is up-to-date.

This plugin is also compatible with 
[pathogen](https://github.com/tpope/vim-pathogen). 
Integration can be implemented similar to 
[syntastic](https://github.com/scrooloose/syntastic) (where you also can find 
a nice set-up guide in the README)

### Todo

- Compatibility with others code metrics gems like
  [flog](http://ruby.sadi.st/Flog.html) and
  [flay](http://ruby.sadi.st/Flay.html).
- Vim Documentation

### License

Copyright (c) Rainer Borene. Distributed under the same terms as Vim itself. See
`:help license`.
