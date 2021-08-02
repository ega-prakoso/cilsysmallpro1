#!/bin/bash

prepInstalation () {
    echo "Melakukan Update repository"
    sudo apt update
    echo "Melakukan Upgrade"
    sudo apt upgrade
}

installWebsrvMysqlPhp () {

    read -p "Apakah kamu yakin akan menginstall webserver ? (Y/n) " question;
    if [ $question == "Y" -o $question == "y" ]; then
        echo "Melakukan Installasi Webserver Apache2"
        sudo apt-get install -y apache2 php php-mysql
        echo "Melakukan Installasi database Mysql"
        sudo apt-get install -y mysql-server
        echo "Installasi Selesai"
    else
        echo "Installasi dibatalkan"
        exit 1
    fi
}

configDbToAllUsers () {

sudo mysql -u root << MYSQL_INPUT
CREATE DATABASE dbsosmed;
CREATE DATABASE wordpress1;
ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '@prakoso';
CREATE USER 'devopscilsy'@'localhost' IDENTIFIED BY '1234567890';
GRANT ALL PRIVILEGES ON *.* TO 'devopscilsy'@'localhost' WITH GRANT OPTION;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'passwd';
GRANT ALL PRIVILEGES ON *.* TO 'wordpressuser'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
MYSQL_INPUT

}

gitClone () {
    cd /var/www/
    sudo rm -rf html/
    cd /home/ega_prakoso/
    echo "Melakukan downloading dari : https://github.com/sdcilsy/landing-page.git"
    wget https://github.com/sdcilsy/landing-page/archive/master.tar.gz
    tar -xf master.tar.gz
    rm -R master.tar.gz
    echo "Memindahkan folder landing-page ke dalam /var/www/html/"
    sudo mv landing-page-master/ /var/www/html
    echo "Melakukan cloning dari : https://github.com/sdcilsy/sosial-media.git"
    wget https://github.com/sdcilsy/sosial-media/archive/master.tar.gz
    tar -xf master.tar.gz
    rm -R master.tar.gz
    echo "Memindahkan folder sosial-media ke dalam /var/www/html/"
    sudo mv sosial-media-master/ /var/www/html/sosial-media
}

importDbSosialM () {
    mysql -u "root" -p"@prakoso" dbsosmed < /var/www/html/sosial-media/dump.sql
}

installWordpress () {

    echo "Download data dari wordpress.org"
    wget https://wordpress.org/latest.tar.gz
    echo "Memulai ekstraksi file"
    tar -xf latest.tar.gz
    echo "Memulai inisiasi wordpress installer"
    sudo cp wordpress/wp-config-sample.php wordpress/wp-config.php
    echo "Merubah nama database"
    sudo sed -i 's/database_name_here/wordpress1/g' wordpress/wp-config.php
    echo "Merubah nama username_db"
    sudo sed -i 's/username_here/wordpressuser/g' wordpress/wp-config.php
    echo "Merubah nama password_db"
    sudo sed -i 's/password_here/passwd/g' wordpress/wp-config.php
    echo "Memindahkan folder wordpress kedalam /var/www/html/"
    sudo mv wordpress/ /var/www/html/
    echo "Ubah kepemilikan semua folder di dalam /var/www/html/ menjadi milik www-data (apache2)"
    sudo chown www-data:www-data -R /var/www/html/
    echo "Print kepemilikan file/folder /var/www/html/"
    echo "Menghapus file latest.tar.gz"
    rm -r latest.tar.gz
}

prepInstalation
installWebsrvMysqlPhp
configDbToAllUsers
gitClone
importDbSosialM
installWordpress
