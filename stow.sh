#!/bin/sh -e

if which stow -s; then
  OS_TYPE=$(
    OS_INFO=""

    if [ -f "/etc/os-release" ]; then
      OS_INFO="/etc/os-release"
    elif [ -f "/usr/lib/os-release" ]; then
      OS_INFO="/etc/os-release"
    else
      echo ""
      exit
    fi

    . "$OS_INFO"

    OS_TYPE="$(echo "$ID_LIKE" | sed 's/.*\(debian|fedora\).*/\1/')"

    if [ "$OS_TYPE" = "" ]; then
      echo "$ID_LIKE"
      exit 1
    else
      echo "$OS_TYPE"
    fi
  )

  if ! [ "$?" = "0" ]; then
    echo "Error: couldn't identify os: $OS_TYPE"
    exit 1
  fi

  case "$OS_TYPE" in
    debian)
      sudo apt install stow -y
      ;;
    fedora)
      sudo dnf -y install stow
      ;;
  esac
fi

stow .
