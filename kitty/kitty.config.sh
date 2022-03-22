echo 'symmlink kitty conf files to default kitty conf dir (~/.config/kitty)'

KITTY_CONFIG_DIR="$HOME/.config/kitty"
mkdir -p "$KITTY_CONFIG_DIR"

function copy_configs() {
  find $HOME/.dotfiles/kitty -iname '*.conf' | {
    local files=()

    while read file; do
      files+=($file)
    done

    # No files? abort.
    if (( ${#files[@]} == 0 )); then return; fi

    # Iterate over files.
    for file in "${files[@]}"; do
      local base="$(basename $file)"
      echo $base
      ln -sf $file $HOME/.config/kitty/$base
    done
  }
}

copy_configs
