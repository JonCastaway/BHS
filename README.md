<a id="readme-top"></a>

<div align="center">

# ⛏️ The Blockheads Game Server

**A self-hosted multiplayer server for The Blockheads**

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

</div>

<div align="center">

| Platform | Badge |
|---|---|
| 🍎 macOS | [![macOS](https://img.shields.io/badge/macOS-999999.svg?logo=apple&logoColor=white)](https://www.apple.com/macos/) |
| 🐧 Debian | [![Debian](https://img.shields.io/badge/Debian-A81D33.svg?logo=debian&logoColor=white)](https://www.debian.org/) |
| 🟠 Ubuntu | [![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420.svg?logo=ubuntu&logoColor=white)](https://ubuntu.com/) |
| 🔵 Arch Linux | [![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1.svg?logo=arch-linux&logoColor=white)](https://archlinux.org/) |
| 🟦 Pop!_OS | [![Pop!_OS](https://img.shields.io/badge/Pop!__OS-48B9C7.svg?logo=pop_os&logoColor=white)](https://pop.system76.com/) |
| 🟩 Trisquel | [![Trisquel](https://img.shields.io/badge/Trisquel-23af34.svg?logo=trisquel&logoColor=white)](https://www.trisquel.info/) |
| 🌿 Linux Mint | [![Linux Mint](https://img.shields.io/badge/Linux%20Mint-87CF3E.svg?logo=linux-mint&logoColor=white)](https://www.linuxmint.com/) |
| 🔷 Zorin OS | [![Zorin OS](https://img.shields.io/badge/Zorin%20OS-0CC1F3.svg?logo=zorin&logoColor=white)](https://zorin.com/) |
| 🪶 elementary OS | [![elementary OS](https://img.shields.io/badge/elementary%20OS-64BAFF.svg?logo=elementary&logoColor=white)](https://elementary.io/) |
| 🐉 Kali Linux | [![Kali Linux](https://img.shields.io/badge/Kali%20Linux-557C94.svg?logo=kali-linux&logoColor=white)](https://www.kali.org/) |
| 🛡️ Tails | [![Tails](https://img.shields.io/badge/Tails-563F8A.svg?logo=linux&logoColor=white)](https://tails.boum.org/) |
| 🧰 MX Linux | [![MX Linux](https://img.shields.io/badge/MX%20Linux-1E7B6E.svg?logo=linux&logoColor=white)](https://mxlinux.org/) |
| ⚙️ Devuan | [![Devuan](https://img.shields.io/badge/Devuan-648C8A.svg?logo=linux&logoColor=white)](https://www.devuan.org/) |
| 🧪 BunsenLabs | [![BunsenLabs](https://img.shields.io/badge/BunsenLabs-254c59.svg?logo=linux&logoColor=white)](https://bunsenlabs.org/) |

</div>

This repository contains the server files needed to run a **Blockheads multiplayer server**.

> [!WARNING]  
> Running `curl | bash` scripts from the internet can be risky. Always review the script before executing it.

- 📚 [Explore the Wiki](https://github.com/JonCastaway/BHS/wiki)
- 🌍 [Other Blockheads Servers](https://github.com/JonCastaway/BHS/wiki/Servers)
- 🐞 [Report a Bug](https://github.com/JonCastaway/BHS/issues/new?labels=bug&template=bug-report---.md)
- ✨ [Request a Feature](https://github.com/JonCastaway/BHS/issues/new?labels=enhancement&template=feature-request---.md)

<details>
<summary>📖 Table of Contents</summary>

1. [✅ Requirements](#requirements)
2. [⚡ Quick Start](#quick-start)
3. [🐧 Linux Install](#linux-install)
4. [🍎 macOS Install](#macos-install)
5. [📦 Original Binaries / Manual Install](#original-binaries--manual-install)
6. [🤖 The Blockheads Android APK](#the-blockheads--android-apk)
7. [🛠️ Server Management](#server-management)
8. [🐳 Docker](#docker)
9. [🗺️ Roadmap](#roadmap)
10. [🤝 Contributing](#contributing)
11. [📜 License](#license)
12. [📬 Contact](#contact)
13. [🙏 Acknowledgments](#acknowledgments)

</details>

---

# 🎮 The Blockheads Game Server for Linux and macOS

## 🚀 Getting Started

```text
┌──────────────────────────────────────────┐
│  ⛏️  Build. Explore. Host your world.   │
└──────────────────────────────────────────┘
```

<a id="requirements"></a>

## ✅ Requirements

Before installing, make sure your system has:

- A Linux distribution or macOS installation
- A terminal with `bash` available
- `curl` installed for downloading the server files
- `nano`, or another text editor, for editing configuration files
- An internet connection for the initial download
- A free TCP port for the Blockheads server
- Enough disk space for the server binary, world data, and backups

On Debian, Ubuntu, Linux Mint, Pop!_OS, and similar systems, install the basic tools with:

```bash
sudo apt update
sudo apt install -y curl nano
```

On Arch Linux and derivatives:

```bash
sudo pacman -S --needed curl nano
```

On Fedora:

```bash
sudo dnf install -y curl nano
```

> [!NOTE]  
> The exact package manager and package names can vary between distributions.

<a id="quick-start"></a>

## ⚡ Quick Start

For experienced users, the shortest Linux setup is:

```bash
curl -sL [https://raw.githubusercontent.com/JonCastaway/BHS/main/start.sh](https://raw.githubusercontent.com/JonCastaway/BHS/main/start.sh) -o start.sh
less start.sh
bash start.sh
```

Create a server:

```bash
./blockheads_server171 -n MyFirstServer
```

Find your world ID:

```bash
./blockheads_server171 -l
```

Edit `run.sh`, replacing `WORLD_ID` and `PORT`:

```bash
nano run.sh
```

Start the server in the background:

```bash
nohup ./start.sh &>/dev/null &
```

For a fuller explanation, see [🐧 Linux Install](#linux-install).

<a id="linux-install"></a>

## 🐧 1. Installation | Linux

Follow the instructions below to install and set up the Blockheads server on your system.

### Download and inspect the server script

Rather than piping a remote script directly into `bash`, download it first and review it:

```bash
curl -sL [https://raw.githubusercontent.com/JonCastaway/BHS/main/start.sh](https://raw.githubusercontent.com/JonCastaway/BHS/main/start.sh) -o start.sh
```

Review the script before running it:

```bash
less start.sh
```

If you are happy with it, run:

```bash
bash start.sh
```

> [!IMPORTANT]  
> Only run scripts you understand. If the script changes unexpectedly, stop and review the diff before running it again.

### Create your server

```bash
./blockheads_server171 -n MyFirstServer
```

### View available options

```bash
./blockheads_server171 -h
```

### Configure your server

You will need to replace `WORLD_ID` and `PORT` inside the `run.sh` script.

```bash
nano run.sh
```

Replace the placeholders with your `WORLD_ID` and `PORT`.

To find your `WORLD_ID`, run:

```bash
./blockheads_server171 -l
```

Save and exit `nano` by pressing `CTRL+X`, then `Y`, then `ENTER`.

### Start the server in the background

```bash
nohup ./start.sh &>/dev/null &
```

<a id="macos-install"></a>

## 🍎 2. Installation | macOS

Download the Blockheads Server App from the App Store:

- [📥 Download from the App Store](https://apps.apple.com/us/app/blockheadsserver/id662633568)

<a id="original-binaries--manual-install"></a>

## 📦 3. Original Server Binaries | Manual Install

You can download the original server binaries from the links below:

- [📥 The Blockheads Server Binary — archive.org](https://archive.org/download/BHSv171/blockheads_server171.tar.gz)
- [📥 The Blockheads Server Binary — majicdave.com](https://majicdave.com/share/blockheads_server171.tar.gz)

After downloading, extract the archive:

```bash
tar -xzf blockheads_server171.tar.gz
```

Then follow the Linux configuration instructions above.

<a id="the-blockheads--android-apk"></a>

## 🤖 4. The Blockheads | Android APK

If version 1.76 does not launch, try an earlier version such as 1.75 or 1.74.

- [📥 The Original Blockheads Android APK v1.76 — Noodlecake](https://noodlecake.com/wp-content/uploads/2021/02/theblockheads1.7.6.apk)
- [📥 The Original Blockheads Android APK v1.76 — archive.org](https://archive.org/download/theblockheads1.7.6/theblockheads1.7.6.apk)
- [📥 The Original Blockheads Android APK v1.75 — archive.org](https://archive.org/download/theblockheads1.7.6/The%20Blockheads_1.7.5_APKPure.apk)
- [📥 The Original Blockheads Android APK v1.74 — archive.org](https://archive.org/download/theblockheads1.7.6/The%20Blockheads_1.7.4_APKPure.apk)

<a id="server-management"></a>

## 🛠️ 5. Server Management

### Check whether the server is running

```bash
pgrep -af blockheads_server171
```

### View running server processes

```bash
ps aux | grep -i blockheads
```

### Stop the server

Find the process ID:

```bash
pgrep -af blockheads_server171
```

Then stop it, replacing `PID` with the process ID shown:

```bash
kill PID
```

If it does not stop cleanly:

```bash
kill -TERM PID
```

> [!CAUTION]  
> Avoid using `kill -9` unless the server will not terminate normally, as it prevents a clean shutdown.

### View server output

If you started the server with output redirected to a log file, view it with:

```bash
tail -f server.log
```

If you used the command exactly as shown earlier, output was discarded:

```bash
nohup ./start.sh &>/dev/null &
```

To keep logs instead, start it like this:

```bash
nohup ./start.sh > server.log 2>&1 &
```

Then view live logs with:

```bash
tail -f server.log
```

### Back up your world

Before updating or making major configuration changes, stop the server and copy the server directory:

```bash
cp -a /path/to/blockheads-server /path/to/backups/blockheads-server-$(date +%Y-%m-%d)
```

> [!TIP]  
> Store backups outside the live server directory, ideally on another disk or remote storage location.

<a id="docker"></a>

## 🐳 6. Docker

Docker support is currently **in testing**.

Once available, this section will include:

- A `Dockerfile`
- A `docker-compose.yml` example
- Volume mappings for world data and configuration
- Port mappings
- Container update and backup guidance

<a id="roadmap"></a>

## 🗺️ 7. Roadmap

```text
        🚧 ROADMAP 🚧
 ┌───────────────────────────────┐
 │ ✅ Current Active Servers      │
 │ 🌍 World Configuration Editor  │
 │ 🖥️ Web-based User Interface    │
 │ 🐳 Docker File                 │
 └───────────────────────────────┘
```

Explore our progress towards significant [milestones](https://github.com/JonCastaway/BHS/milestones), and read the [wiki roadmap](https://github.com/JonCastaway/BHS/wiki/Roadmap).

- [ ] [Current Active Servers](https://github.com/JonCastaway/BHS/wiki/Active-Servers) — in test
- [ ] World Configuration Editor
- [ ] Web-based User Interface
- [ ] Docker file — in test

Review the [open issues](https://github.com/JonCastaway/BHS/issues) for suggested features and known issues.

<a id="contributing"></a>

## 🤝 8. Contributing

```text
   ╭──────────────────────────────╮
   │  🎉 Contributions welcome!  │
   │   Fork → Change → PR 💪     │
   ╰──────────────────────────────╯
```

Contributions are welcome. Feel free to fork this repository and submit pull requests.

### 👥 Contributors

<a href="https://github.com/JonCastaway/BHS/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=JonCastaway/BHS&t=1" alt="Contributors" />
</a>

<a id="license"></a>

## 📜 9. License

This project is licensed under the **GPL-3.0 License**.

See the [License](LICENCE) file for details.

<a id="contact"></a>

## 📬 10. Contact

```text
  📮 Questions?  🐛 Problems?  💡 Ideas?
       └──── Open a GitHub issue ────┘
```

For questions or support, please open an issue on GitHub.

<a id="acknowledgments"></a>

## 🙏 11. Acknowledgments

Projects we are inspired by and have obtained valuable information from:

- 🎮 [Majic Jungle | Dave Frampton](https://majicjungle.com)
- 📚 [The Internet Archive](https://archive.org)
- 💬 [Discord | Sapiens](https://discord.gg/ZHwMWruM)
- 👽 [Reddit | r/blockheads](https://www.reddit.com/r/blockheads/)
- 📖 [Wiki GG | Blockheads](https://theblockheads.wiki.gg/wiki/The_Blockheads_Wiki)
- 📖 [Fandom | The Blockheads](https://theblockheads.fandom.com/wiki)

<!-- Badges -->

[contributors-shield]: https://img.shields.io/github/contributors/JonCastaway/BHS.svg?style=for-the-badge
[contributors-url]: https://github.com/JonCastaway/BHS/graphs/contributors

[forks-shield]: https://img.shields.io/github/forks/JonCastaway/BHS.svg?style=for-the-badge
[forks-url]: https://github.com/JonCastaway/BHS/network/members

[stars-shield]: https://img.shields.io/github/stars/JonCastaway/BHS.svg?style=for-the-badge
[stars-url]: https://github.com/JonCastaway/BHS/stargazers

[issues-shield]: https://img.shields.io/github/issues/JonCastaway/BHS.svg?style=for-the-badge
[issues-url]: https://github.com/JonCastaway/BHS/issues