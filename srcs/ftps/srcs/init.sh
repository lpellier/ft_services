cat append.txt >> /etc/vsftpd/vsftpd.conf
echo "www" >> /etc/vsftpd/vsftpd.userlist

vstfpd /etc/vsftpd/vsftpd.conf
