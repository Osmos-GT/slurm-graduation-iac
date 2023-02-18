#!/bin/bash
set -e

psql postgresql://$YELB_DB_USER:$YELB_DB_PASS@$YELB_DB_ADDR:$YELB_DB_PORT/yelbdatabase?sslmode=disable <<-EOSQL
	CREATE TABLE restaurants (
    	name        char(30),
    	count       integer,
    	PRIMARY KEY (name)
	);
	INSERT INTO restaurants (name, count) VALUES ('outback', 0);
	INSERT INTO restaurants (name, count) VALUES ('bucadibeppo', 0);
	INSERT INTO restaurants (name, count) VALUES ('chipotle', 0);
	INSERT INTO restaurants (name, count) VALUES ('ihop', 0);
EOSQL

