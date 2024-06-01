# Add Docker's official GPG key:
set -ex

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world

# Install PHP 8.2 and extensions that are not bundled with PHP
apt install php8.2 php8.2-mysqli php8.2-curl php8.2-dom php8.2-exif php8.2-igbinary php8.2-imagick php8.2-intl php8.2-mbstring php8.2-xml php8.2-zip libcurl4-openssl-dev libxml2-dev libmagickwand-dev libicu-dev libzip-dev libmemcached-dev imagemagick ghostscript curl php-cli php-mbstring git unzip php-mysqli php-xml php-curl  php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip phpunit -y

#install composer globaly
#install nvm globaly for all users
