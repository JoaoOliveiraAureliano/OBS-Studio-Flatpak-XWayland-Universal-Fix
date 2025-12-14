#!/bin/bash

# ==========================
# Cores
# ==========================
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== OBS Studio Flatpak • XWayland Universal Fix ===${NC}"
echo "Compatível com GNOME, KDE, Hyprland, Sway e outros compositores Wayland"

# ==========================
# Verifica OBS Flatpak
# ==========================
if ! flatpak list | grep -q "com.obsproject.Studio"; then
    echo -e "${RED}[ERRO] OBS Studio (Flatpak) não está instalado.${NC}"
    echo "Instale com: flatpak install flathub com.obsproject.Studio"
    exit 1
fi

# ==========================
# Instala XWayland se necessário
# ==========================
echo -e "\n${YELLOW}[Verificando XWayland...]${NC}"

install_xwayland() {
    case "$1" in
        arch|manjaro|endeavouros|cachyos)
            if ! pacman -Qi xorg-xwayland &>/dev/null; then
                echo "Instalando xorg-xwayland..."
                sudo pacman -S --noconfirm xorg-xwayland
            else
                echo "xorg-xwayland já está instalado."
            fi
            ;;
        debian|ubuntu|pop|mint|neon)
            if ! dpkg -l | grep -q xwayland; then
                echo "Instalando xwayland..."
                sudo apt update && sudo apt install -y xwayland
            else
                echo "xwayland já está instalado."
            fi
            ;;
        fedora|rhel|centos)
            if ! rpm -q xorg-x11-server-Xwayland &>/dev/null; then
                echo "Instalando xorg-x11-server-Xwayland..."
                sudo dnf install -y xorg-x11-server-Xwayland
            else
                echo "xorg-x11-server-Xwayland já está instalado."
            fi
            ;;
        *)
            echo -e "${YELLOW}[AVISO] Distro não reconhecida automaticamente.${NC}"
            echo "Certifique-se de que o pacote 'xwayland' está instalado."
            ;;
    esac
}

if [[ -f /etc/os-release ]]; then
    DISTRO=$(grep -oP '^ID=\K\w+' /etc/os-release)
    install_xwayland "$DISTRO"
else
    echo -e "${YELLOW}[AVISO] Não foi possível detectar a distribuição.${NC}"
fi

# ==========================
# Detecta DISPLAY válido
# ==========================
echo -e "\n${YELLOW}[Detectando sessão XWayland...]${NC}"

VALID_DISPLAY=""

check_display() {
    local d="${1#:}"
    [[ -S "/tmp/.X11-unix/X$d" ]]
}

if [[ -n "$DISPLAY" ]] && check_display "$DISPLAY"; then
    VALID_DISPLAY="$DISPLAY"
    echo -e "${GREEN}✔ DISPLAY atual válido: $DISPLAY${NC}"
elif check_display ":0"; then
    VALID_DISPLAY=":0"
    echo -e "${YELLOW}↪ Usando DISPLAY fallback :0${NC}"
else
    for sock in /tmp/.X11-unix/X*; do
        [[ -S "$sock" ]] || continue
        VALID_DISPLAY=":${sock##*X}"
        echo -e "${YELLOW}↪ DISPLAY detectado automaticamente: $VALID_DISPLAY${NC}"
        break
    done
fi

if [[ -z "$VALID_DISPLAY" ]]; then
    echo -e "${RED}[ERRO] Nenhuma sessão XWayland acessível foi encontrada.${NC}"
    echo "Verifique se o XWayland está habilitado no compositor."
    exit 1
fi

# ==========================
# Aplica overrides Flatpak
# ==========================
echo -e "\n${YELLOW}[Aplicando permissões Flatpak...]${NC}"

# Limpa configurações anteriores para evitar conflitos (Adicionado)
echo "Limpando configurações antigas..."
flatpak override --user --reset com.obsproject.Studio 2>/dev/null

echo "Aplicando novas configurações..."
flatpak override --user \
  --socket=x11 \
  --nosocket=wayland \
  --filesystem=/tmp/.X11-unix \
  --env=QT_QPA_PLATFORM=xcb \
  --env=DISPLAY=$VALID_DISPLAY \
  com.obsproject.Studio

# ==========================
# Final
# ==========================
echo -e "\n${GREEN}=== CONCLUÍDO ===${NC}"
echo "OBS será executado via XWayland"
echo "DISPLAY em uso: $VALID_DISPLAY"
echo "Abra o OBS normalmente pelo menu do sistema."
