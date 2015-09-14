## OS

Check nixpkgs

## Database
Startup database

su - postgres
nix-shell
pg_ctl start -l /var/lib/pgsql/logs/postgres.log
# password

psql
\l

psql -h th-db-postgres-01.c8iukf8yttff.eu-west-1.rds.amazonaws.com -p 5432 --username=awstinkadmin --password --dbname=winterfell

braavos
password: p*d

# If db does not yet exist, create it
  CREATE DATABASE odoo WITH OWNER=odoo ENCODING='UTF8';
  # Go to the server to have it initialized
  ./odoo.py --addons-path=addons --log-level=debug --db-filter=paintcreation$
  master password: admin (todo: where does this come from?)
  database name: odoo
  password: password

# \c paintcreation
\c odoo
\dt
\d+ res_users
select login from res_users;


exit

cd /opt/odoo-tinkhaven
git checkout 8.0_DEMO_PAINTCREATION
./odoo.py --addons-path=addons --log-level=debug --db-filter=paintcreation$

Winterfell: With demo data
./odoo.py --addons-path=addons --log-level=debug -d winterfell -r awstinkadmin -w <password> --db_host=th-db-postgres-01.c8iukf8yttff.eu-west-1.rds.amazonaws.com --db_port=5432

Braavos: no demo data
./odoo.py --addons-path=addons --log-level=debug -d braavos -r awstinkadmin -w <password> --db_host=th-db-postgres-01.c8iukf8yttff.eu-west-1.rds.amazonaws.com --db_port=5432

On client
ssh -L 9000:jujuy:8069 tinkerthaler@jujuy

http://localhost:9000
steven / password
admin / password

