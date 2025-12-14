# OBS Studio Flatpak • XWayland Universal Fix

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Bash](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Flatpak](https://img.shields.io/badge/Flatpak-4A90D9?style=for-the-badge&logo=flatpak&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)

<div align="center">
  <a href="#-english-description">🇺🇸 English</a> | 
  <a href="#-descrição-em-português">🇧🇷 Português</a>
</div>

---

## 🇺🇸 English Description

### About
This script addresses specific issues with **OBS Studio (Flatpak)** running on **Wayland** environments (especially with NVIDIA GPUs). It forces OBS to run via **XWayland** and applies the necessary permissions to ensure full compatibility.

While OBS supports Wayland natively, several features—specifically those relying on **CEF (Chromium Embedded Framework)**—can break. Common symptoms include:
* ❌ **Browser Docks failing:** Twitch/YouTube integration (Chat, Activity Feed) doesn't load.
* ❌ **Login issues:** Unable to sign in directly to services; forced to use Stream Keys.
* ❌ **Stream Info:** Cannot edit Title, Game, or Tags directly inside OBS.

By forcing **XWayland** and correctly setting the `DISPLAY` environment variable, this script restores all these functionalities.

### Features
* Forces OBS Flatpak to use **XWayland** (fixing CEF/Browser issues).
* **Auto-detects** a valid X11 Display (prevents "Could not connect to display" errors).
* **Auto-installs** `xwayland` dependency if missing (Arch, Debian, Fedora based distros).
* **Clean Slate:** Resets old Flatpak overrides to avoid conflicts before applying the fix.

### Compatibility
Works on any Wayland compositor that supports XWayland:
* KDE Plasma (Wayland)
* GNOME (Wayland)
* Hyprland, Sway, Wayfire, etc.

###  Supported Distributions
* **Arch Linux & derivatives:** Manjaro, EndeavourOS, **CachyOS**
* **Debian & derivatives:** Ubuntu, Pop!_OS, Linux Mint, KDE Neon
* **Fedora / RHEL / CentOS**

###  Prerequisites
* OBS Studio installed via Flatpak:
    ```bash
    flatpak install flathub com.obsproject.Studio
    ```
* System running a Wayland session.

### Usage

1.  **Clone the repo:**
    ```bash
    git clone [https://github.com/vol1t/OBS-Studio-Flatpak-XWayland-Universal-Fix.git](https://github.com/vol1t/OBS-Studio-Flatpak-XWayland-Universal-Fix.git)
    cd OBS-Studio-Flatpak-XWayland-Universal-Fix
    ```

2.  **Make it executable:**
    ```bash
    chmod +x obs-xwayland-fix.sh
    ```

3.  **Run it:**
    ```bash
    ./obs-xwayland-fix.sh
    ```

4.  **Restart:** If the script installed XWayland for the first time, reboot your system.

###  Reverting Changes
To undo everything and return OBS to its default state:
```bash
flatpak override --user --reset com.obsproject.Studio
```
--- 

## 🇧🇷 Descrição em Português

###  Sobre
Este script resolve problemas específicos do **OBS Studio (Flatpak)** rodando em ambientes **Wayland** (especialmente com GPUs NVIDIA). Ele força o OBS a rodar via **XWayland** e aplica as permissões necessárias para garantir compatibilidade total.

Embora o OBS suporte Wayland nativamente, várias funcionalidades—especificamente aquelas que dependem do **CEF (Chromium Embedded Framework)**—podem quebrar. Sintomas comuns incluem:
* ❌ **Falha nos Painéis Web:** A integração com Twitch/YouTube (Chat, Feed de Atividades) não carrega.
* ❌ **Problemas de Login:** Não é possível fazer login diretamente nos serviços; forçando o uso de chaves de transmissão.
* ❌ **Informações da Stream:** Não é possível editar Título, Jogo ou Tags diretamente dentro do OBS.

Ao forçar o **XWayland** e configurar corretamente a variável de ambiente `DISPLAY`, este script restaura todas essas funcionalidades.

###  Funcionalidades
* Força o OBS Flatpak a usar **XWayland** (corrigindo problemas de CEF/Navegador).
* **Auto-detecta** um Display X11 válido (previne erros de "Could not connect to display").
* **Auto-instala** a dependência `xwayland` se estiver faltando (distros baseadas em Arch, Debian, Fedora).
* **Começo Limpo:** Reseta overrides antigos do Flatpak para evitar conflitos antes de aplicar a correção.

### Compatibilidade
Funciona em qualquer compositor Wayland que suporte XWayland:
* KDE Plasma (Wayland)
* GNOME (Wayland)
* Hyprland, Sway, Wayfire, etc.

### Distribuições Suportadas
* **Arch Linux e derivados:** Manjaro, EndeavourOS, **CachyOS**
* **Debian e derivados:** Ubuntu, Pop!_OS, Linux Mint, KDE Neon
* **Fedora / RHEL / CentOS**

### Pré-requisitos
* OBS Studio instalado via Flatpak:
    ```bash
    flatpak install flathub com.obsproject.Studio
    ```
* Sistema rodando uma sessão Wayland.

### Como Usar

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/vol1t/OBS-Studio-Flatpak-XWayland-Universal-Fix.git](https://github.com/vol1t/OBS-Studio-Flatpak-XWayland-Universal-Fix.git)
    cd OBS-Studio-Flatpak-XWayland-Universal-Fix
    ```

2.  **Torne executável:**
    ```bash
    chmod +x obs-xwayland-fix.sh
    ```

3.  **Execute:**
    ```bash
    ./obs-xwayland-fix.sh
    ```

4.  **Reinicie:** Se o script instalou o XWayland pela primeira vez, reinicie seu sistema.

### Reverter Alterações
Para desfazer tudo e retornar o OBS ao seu estado padrão:
```bash
flatpak override --user --reset com.obsproject.Studio
