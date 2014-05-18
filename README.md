Hardlink based dotfiles.

Create hard links to your home from files under `home/`:

    git clone https://github.com/cirosantilli/dotfiles && cd dotfiles && ./install.sh

Add new file:

    cd home
    ln ~/.new-file .
    git add new-file

There is no currently automation for files in subdirectories of home, but we want to implement it.

# Reverse

If you:

- want to use this for you own dotfiles
- deleted this repo and now want to push your files

all you have to do is:

    git clone https://github.com/cirosantilli/dotfiles
    rm -rf .git
    git init
    ./install.sh -r
    git add .
    git commit -m 'Init.'

and the files under `home/` will be replaced by hard links to the ones in your home.

# root

The `root/` directory contains files whose path is relative to the root `/`.

There is no currently automation script for them, but we want to implement it.

# Developing

Whenever you make changes to the script on the host, copy and run it again on the guest with:

    cd && rm -rf dotfiles/ && cp -r /vagrant/ dotfiles/ && cd dotfiles && ./install.sh

Copying has to be done because hard links cannot be made from host to guest.
