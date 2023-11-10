tre() { command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

t() {
  if [ $# -eq 0 ]; then
    tre -l 1
  elif [ $# -eq 1 ] && [ "$1" -eq "$1" ] 2>/dev/null; then
    tre -l "$1"
  else
    echo "Invalid argument. Usage: t [n]"
    return 1
  fi
}

ta() {
  if [ $# -eq 0 ]; then
    tre -al 1
  elif [ $# -eq 1 ] && [ "$1" -eq "$1" ] 2>/dev/null; then
    tre -al "$1"
  else
    echo "Invalid argument. Usage: ta [n]"
    return 1
  fi
}
