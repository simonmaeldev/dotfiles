# dotfiles
my dotfiles, managed by stow

## installation

install the dependencies

```sh
sudo apt install stow
```

### fonts

```sh
git clone https://github.com/powerline/fonts.git --depth=1 \
&& cd fonts \
&& ./install.sh \
&& cd .. \
&& rm -rf fonts \
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/DejaVuSansMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Monaspace.zip \
&& cd ~/.local/share/fonts \
&& unzip DejaVuSansMono.zip \
&& unzip Monaspace.zip \
&& rm DejaVuSansMono.zip \
&& rm Monaspace.zip \
&& fc-cache -fv
```
If on a wsl, also downloads and install the fonts:
- [monaspice](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Monaspace.zip)
- [DejaVuSansMono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/DejaVuSansMono.zip)


## Usage

```sh
stow .
```

If it throws an error because the files already exists, you can do
```sh
stow --adapt .
```
This will move all conflicting files to the repo **AND OVERRIDE THEM**. Good thing we are in git and can fix the changes.
