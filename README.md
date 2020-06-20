# dotfiles

![screenshot](screenshot.png)


## Installation

Install [brew](https://brew.sh/) first.

```
git clone https://github.com/surjikal/dotfiles.git ~/.dotfiles && cd $_
brew bundle
stow zsh
exec zsh -l
```

## Managing dotfiles

| command      | description                                      |
|--------------|--------------------------------------------------|
| `dot`        | edit dotfiles in vscode                          |
| `dot <file>` | edit a specific dotfile, supports tab completion |
| `reload`     | reload the shell                                 |
| `ohshit`     | escape hatch if shell is broken                  |

# Sample built-in commands

| command      | description                                      |
|--------------|--------------------------------------------------|
| `ramdisk`    | mount 8GB RAM volume                             |
| `gg`         | `git gui`                                        |
| `gk`         | `gitk --all`                                     |
| `gf`         | `git fetch --all`                                |


## Features

- [ohmyzsh](https://ohmyz.sh) for theming / plugins
- [antibody](https://getantibody.github.io) for plugins
- [stow](https://www.gnu.org/software/stow) support
- add new dotfiles here [`zsh/.zshrc.d`](https://github.com/surjikal/dotfiles/zsh/.zshrc.d)
- edit dotfiles with `dot` command (tab completion supported)

### zsh

Add / remove dotfiles here: [`zsh/.zshrc.d`](https://github.com/surjikal/dotfiles/zsh/.zshrc.d)
These scripts are loaded automatically and in-order.

Use `dot plugins` to edit zsh plugins

### stow

[Stow](https://www.gnu.org/software/stow) will symlink the contents of a directory into your home directory.
This helps manage things like app config files.

For example, there's a `nano` directory in this repo that contains a `.nanorc`.
If you run `stow nano`, it will symlink `~/.dotfiles/nano/.nanorc` to `~/.nanorc`.

The dotfiles allow you to specify which directories you want to automatically stow on startup.
Run `dot stow` and edit the `STOWED` array.


## Shoutouts to...

- [Mathias Bynens](https://mathiasbynens.be/)
- [Brandon LeBlanc](https://github.com/demosdemon)
- [draculatheme.com/gitk](https://draculatheme.com/gitk)
