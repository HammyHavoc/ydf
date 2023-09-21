# ydf

A disruptive dotfiles manager and more.

## About

 This tool brings you a simple way
to declare the software you use along with its configuration, following the
principles of high cohesion and low coupling, so no more dotfiles of tools
you are not using, no more installing a bunch of configs and executing an
elephant script, if you install the configuration, you install the software
because those belong to the same `package`.

You can create multiple selections of packages for your different needs, for
example, you can create a `packages selection` for your laptop, desktop, servers,
different operating systems, etc.

Declaring your working environment give you transparency and control over it,
allow you to easily reproduce it on a new machine or fresh OS, besides you can
share it with others, so they can reproduce your working environment, and very
important, you can version it with git.

> What you write you can read, share, save and reproduce, it is simply there, it exists.

## Tested OS

It's tested on the following OS:

### Manjaro

Runtime Dependencies:

```sh
${MANJARO_PACKAGES_RUN}
```

⚠️ It should work on any linux distribution, but it has not been tested.

## Install

Clone the repository and switch to ydf directory

```sh
git clone https://github.com/yunielrc/ydf.git && cd ydf
```

### Install on Manjaro

Install runtime dependencies and ydf on home directory

```sh
make install-run-manjaro && make install-tohome
```

For any other linux distribution check out the script `tools/install-run-manjaro`
and install the runtime dependencies manually then execute the following command:

```sh
make install-tohome
```

## Configure

Edit the config file:

- If your distro is manjaro set the variable `YDF_PACKAGE_SERVICE_DEFAULT_OS` to
  manjaro. If you have any other distro don't set this variable.

```sh
vim ~/.ydf.env
```

## YDF Package

### What is a package?

A `package` is a directory containing files and directories in which some have
special meaning for the `interpreter`. ydf is an `interpreter`.

### Which are the directories and files with special meaning?

These is an example of a `package` with 18 directories and files with special
meaning, those are `instructions` that work on any linux distribution:

```sh
package1
├── preinstall           # Script executed before install
├── install              # Script executed on install
├── @flatpak             # Install <package1> with flatpak
├── @snap                # Install <package1> with snap
├── docker-compose.yml   # Run docker compose up -d
├── package1.plugin.zsh  # Install yzsh plugin
├── homeln/              # Create symlinks on home for the first level files and
|                        # directories inside this directory
├── homelnr/             # Create symlinks on home for all files inside this
|                        # directory
├── homecp/              # Copy all files to home directory
├── rootcp/              # Copy all files to root directory
├── homecat/             # Concatenate all files with those existing in home
├── rootcat/             # Concatenate all files with those existing in root
├── homecps/             # Evaluate variables in files and copy them to home
├── rootcps/             # Evaluate variables in files and copy them to root
├── homecats/            # Evaluate variables in files and concatenates them with
|                        # those existing in home
├── rootcats/            # Evaluate variables in files and concatenates them with
|                        # those existing in root
├── dconf.ini            # Load dconf settings
└── postinstall          # Script executed after all instructions
```

The `instructions` can be grouped in 4 categories:

- Scripts instructions: `preinstall`, `install`, `postinstall`.
  These instructions are shell scripts that are executed by bash.

- Package manager instructions: `@flatpak`, `@snap`.
  These instrucions are plain text files, the file can have inside one line with
  the package name or a list of packages names that are going to be installed.
  The file can be empty, in this case the package name (`package1`) is going to
  be used.

- Directory instructions: `homeln`, `homelnr`, `homecp`, `rootcp`, `homecat`,
  `rootcat`, `homecps`, `rootcps`, `homecats`, `rootcats`.
  These instructions are directories that contains files that are going to be
  copied, concatenated or symlinked to the home or root directory. For those
  that end with `s` all the variables inside each file are substituted with the
  values defined in the `envsubst.env` file that is inside the `package directory`.

- Tool files instructions: `docker-compose.yml`, `dconf.ini`, `package1.plugin.zsh`.
  These instructions are files that are going to be used by a tool. For example
  `docker-compose.yml` is going to be used by docker compose.
  The `package1.plugin.zsh` is a plugin that is going to be installed inside the
  YZSH data directory and used by YZSH.

There are 2 more `instructions` that only work for manjaro linux:

```sh
package2
├── @pacman
└── @yay
```

👉 If you want support for other package managers you can create a pull request.

You can check out some examples of `packages` at: `tests/fixtures/packages`

## What is a YDF Packages Directory

A `packages directory` is a directory that contains a list of `packages` and the
`envsubst.env` file, besides it can have one or more `packages selection` files.

For example of a `packages directory`:

```sh
~/.ydf-packages          # packages directory
├── bat/                 # package
├── bmon/                # package
├── htop/                # package
├── aws-cli-v2/          # package
├── mpv/                 # package
├── ....                 # package
├── envsubst.env         # substitution variables
├── pc-gaming.pkgs       # packages selection
├── latop-work.pkgs      # packages selection
└── ....                 # packages selection
```

You can check out: `tests/fixtures/packages`

The `envsubst.env` file has the variables that are evaluated in the files inside
of `Directory instructions` that end with `s`.

The `packages selection` are plain text files that contains a list of `packages`
one per line.

The `packages directory` is where the `interpreter` is going to look for
`packages`, `envsubst.env` and `packages selection`.

## Usage

Reload your shell to load the new PATH.

```sh
exec $SHELL
```

Show the help

```sh
ydf --help
```

```sh
# command output:
${YDF_HELP}
```

## Add packages to your packages directory

Before adding a `package` to your `packages directory` you must create a git
repository.

```sh
cd ~/.ydf-packages
git init
git remote add origin git@github.com:<your_user>/.ydf-packages.git
```

Open the `packages directory` in your favorite code editor .

```sh
code ~/.ydf-packages
```

Create a `package` and add `instructions` to it.

Add variables to the `~/.ydf-packages/envsubst.env` if apply.

Test that the `package` works.

```sh
ydf package install <package>
```

Verify that the software was installed and configured correctly.

Create a `packages selection` if apply and add the package.

```sh
echo "<package>" >> ~/.ydf-packages/<packages selection>
```

Save the changes.

```sh
cd ~/.ydf-packages
git add .
git commit -m "Add <package>"
git push -u origin master
```

Then when you reinstall your OS or on a new machine you can install all your
packages with:

```sh
ydf packages install <packages-selection>
```

⚠️ Attention: It's highly recommended to test the installation of the packages
on a virtual machine before install them.

It's recommended to check out `vedv` at <https://github.com/yunielrc/vedv>
for working with virtual machines.

## Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Give a ⭐️ if this project helped you!
