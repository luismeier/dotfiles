# add my scripts
setopt nullglob
for file in "$HOME/dotfiles/zsh/zsh_scripts/"*.zsh; do
  [ -f "$file" ] || continue
  source "$file"
done

for file in "$HOME/dotfiles/zsh/zsh_scripts/"*.bash; do
  [ -f "$file" ] || continue
  source "$file"
done
setopt globdots
