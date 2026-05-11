# dotfiles

My personal dotfiles, managed with a simple install script (no stow).

## Structure

```
dotfiles/
├── config/      → ~/.config/*   (per-app config dirs)
├── local/bin/   → ~/.local/bin/ (scripts)
├── home/        → ~/.*          (shell dotfiles)
└── install.sh
```

## Install

```bash
./install.sh
```

Creates symlinks for all entries. Skips targets that already exist and are not symlinks (prints a message). Safe to re-run.

## Remove symlinks

```bash
# config
find ~/.config/ -maxdepth 1 -xtype l -delete

# local/bin
find ~/.local/bin/ -maxdepth 1 -xtype l -delete

# home dotfiles
find ~/ -maxdepth 1 -xtype l -delete
```
