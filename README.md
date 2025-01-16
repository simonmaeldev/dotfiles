# dotfiles
my dotfiles, managed by stow

## installation

install the dependencies

```sh
sudo apt install stow
```

## Usage

```sh
stow .
```

If it throws an error because the files already exists, you can do
```sh
stow --adapt .
```
This will move all conflicting files to the repo **AND OVERRIDE THEM**. Good thing we are in git and can fix the changes.
