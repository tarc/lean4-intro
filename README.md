# Lean 4 &mdash; an introduction

Developing in Lean requires&mdash;at a minimum&mdash;these three command line tools:

- [[Toolset/#elan|elan]] &mdash; The Lean toolchain installer
- [[Toolset/#lean|lean]] &mdash; Lean's command line program
- [[Toolset/#lake|lake]] &mdash; Lake (Lean Make)

See [[Toolset]] for an overview of each one.

In the next sections we will see how to setup a local environment with all the required tools to start developing in Lean.

> [!NOTE]  
> Throughout this repository Lean 4 is the only version used&mdash;any reference to Lean without saying which version is meant to be referring to Lean 4.

## Setting up

Two options are covered here:

- Use [VS Code][vscode] with the [Lean 4 extension][extension] to setup everything automatically.
- Use `nix-direnv` to automatically build a `devShell` with all the required tools and configurations.


## Lean setup

If you're on Nix, head to the [Development setup](#development-setup) session for a quick way to get a development shell fully configured with everything needed.


Start from [the quickstart session][quickstart] of the [Lean 4 documentation site][docs].

In short:

1. Install [VS Code][vscode]
2. Install [Lean 4 extension][extension]


## This repository

### Requirements

- [Nix][nix]
- [`direnv`]
- [VS Code][vscode]
- VS Code's [Lean 4 extension][extension]

### Development setup

1. Clone this repository and enter on it:

    ```shell
    git clone --recursive https://github.com/tarc/lean4-intro
    cd lean4-intro
    ```

1. For `direnv` to work it must be allowed to handle the shell environmen&mdash;when get into the directory

    ```no-lang
    direnv: error $HOME/projects/lean4-intro/.envrc is blocked. Run `direnv allow` to approve its content
    ```

    Go ahead and allow `direnv` for the `lean4-intro` path:

    ```shell
    direnv allow
    ```

::: WARNING ::::

    The previous command may This should get the `elan` package manager in your path:

    ```shell
    elan --version
    > elan 3.1.1
    ```

1. Build the [`mathematics_in_lean`] project (this is an external repository that it's added as a submodule of this one):

    ```shell
    cd mathematics_in_lean
    lake exe cache get
    lake exe mk_all && lake build
    ```
1. Start VS Code from this path:
    ```shell
    code .
    ```

[docs]: https://lean-lang.org/lean4/doc/whatIsLean.html
[quickstart]: https://lean-lang.org/lean4/doc/quickstart.html
[vscode]: https://lean-lang.org/lean4/doc/setup.html
[extension]: https://marketplace.visualstudio.com/items?itemName=leanprover.lean4
[nix]: https://nixos.org/
[`direnv`]: https://direnv.net/
[`mathematics_in_lean`]: https://github.com/leanprover-community/mathematics_in_lean