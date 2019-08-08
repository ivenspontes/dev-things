#!/bin/sh

sudo passwd postgres
su postgres

psql -c "ALTER USER postgres WITH PASSWORD 'nova_senha'" -d template1