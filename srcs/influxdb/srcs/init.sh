influxd &
sleep 10 
influx -execute "create database influx_db"
influx -execute "create user influx_user with password 'influx_password'"
telegraf & tail -f /dev/null
