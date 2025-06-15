+++
title = "Intro to Nix"
authors = ["Shane Oatman"]
description = "Introduces why I use the nix package manager and NixOS."
updated = "2025-06-06T22:14:17+00:00"
draft = false
[extra]
keywords = ["nix", "nixos", "packages", "package manager", "linux", "operating system", "language", "programming", "functional", "declarative", "systems", "configuration", "git", "rollback"]
image = "https://bitweaving.com/articles/devx/nix/Nix_Snowflake_Logo.svg.png"
author = '''
{
      "@type": "Person",
      "url": "www.linkedin.com/in/shane-oatman",
      "name": "Shane Oatman",
      "pronouns": "he/him",
      "email": "shane@bitweaving.com"
}
'''
+++

I don't recall when I first came across Nix. I was probably looking for an alternate Linux operating system to Ubuntu or Arch... most likely because something I wanted to try was not supported or not supported well in Windows Subsystem for Linux (WSL).

So I found the NixOS operating system first. I was interested immediately since NixOS has a rollback feature to revert to prior states, selectable on boot. Since this feature was a 1st class feature of the OS, I was excited to try it out. I'm going to admit that I had never bothered to script the install of a Linux distribution before. So if I broke something, that often meant manually re-installing, re-setting up, etc. Rollback to prior operating system state was cool.

Once I installed NixOS and started using its declarative configuration files to customize my workstation, I started learning about the other 2 key aspects of Nix: The nix package manager and the nix language.

Often folks new to Nix get a bit confused since everything is called Nix. People who write articles where Nix is used are not particularly careful to specify which aspects of Nix they are referring to. For example, the Nix package manager is called Nix, and the Nix language is also called Nix.

This article provides a high level overview of:

- Nix language
- Nix Store
- Nix Package Manager / github repository
- NixOS
- Nix Wiki

> Nix and its tools are continually evolving. If you read about Nix, you're likely to come across the discussion of Flakes, which address some of the shortcomings of traditional Nix derivations. Flakes are an experimental feature and are not enabled by default. If you intend to use NixOS or the Nix Package Manager within your projects and you want to use Flakes, keep in mind that contributors to your repo may not be familiar with Flakes. This is the last mention of Flakes; when you see shell.nix, you can replace that in your mind with flake.nix if you choose to use Flakes.

## References

- [NixOS How it works](https://nixos.org/guides/how-nix-works/)
- [NixOS Organization](https://nixos.org/)
- [nix.dev - Documentation](https://nix.dev/)
- [Nix manual](https://nix.dev/manual/nix/2.28/introduction)
- [Nixpkgs manual](https://nixos.org/manual/nixpkgs/stable/)
- [Nix Package Manager & NixOS Download](https://nixos.org/dhttps://github.com/nix-community/home-manager)
- [Nix Community - Home Manager]()

## Nix History

Nix emerged at first in 2003, and later in 2006 as a thesis [The Purely Functional Software Deployment Model](https://edolstra.github.io/pubs/phd-thesis.pdf) from Eelco Dolstra. Its academic roots may help explain the choice to create its own language for creating derivations (taking specific input files and producing specific output files). One example of a derivation would be compiling a program from source files to one or more binary output files.

## Nix language

The Nix language is a functional programming language used to describe how to produce one or more output files from a set of input files. You use the Nix language to describe how you want Nix to create a build definition (derivation) or system configuration.

- Values in the nix language are immutable
- The language is expression-based, all branches of an expression must return a Value
- The language is lazy, expressions are only evaluated when needed
- Functions in nix are Pure -> Same inputs always produce the same output
- Functions provided to Nix expression developers are called builtins and include things like:
  - `builtins.add` - Adds two numbers together
  - `builtins.concatStrings` - Concatenates a list of strings into a single string
  - `builtins.fetchGit` - Fetches a git repository
  - `builtins.fetchTarball` - Fetches a tarball from a URL
  - `builtins.fetchUrl` - Fetches a URL and returns the contents as a string

> For a complete list please see [https://nix.dev/manual/nix/2.28/language/builtins](https://nix.dev/manual/nix/2.28/language/builtins)

> I'm not going to spend much time reviewing basic language features as I think that's well addressed in the nix.dev documentation. I don't think it's necessary to be particularly fluent to get value from NixOS and the Nix Package Manager.

### Additional Libraries

The nixpkgs repository contains two libraries that contain collections of additional functions, which in some cases provide enhanced versions of the original functions provided as builtins. They are:

- [nixpkgs lib](https://nixos.org/manual/nixpkgs/stable/#id-1.4): Which contains utility functions.
- [stdenv](https://nixos.org/manual/nixpkgs/stable/#part-stdenv): Which contains build functions (mkDerivation) for Unix packages.  The defaults are [make](https://en.wikipedia.org/wiki/Make_(software)) specific, but the build phases of the mkDerivation can be overridden to build whatever needs to be built using what ever tools are needed for that build.

### Language Specific Helpers

To help save time building frequently used non-Unix packages, nixpkgs also provides language-specific helper functions (language-specific mkDerivation functions). For example:

- [Go](https://nixos.org/manual/nixpkgs/stable/#sec-language-go)
- [JavaScript](https://nixos.org/manual/nixpkgs/stable/#language-javascript)
- [Rust](https://nixos.org/manual/nixpkgs/stable/#rust)
- [Python](https://nixos.org/manual/nixpkgs/stable/#python)
- [Dotnet](https://nixos.org/manual/nixpkgs/unstable/#dotnet)
- [Java / Maven](https://nixos.org/manual/nixpkgs/unstable/#maven-buildmavenpackage)

### Example package / derivation in nix

This example is for creating the [sslscan](https://github.com/rbsec/sslscan) nix package:

```nix
{
  lib,
  stdenv,
  fetchFromGitHub,
  openssl,
}:

stdenv.mkDerivation rec {
  pname = "sslscan";
  version = "2.1.6";

  src = fetchFromGitHub {
    owner = "rbsec";
    repo = "sslscan";
    tag = version;
    hash = "sha256-XFoTwBtufkT/Ja0a3MEytPHx37eg3ZZ7x15EXHjZey4=";
  };

  buildInputs = [ openssl ];

  makeFlags = [
    "PREFIX=$(out)"
    "CC=${stdenv.cc.targetPrefix}cc"
  ];

  meta = with lib; {
    description = "Tests SSL/TLS services and discover supported cipher suites";
    mainProgram = "sslscan";
    homepage = "https://github.com/rbsec/sslscan";
    changelog = "https://github.com/rbsec/sslscan/blob/${version}/Changelog";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [
      fpletz
      globin
    ];
  };
}
```

#### Let's walkthrough the example above

1. The first thing that happens in the default.nix file for sslscan is that the packages needed to build or run the sslscan application are declared in an attribute set.
2. The stdenv.mkDerivation function is called with 1 parameter, an attribute set (hashmap) of inputs needed to create the sslscan package.
3. Nix is a functional programming language and as such favors recursion over iteration. As a result, in order for attributes in the attribute set to reference one another, the attribute set must be prefixed with the "rec" keyword. In the case of sslscan, this is specifically needed for the version number which is defined once as an attribute and then is referenced in other attributes.
4. In the attribute, the package name and package version are defined.
In this case, the tag attribute is used, but the rev attribute could be used instead to point to a particular git commit hash.

> The hash argument has some gotchas. When folks forget to update the hash for a new release of their package, Nix will continue to provide the package based on the hash provided. So how do you get the hash when you want to create a new version of your package? You set it to an empty string and Nix will throw an error that includes the hash of the directory that it downloaded so you can add it and then re-run the build of your package.

6. buildInputs indicates a package build dependency.  In this case the openssl package is required to build sslscan.
7. makeFlags is an array for mkDerivation to use when invoking make.
8. meta specifies metadata about the package being built. This metadata is useful for conveying things like the supported platforms of the tool.

The package hash is very important to how downloaded packages and/or nixos system components are kept in the Nix store.


## Nix Store

The Nix store is a directory structure that contains all of the packages installed on a system. It is intended to be managed by Nix binaries and not touched directly. Each package gets its own folder in the store where a cryptographic hash of the package's build dependency graph is prepended to the package folder name.

For example, for the zed editor (1.88.3) on my machine:

```bash

# The version I'm currently using
/nix/store/rxp6ikcx1vbpicn8j3d5bqy3sa7qkgal-zed-editor-0.188.3

# Prior versions in the store
/nix/store/31k7n3mdvir4j60p4zw8sq6fvrp3nhda-zed-editor-0.161.2
/nix/store/31k7n3mdvir4j60p4zw8sq6fvrp3nhda-zed-editor-0.161.2

```

You can see that Nix can have multiple versions of the same package installed at the same time. This is what enables the rollback feature of NixOS and allows Nix package developers to get around ["DLL hell"](https://en.wikipedia.org/wiki/DLL_hell) and avoid problems with different versions of shared libraries on Unix/Linux.

You can also see that the same version of the zed editor (1.61.2) is stored twice. The hash was different, meaning that even though the version of zed was the same, some parts of the zed dependency graph were different.

These folders contain the zed binary, as well as icons and any other application resources required by the application.

### On nixos

NixOS is a full Linux distribution. Linux relies on the Linux directory structure in order to find the versions of the libraries and binaries (package output) in specific folders like: /bin, /lib, /lib64, /usr/bin, /usr/lib, /usr/lib64, /usr/share, etc.

NixOS uses symbolic links to map between the standard Linux directory structure and the Nix store.

#### Rollback and Garbage collections

We want to be able to rollback to prior good states of the operating system when necessary, and NixOS has a backup for each system configuration that you build and switch to.

```bash
# Get a list of generations (prior good states) present in the nix store
nixos-rebuild list-generations

# Rollback to a prior generation
nixos-rebuild switch --rollback

# Garbage collect old generations
nix-collect-garbage -d
```

### In a shell/environment

NixOS and the Nix package manager can build and run specific versions of packages in a shell/environment. This allows you to try an application before committing to adding it to your NixOS configuration file. (We'll look at the NixOS config later in this document). It also allows you to try a new version of an application without interfering with any work in progress. The main benefit to me is not having to install anything globally on the system. If I need a particular version of Node.js for a project or the nightly release of the Rust tools, I can just define a shell.nix telling Nix what I need to have present for this particular project. You can go further and use direnv to run nix-shell automatically when you cd into a directory where a shell.nix file is present.

Here's a look at the contents of the shell.nix file in the root of the github repository for this website:

```nix

let
  # Import the Nixpkgs repository
  # You can change the URL to point to a specific commit, tag, hash, etc...
  pkgs = import (fetchTarball("https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz")) {};

in pkgs.mkShell {
  buildInputs = [ pkgs.zola pkgs.nodejs pkgs.wrangler ];
}

```

When I move into this folder either in the terminal in zed or in an external terminal the Zola static site generator, nodejs and the Cloudflare worker cli wrangler are installed and made available within the shell.

If someone on your team doesn't want to use the Nix package manager or direnv... that's fine, just don't run nix-shell. They can install the required tools globally if they must.



## Package Manager / repository

The Nix package manager can be installed on Linux, macOS, and Windows via the Windows Subsystem for Linux. All Nix packages (derivations) are built from source on the system/environment where they are installed. Nix does have a pre-built binary cache that's enabled by default and can be overridden.

All nix packages (nix derivations / build files) are stored in the [nixpkgs repo](https://github.com/NixOS/nixpkgs) within the nixos github organization.  In the pkgs folder you can find every published nix package.

> Since the Nix files (.nix extension) are open source and in the GitHub repo, it's easy to understand how a package is being built. It's also easy to submit pull requests to add packages or to modify an existing package (update to a newer version).

### How to install packages

As mentioned in the prior nix store section, packages can be installed in a shell environment using the nix-shell command. On NixOS, packages can be declared in the configuration.nix (main configuration file for nix).

We mentioned flakes near the top of the article. One of the benefits of flakes is that we can lock the versions of individual packages. If you're not using flakes, packages are installed from publishing channels that you can switch between. Example channel names include:

- the current and other NixOS release version numbers
- unstable

> You can see a list of all available channels [here](https://channels.nixos.org/).

Not all packages available in the nix package manager are able to be built or to be run on all systems.  This is where package metadata comes into play.

### Package Metadata

Below is the [Zed code editor metadata](https://github.com/NixOS/nixpkgs/blob/41c71175dcb86c865d0677cd80c8f71aa463dd26/pkgs/by-name/ze/zed-editor/package.nix#L336C3-L347C5) (what I'm using to write this article on NixOS)
```nix
meta = {
    description = "High-performance, multiplayer code editor from the creators of Atom and Tree-sitter";
    homepage = "https://zed.dev";
    changelog = "https://github.com/zed-industries/zed/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      GaetanLepage
      niklaskorz
    ];
    mainProgram = "zeditor";
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
```

Basic things like name, version, and links to the homepage, changelog, and license are included. As well, you can find the name of the binary (executable) and the platforms on which this package is available for use.

If you attempt to install a package on a platform where it's not supported, you will receive an error message indicating that the package is not available for your system.

## NixOS

The NixOS Linux distribution installs like pretty much all other Linux distributions, so I'm not going to cover that.

Once installed, you will find:

- The nix store within the /nix folder
- The NixOS configuration files in the /etc/nixos folders
- a hardware-configuration.nix file in /etc/nixos
- a configuration.nix file in /etc/nixos

You can safely ignore the hardware-configuration.nix file for now. The contents of this file are determined by the installer.

The configuration.nix file is where you will actually configure your system.

> Many NixOS users have shared their NixOS configuration files on GitHub. Some Google searching will help find some good examples. I started with a configuration from someone else and then modified it to suit my requirements. My NixOS configuration is on GitHub [https://github.com/sbitweave/nix](https://github.com/sbitweave/nix)

Although we don't have time to walkthrough all the details of the configuration.nix (feel free to read through mine, linked above), there are a few key settings to be aware of. The first one I will call your attention to is the setting that controls whether "unfree" software can be installed. You'll want to set this to true if you plan to install any software that a package's metadata has not marked as free.

```nix
{
  nixpkgs.config.allowUnfree = true;
}
```

If you want to use any experimental features, you can enable them by name. In my case, I enable support for flakes and for the nix command. Prior to the nix command, everything was a separate binary CLI. With the nix command: nix-shell becomes: nix shell.

```nix
{
  experimental-features = [ "nix-command" "flakes" ];
}
```

Automatic garbage collection of older generations is a good thing to enable, to avoid running out of disk space.

```nix
nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

```

Installing system-wide packages (global packages). In my case, this is limited to things that I use to make StarCraft 2 playable (Wine), git, gcc, the new cross-platform YubiKey manager app, and the brightnessctl (for display brightness control).

```nix
environment.systemPackages = with pkgs; [
    #Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.

    brightnessctl
    gitFull
    gcc
    hplip
    # yubikey manager
    yubioath-flutter
    wineWowPackages.stable
    # support 64-bit only
    (wine.override { wineBuild = "wine64"; })
    # support 64-bit only
    wine64
    # wine-staging (version with experimental features)
    wineWowPackages.staging
    # winetricks (all versions)
    winetricks

    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ];


Any time you modify your configuration file, you can apply the new configuration using the nixos-rebuild command.

```nix
# within the /etc/nixos folder
sudo nixos-rebuild switch
```

The switch parameter will tell NixOS to start using the new configuration (generation) immediately. As noted above, rolling back to a prior good state generation is straightforward, and you can do that from the terminal if already in NixOS, or via the custom boot manager for NixOS.

### My Nix configuration

First off, I do use flakes, which means that I have a flake.lock file (this is like any other package manager lock file) in addition to flake.nix. The flake.nix file is pretty small though, as it loads configuration.nix and home manager.

#### Home manager

Home Manager was created by nix-community to manage user configuration files in a declarative way. It allows you to define your user environment in a single configuration file, which can be version-controlled and shared across multiple machines.

The content of my home.nix file sets what will be available when signed into NixOS using my account.

This is where I define the bulk of the applications that will be available to me. I could declare how to set up other user profiles here as well.

Here's an example of which packages I install for me:

```nix
# Packages that should be installed to the user profile.
home.packages = with pkgs; [

  libreoffice-qt
  hunspell
  hunspellDicts.en_US-large
  tidal-hifi
  firefox
  inkscape
  git-credential-manager
  chromium
  zed-editor
  nixd
  nil

  # matrix client
  element-desktop
  brave
  zoom-us

  # vscodium (free) w/ extension configuration
  (vscode-with-extensions.override {
  vscode = vscodium;
  vscodeExtensions = with vscode-extensions; [
    bbenoist.nix
    bradlc.vscode-tailwindcss
    ms-azuretools.vscode-docker
    ms-vscode-remote.remote-ssh
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "remote-ssh-edit";
      publisher = "ms-vscode-remote";
      version = "0.47.2";
      sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
    }
  ];
  })

  neofetch

  # archives
  zip
  xz
  unzip
  p7zip

  # utils
  ripgrep # recursively searches directories for a regex pattern
  jq # A lightweight and flexible command-line JSON processor
  yq-go # yaml processor https://github.com/mikefarah/yq
  eza # A modern replacement for ‘ls’
  fzf # A command-line fuzzy finder

  # networking tools
  mtr # A network diagnostic tool
  iperf3
  dnsutils  # `dig` + `nslookup`
  ldns # replacement of `dig`, it provide the command `drill`
  aria2 # A lightweight multi-protocol & multi-source command-line download utility
  socat # replacement of openbsd-netcat
  nmap # A utility for network discovery and security auditing
  ipcalc  # it is a calculator for the IPv4/v6 addresses

  # misc
  cowsay
  file
  which
  tree
  gnused
  gnutar
  gawk
  zstd
  gnupg

  # nix related
  #
  # it provides the command `nom` works just like `nix`
  # with more details log output
  nix-output-monitor

  # productivity
  glow # markdown previewer in terminal

  btop  # replacement of htop/nmon
  iotop # io monitoring
  iftop # network monitoring

  # system call monitoring
  strace # system call monitoring
  ltrace # library call monitoring
  lsof # list open files

  # system tools
  sysstat
  lm_sensors # for `sensors` command
  ethtool # ethernet / network configuration
  pciutils # lspci
  usbutils # lsusb

  # video editing
  #davinci-resolve

  # gaming
  lutris

  # discord
  discord

  # image utils
  imagemagick


];
```

In addition to installing you can configuration applications.  Above you can see that for codium i've declared 4 or 5 vscode extensions that I always want to have installed.  Another example is for something like git:

```nix
programs.git = {
  enable = true;
  userName = "Shane Oatman";
  userEmail = "shane@bitweaving.com";
  extraConfig.credential.helper = "manager";
  extraConfig.credential."https://github.com".username = "sbitweave";
  extraConfig.credential.credentialStore = "";
};
```

## Wrap up

If you made it this far, congratulations and thank you! For me, the declarative and reproducible nature of NixOS configuration and shell.nix for work on projects was worth the time to familiarize myself with the Nix ecosystem.

I hope you found this helpful~

shane
