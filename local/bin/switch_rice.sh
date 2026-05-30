#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: $0 /ruta/a/la/imagen.jpg"
    exit 1
fi

# Convertir a ruta absoluta real
WALLPAPER_PATH=$(realpath "$1")

echo "Cambiando fondo a: $WALLPAPER_PATH"

# 1. Cambiar el fondo usando la herramienta oficial de KDE Plasma
plasma-apply-wallpaperimage "$WALLPAPER_PATH"

echo "Fondo de pantalla actualizado..."

# 2. Ejecutar Matugen con tu configuración automática de saturación
matugen image --mode dark -t scheme-tonal-spot --prefer saturation "$WALLPAPER_PATH"

# 3. Forzar el refresco de colores en KDE Plasma
plasma-apply-colorscheme BreezeDark > /dev/null
plasma-apply-colorscheme Matugen

# 4. Live reload current Konsole profile
konsoleprofile colors=Matugen &>/dev/null

# 5. Live reload ALL active Kitty terminals instantly
kill -SIGUSR1 $(pgrep -x kitty) &>/dev/null

echo "¡Entorno adaptado con éxito!"
