Create hard links to your home from files under `files/`:

    git clone https://github.com/cirosantilli/dotfiles
    cd dotfiles
    ./install.sh

The best way to do the above on a machine with X Display Manager is:

    wget -O- https://raw.githubusercontent.com/cirosantilli/linux/master/ubuntu/install-min.sh | bash

and for a SSH-only machine:

    wget -O- https://raw.githubusercontent.com/cirosantilli/linux/master/ubuntu/install-min-ssh.sh | bash

both of which also install other basic utilities such as Vim packages.

#Reverse

If you:

- want to use this for you own dotfiles
- deleted this repo and now want to push your files

all you have to do is:

    git clone https://github.com/cirosantilli/dotfiles
    rm -rf .git
    git init
    ./install.sh -r
    git add files/
    git commit -m 'Init.'

and the files under `files/` will be replaced by hard links to the ones in your home.

#Developing

Whenever you make changes to the script on the host, copy and run it again on the guest with:

    cd && rm -rf dotfiles/ && cp -r /vagrant/ dotfiles/ && cd dotfiles && ./install.sh

Copying has to be done because hard links cannot be made from host to guest.
