#!/bin/bash
set -e

if ! command -v wine-manager &> /dev/null; then
  echo "wine-manager não encontrado no PATH."
  exit 1
fi

PREFIX_NAME="epic-games"
PREFIX_TYPE="1"
INSTALLER_URL="https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi"

wine-manager create "$PREFIX_NAME" "$PREFIX_TYPE"

TMPDIR=$(mktemp -d)
INSTALLER_PATH="$TMPDIR/epic-games-installer.msi"

wget -c "$INSTALLER_URL" -O "$INSTALLER_PATH"

if [ ! -s "$INSTALLER_PATH" ]; then
  rm -rf "$TMPDIR"
  echo "Instalador vazio ou não encontrado."
  exit 1
fi

wine-manager run "$PREFIX_NAME" "$INSTALLER_PATH"

rm -rf "$TMPDIR"

WINEPREFIX="$HOME/.wine_boxes/epic-games" winetricks -q corefonts dxvk mf

echo "Epic Games instalado com sucesso na caixa '$PREFIX_NAME'!"
exit 0
