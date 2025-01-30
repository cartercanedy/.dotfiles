#!/bin/sh -e

if ! which stow -s > /dev/null 2>&1; then
  OS_INFO=""

  if [ -f "/etc/os-release" ]; then
    OS_INFO="/etc/os-release"
  elif [ -f "/usr/lib/os-release" ]; then
    OS_INFO="/usr/lib/os-release"
  else
    echo "Unknown environment"
    exit 1
  fi

  . "$OS_INFO"

  case "$ID_LIKE" in
    *debian*)
      sudo apt install stow -y
      ;;
    *fedora*)
      sudo dnf -y install stow
      ;;
    *)
      echo "Unknown OS kind: $ID_LIKE"
      exit 1
      ;;
  esac
fi

stow .
