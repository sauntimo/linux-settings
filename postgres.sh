# Postgres shortcuts

# log in to postgres
_pgl(){
    PGPASSWORD=$PGPASSWORD PGOPTIONS=--search_path=api psql -h psql.dev.travellocal.com -U postgres -d travellocal_dev
}

# run a query from the command line. Pass in the quoted query as a string. 
_pgq(){
    PGPASSWORD=$PGPASSWORD PGOPTIONS=--search_path=api psql -X -h psql.dev.travellocal.com -U postgres -d travellocal_dev -c "$@"
}

# dev db test query
_pgu(){
    _pgq 'SELECT * FROM "user" LIMIT 3;'
}

# log in to postgres TEST DB
_pgtl(){
    PGPASSWORD=$PGPASSWORD PGOPTIONS=--search_path=api psql -h psql.dev.travellocal.com -U postgres -d travellocal_test
}

# run a query from the command line ON THE TEST DB. Pass in the quoted query as a string. 
_pgqt(){
    PGPASSWORD=$PGPASSWORD PGOPTIONS=--search_path=api psql -X -h psql.dev.travellocal.com -U postgres -d travellocal_test -c "$@"
}

# dev db test query
_pgtu(){
    _pgqt 'SELECT * FROM "user" LIMIT 3;'
}
