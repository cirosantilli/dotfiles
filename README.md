# Dotfiles

Hardlink based dotfiles.

Create hard links to your home from files under `home/`:

    git clone https://github.com/cirosantilli/dotfiles && cd dotfiles && ./install.sh

Add new file:

    cd home
    ln ~/.new-file .
    git add new-file

## root

The `root/` directory contains files whose path is relative to the root `/`.

There is no currently automation script for them, but we want to implement it.

One difficulty is that the current system is hardlink based, and if you use a separate home partition hardlinks cannot be created.

## Developing

Whenever you make changes to the script on the host, copy and run it again on the guest with:

    cd && rm -rf dotfiles/ && cp -r /vagrant/ dotfiles/ && cd dotfiles && ./install.sh

Copying has to be done because hard links cannot be made from host to guest.
