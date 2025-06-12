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

I don't recall when I first came across Nix.  I was probably looking for an alternate linux operating system to Ubuntu or Arch... most likely because something I wanted to try was not supported or not supported well in Windows Subsystem for Linux (WSL).

So I found the Nix Operating System first.  I was interested immediately since NixOS has a rollback feature to revert to a prior states, selectable on boot.  Since this feature was a 1st class feature of the OS.  I was excited to try it out.  I'm going to admit that I had never bothered to script the install of a linux distribution before.  So If I broke something, that often meant manually re-installing, re-setting up, etc.  Rollback to prior operating system state was cool.

Once I installed NixOS and started using its declarative configuration files to customize my workstation I started learning about the other 2 keys aspects of Nix: The nix package manager and the nix language.

Often folks new to nix get a bit confused since everything is called Nix.  Often people who write articles where Nix is used... are not particularly careful to specify what aspects of Nix they are referring to.  For example, the Nix package manager is called nix, but the Nix language is called nix.

This article provides a high level overview of:

- Nix language
- Nix Store
- Nix Package Manager / github repository
- NixOS
- Nix Wiki
- shell.nix / flake.nix

## References

- [NixOS How it works](https://nixos.org/guides/how-nix-works/)
- [NixOS Organization](https://nixos.org/)
- [nix.dev - Documentation](https://nix.dev/)
- [Nix manual](https://nix.dev/manual/nix/2.28/introduction)
- [Nixpkgs manual](https://nixos.org/manual/nixpkgs/stable/)

## Nix History

Nix emerged at first in 2003, and later in 2006 as a thesis [The Purely Functional Software Deployment Model](https://edolstra.github.io/pubs/phd-thesis.pdf) from Eelco Dolstra.  It's academic roots may help explain the choice to create it's own language for creating derivations (taking specific input files and producing specific output files). One example of a derivation would be compiling a program from source files to 1 or more binary output files.

## Nix language

The Nix language is a functional programming language used to describe how to produce 1 or more output files from a set of input files.  You use the nix language to describe how you want nix to create a build definition (derivation) or system configuration.

- Values in the nix language are immutable
- The language is expression-based, all branches of an expression must return a Value
- The language is lazy, expressions are only evaluated when needed
- Functions in nix are Pure -> Same inputs always produce the same output
- Functions provided to nix expression developers are called builtins and included things like:
  - `builtins.add` - Adds two numbers together
  - `builtins.concatStrings` - Concatenates a list of strings into a single string
  - `builtins.fetchGit` - Fetches a git repository
  - `builtins.fetchTarball` - Fetches a tarball from a URL
  - `builtins.fetchUrl` - Fetches a URL and returns the contents as a string

> For a complete list please see [https://nix.dev/manual/nix/2.28/language/builtins](https://nix.dev/manual/nix/2.28/language/builtins)

### Additional Libraries

The nixpkgs repository contains 2 libraries that contain collections of additional functions, that in some cases provide enhanced versions of the original functions provided as builtins.  They are:

- [nixpkgs lib](https://nixos.org/manual/nixpkgs/stable/#id-1.4): Which contains utility functions.
- [stdenv](https://nixos.org/manual/nixpkgs/stable/#part-stdenv): Which contains build functions (mkDerivation) for Unix packages.  The defaults are [make](https://en.wikipedia.org/wiki/Make_(software)) specific, but the build phases of the mkDerivation can be overridden to build whatever needs to be built using what ever tools are needed for that build.

### Language Specific Helpers

To help save time building frequently used non-unix packages, nixpkgs also provides language specific helper functions (language specific mkDerivation functions)  For example:

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

1. The first that happens is the default.nix file for sslscan is that the packages needed to build or to run the sslscan application are declared in an attribute set.
2. The stdenv.mkDerivation function is called with 1 parameter an attribute set (hashmap) of inputs needed to create the sslscan package.
3. Nix is a functional programming language and as such favors recursion over iteration.  As a result, in order for attributes in the attribute set to reference one another the attribute set must be prefixed with the "rec" keyword.  In the case of sslscan this is specifically needed for the version number which is defined once as an attribute and then is referenced in other attributes.
4. In the attribute the package name and package version are defined.
5. The src attribute is set using the [fetchFromGitHub](https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/fetchgithub/default.nix) function that expects at least 4 arguments provided as an attribute set.  In this case the tag attribute is used by the rev attribute could be used instead to point to a particular git commit hash.  The hash attribute doesn't have anything to do with github.  It's the hash of the directory downloaded from github.

> The hash argument has some gotchas.  When folks forget to update the hash for a new release of their package.  Nix will continue to provide the package based on the hash provided.  So how do you get the hash when you want to create a new version of your package?  You set it to empty string and Nix will throw an error that includes the hash of the directory that it downloaded so you can add it and then re-run the build of your package.

6. buildInputs indicates a package build dependency.  In this case the openssl package is required to build sslscan.
7. makeFlags is an array for mkDerivation to use when invoking make.
8. meta specifies metadata about the package being built.  This metadata is useful for conveying thinks like the supported platforms of tool.




## Nix Store

## Package Manager / repository

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
