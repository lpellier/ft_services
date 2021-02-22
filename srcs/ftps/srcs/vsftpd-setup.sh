echo "pasv_address=192.168.49.24" >> append.txt 
cat append.txt >> /etc/vsftpd/vsftpd.conf
echo "www" >> /etc/vsftpd/vsftpd.userlist

vsftpd /etc/vsftpd/vsftpd.conf
