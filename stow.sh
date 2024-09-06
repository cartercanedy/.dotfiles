__=$(which stow)

if ! [ "$?" = "0" ]; then

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

    echo "$ID_LIKE" | sed 's/.*\(debian|fedora\).*/\1/'
  )

  case "$OS_TYPE" in
    debian)
      sudo apt install stow -y
      ;;
    fedora)
      sudo dnf -y install stow
      ;;
    *)
      ;;
  esac
fi

stow .
