#!/bin/bash
set -euo pipefail

cloudflared=/opt/homebrew/bin/cloudflared
token_dir="$HOME/.cloudflared"
token_file="$token_dir/noah-macbook-pro.token"
service_file=/Library/LaunchDaemons/com.cloudflare.cloudflared.plist

case "${1:-on}" in
  setup)
    # Preserve the existing credential before removing the system service.
    sudo -v
    mkdir -p "$token_dir"
    if [[ ! -s "$token_file" ]]; then
      sudo /usr/bin/install -m 600 -o "$(id -u)" -g "$(id -g)" \
        '/Library/Application Support/com.cloudflare.cloudflared/token' "$token_file"
    fi
    if [[ -e "$service_file" ]]; then
      sudo "$cloudflared" service uninstall
    fi
    if launchctl print system/com.cloudflare.cloudflared >/dev/null 2>&1 || [[ -e "$service_file" ]]; then
      echo 'The automatic service still exists. Setup did not finish.' >&2
      exit 1
    fi
    echo 'Automatic startup removed. Start with mac.iamnoah.com on; stop with Ctrl+C.'
    ;;
  on)
    if [[ -e "$service_file" ]] || [[ ! -r "$token_file" ]]; then
      echo 'First run: mac.iamnoah.com setup' >&2
      exit 1
    fi
    echo 'Starting the tunnel for mac.iamnoah.com. Press Ctrl+C to turn it off.'
    exec "$cloudflared" tunnel --no-autoupdate run --token-file "$token_file"
    ;;
  status)
    if [[ -e "$service_file" ]]; then
      echo 'Automatic startup is still installed.'
    else
      echo 'Automatic startup is not installed.'
    fi
    if pgrep -x cloudflared >/dev/null; then
      echo 'A cloudflared process is running.'
    else
      echo 'No cloudflared process is running.'
    fi
    ;;
  *)
    echo 'Usage: mac.iamnoah.com [setup|on|status]. Stop the foreground tunnel with Ctrl+C.' >&2
    exit 1
    ;;
esac
