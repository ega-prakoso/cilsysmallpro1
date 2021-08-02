# cilsysmallpro1
Small Project1 by Cilsy

=============================================================================
keterangan :

1. file autoInstall.sh
isi file ini merupakan bash script untuk melakukan installasi webserver, mysql-server
serta untuk melakukan deploy landing-page dan sosial-media yang diambil dari
landing-page : https://github.com/sdcilsy/landing-page.git
sosial media : https://github.com/sdcilsy/sosial-media.git

serta melakukan inisiasi config pada wordpress untuk penginstallan wordpress.

2. folder html
merupakan hasil dari installasi yang saya copy-kan ke repository

=============================================================================
cara penggunaan :

1. setelah server di buat download file autoInstall.sh melalui : wget https://raw.githubusercontent.com/ega-prakoso/cilsysmallpro1/main/autoInstall.sh
2. buat file menjadi executeable dengan perintah : chmod +x autoInstall.sh
3. jalankan file autoInstall.sh dengan perintah : ./autoInstall.sh
4. setelah selesai akses ip server dan tambahkan `/wordpress` untuk melanjutkan
   sampai tahapan installasi wordpress dan lakukan sesuai instruksi sampai selesai

Keterangan lebih lanjut:
1. landing-page -> plain-ip (ex: 10.100.0.1)
2. sosial-media -> plain-ip/landing-page (ex: 10.100.0.1/landing-page)
3. wordpress    -> plain-ip/wordpress (ex: 10.100.0.1/wordpress)

=============================================================================
