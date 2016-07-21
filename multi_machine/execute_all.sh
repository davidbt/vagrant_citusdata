# add postgresql-9.5-citus pgdg repository
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdg.list
sudo apt-get install wget ca-certificates
wget --quiet --no-check-certificate -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update

# install the server and initialize db
sudo apt-get -y install postgresql-9.5-citus

sudo pg_conftool 9.5 main set shared_preload_libraries citus
sudo pg_conftool 9.5 main set listen_addresses '*'
sudo sed -i "93 i host    all             all             192.168.33.0/24            trust" /etc/postgresql/9.5/main/pg_hba.conf

sudo service postgresql restart
sudo su postgres -c "createdb test"
sudo -i -u postgres psql test -c "CREATE EXTENSION citus;"

