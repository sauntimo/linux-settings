# Postgres shortcuts

# log in to postgres
_pgl(){
    PGPASSWORD=$PGPASSWORD PGOPTIONS=--search_path=api psql -h psql.dev.travellocal.com -U postgres -d travellocal_dev
}

# run a query from the command line. Pass in the quoted query as a string. 
_pgq(){
    PGPASSWORD=$PGPASSWORD PGOPTIONS=--search_path=api psql -X -h psql.dev.travellocal.com -U postgres -d travellocal_dev -c "$@"
}

# run a query from the command line. Quiet, ie returns tuples only (ie no headings/row counts) 
_pgqq(){
    PGPASSWORD=$PGPASSWORD PGOPTIONS=--search_path=api psql -t -X -h psql.dev.travellocal.com -U postgres -d travellocal_dev -c "$@"
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

# Creates a new sqitch migration
_sm(){
    if [ -z "$1" ]
    then
        echo "Exiting as migration name was provided."
        return 0
    fi

    # get the highest available tag from the db. xargs trims whitespace...
    tag=$(_pgqq "SELECT tag FROM sqitch.tags ORDER BY tag DESC LIMIT 1;" | xargs)
    sqitch add --all -r "$tag" "$1"
}
