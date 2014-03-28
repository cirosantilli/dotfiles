Install files with:

    sudo aptitude update && sudo aptitude install -y git
    git clone https://github.com/cirosantilli/dotfiles
    cd dotfiles
    ./install.sh

This creates hard links from on the home to files under `files/`. so you can move this repository around or delete it and the links will still be valid.

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

and the files under will be replaced by hard links to the ones in your home.

#Developing

Whenever you make changes to the script on the host, copy and run it again on the guest with:

    cd && rm -rf dotfiles/ && cp -r /vagrant/ dotfiles/ && cd dotfiles && ./install.sh
