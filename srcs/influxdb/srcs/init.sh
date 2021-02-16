influxd &
sleep 10 
influx -execute "create database influx_db"
influx -execute "create user influx_user with password 'influx_password'"
killall influxd influxdb
telegraf & influxd 
