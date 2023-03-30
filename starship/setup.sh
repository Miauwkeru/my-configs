curl https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip -o /tmp/firacode.zip
mkdir -p ~/.local/share/fonts/
unzip ~/Downloads/FiraCode.zip -d ~/.local/share/fonts/
fc-cache -f -v

# Set as a default for your terminal program
# Set as a default for other programs
mkdir -p ~/.config
cp starship.toml ~/.config/starship.toml