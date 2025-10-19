#!/bin/bash
set -e

if ! command -v wine-manager &> /dev/null; then
  echo "wine-manager não encontrado no PATH."
  exit 1
fi

PREFIX_NAME="npp"
PREFIX_TYPE="2"
INSTALLER_URL="https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.8.6/npp.8.8.6.Installer.x64.exe"

wine-manager create "$PREFIX_NAME" "$PREFIX_TYPE"

TMPDIR=$(mktemp -d)
INSTALLER_PATH="$TMPDIR/npp-installer.exe"

wget -c "$INSTALLER_URL" -O "$INSTALLER_PATH"

if [ ! -s "$INSTALLER_PATH" ]; then
  rm -rf "$TMPDIR"
  echo "Instalador vazio ou não encontrado."
  exit 1
fi

wine-manager run "$PREFIX_NAME" "$INSTALLER_PATH"

rm -rf "$TMPDIR"

echo "Notepad++ instalado com sucesso na caixa '$PREFIX_NAME'!"
exit 0
