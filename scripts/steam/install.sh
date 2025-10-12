#!/bin/bash
set -e

if ! command -v wine-manager &> /dev/null; then
  echo "wine-manager não encontrado no PATH."
  exit 1
fi

PREFIX_NAME="steam"
PREFIX_TYPE="1"
INSTALLER_URL="https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe"

wine-manager create "$PREFIX_NAME" "$PREFIX_TYPE"

TMPDIR=$(mktemp -d)
INSTALLER_PATH="$TMPDIR/steam-installer.exe"

wget -c "$INSTALLER_URL" -O "$INSTALLER_PATH"

if [ ! -s "$INSTALLER_PATH" ]; then
  rm -rf "$TMPDIR"
  echo "Instalador vazio ou não encontrado."
  exit 1
fi

wine-manager run "$PREFIX_NAME" "$INSTALLER_PATH"

rm -rf "$TMPDIR"

echo "Steam(Windows) instalado com sucesso na caixa '$PREFIX_NAME'!"
exit 0
