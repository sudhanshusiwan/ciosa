#!/usr/bin/env bash

echo ". ~/.bash_prompt_git_branch" >> ~/.bashrc

# Ruby
sudo apt-get install -y software-properties-common
sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update -y

sudo dpkg-reconfigure tzdata
sudo apt-get install -y ntp nodejs build-essential git-core imagemagick zip pigz ruby2.2 ruby2.2-dev xfonts-base xfonts-75dpi libpq-dev postgresql-client postgresql postgresql-contrib

sudo gem install bundler

mkdir -p ~/downloads
cd ~/downloads
if [ ! -f ~/downloads/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb ]; then
    wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
fi

sudo dpkg -i wkhtmltox-0.12.2.1_linux-trusty-amd64.deb

sudo apt-get -f install
sudo apt-get autoremove -y

cd ~
ln -s /vagrant ~/ciosa
