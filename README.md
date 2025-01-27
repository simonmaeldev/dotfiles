# dotfiles

my dotfiles, managed by stow

## installation

install the dependencies

```sh
sudo apt install stow git wget curl unzip zsh ripgrep fzf pip tree tmux bc coreutils gawk jq playerctl python3-debugpy
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

### Oh my zsh

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

To avoid later conflict, if you just installed omzsh, please remove .zshrc

### uv

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### nvm for npm for neovim

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

Close and reopen a terminal

```sh
nvm install node
```

### neovim

```sh
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz \
&& sudo rm -rf /opt/nvim \
&& sudo tar -C /opt -xzf nvim-linux64.tar.gz \
&& git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim \
&& uv tool install python-lsp-server \
&& uv tool install ruff
```

installing package manager (packer) and lsp for python

### aider

```sh
uv tool install aider-chat
```

### ollama

```sh
curl -fsSL https://ollama.com/install.sh | sh
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

### Plugins installations

#### neovim

```sh
cd $HOME/.config/nvim \
nvim lua/apprentyr/packer.lua
```

```neovim
:so
:PackerSync
```

:so is to source the file, :PackerSync to install the packages

#### tmux

```sh
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux source ~/.config/tmux/tmux.conf
```

press `ctrl+b I` to Install the plugins
