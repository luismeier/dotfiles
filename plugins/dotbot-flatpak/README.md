[dotbot_repo]: https://github.com/anishathalye/dotbot

## Dotbot ```flatpak``` Plugin

Plugin for [Dotbot][dotbot_repo], that adds ```flatpak``` directive, which allows you to install flatpak packages 

## Installation

1. Simply add this repo as a submodule of your dotfiles repository:
```
git submodule add https://github.com/DrDynamic/dotbot-flatpak.git
```

2. Pass this folder (or directly flatpak.py file) path with corresponding flag to your [Dotbot][dotbot_repo] script:
  - ```-p /path/to/file/flatpak.py```

  or

 - ```--plugin-dir /pato/to/plugin/folder```

## Supported task variants
```yaml
...
- flatpak: 
    - app 1
    - app 2
    - app 3
    ...
```

## Usage

### Example config
```yaml
...
- flatpak:
    - flatseal
    - bitwarden
    ...
...
```

### Execution
```bash
"~/.dotfiles/bin/dotbot" -d "~/.dotfiles" -c "~/.dotfiles/packages.yaml" -p "~/.dotfiles/plugins/dotbot-flatpak/flatpak.py"
```
