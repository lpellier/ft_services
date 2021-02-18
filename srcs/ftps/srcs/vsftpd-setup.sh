cat append.txt >> /etc/vsftpd/vsftpd.conf
echo "www" >> /etc/vsftpd/vsftpd.userlist

vsftpd /etc/vsftpd/vsftpd.conf
