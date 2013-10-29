# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

TEXLIVE="/usr/local/texlive/2012/bin/x86_64-linux"
if [ -d "$TEXLIVE" ]; then
    PATH="$TEXLIVE:$PATH"
fi

ANDROID_HOME="$HOME/bin/adt-bundle-linux-x86_64/sdk:$ANDROID_HOME"
NDK_HOME="$HOME/bin/android-ndk-r9"
PATH="$PATH:$HOME/bin/adt/sdk/tools:$NDK_HOME/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64/bin/"
