alias _dcs="docker-compose ps"

# docker logs for a container eg web, api, postgres
function _dcl(){
    docker-compose logs --tail=500 $1
}

# docker start container
function _dcup(){
    docker-compose up -d $1
}

#docker stop container
function _dcstop(){
    docker-compose stop $1
}

# get local docker ip addresses and ports
function _dip() {
    if [ -z $1 ]; then
        docker ps -a --format "{{.ID}}" | while read -r line ; do
            echo $line $(docker inspect --format "{{ .Name }} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $line | sed 's/\///'):$(docker port "$line" | grep -o "0.0.0.0:.*" | cut -f2 -d:)
        done
    fi
}

# restart a specific docker container
function _drs() {

    if [ -z "$1" ]
    then
        echo "Exiting as no container was specified for restart."
        exit 1
    fi

    # Note run from top-level directory so that .env vars are pulled into containers
    # docker-compose stop $1
    (_tl && docker-compose restart $1)
}

# rebuild a specific docker container
function _drb() {

    if [ -z "$1" ]
    then
        echo "Exiting as no container was specified for rebuild. If you want to rebuild all containers, run _drb_all."
        return 0
    fi

    # Note run from top-level directory so that .env vars are pulled into containers
    # docker-compose stop $1
    (_tl && docker-compose rm -vf $1)
    (_tl && docker-compose up -d --build $1)

    if [[ $1 == 'postgres' ]]; then
        printf "\n\nRemember to rebuild your databases after rebuilding the postgres container.\n\n"
    fi
}

# rebuild all docker containers
_drb_all() {
    docker-compose stop
    docker-compose rm -vf
    docker-compose up -d --build
    printf "\n\nRemember to rebuild your databases after rebuilding the postgres container.\n\n"
}


# open a shell in a docker container
# note run `env` inside it to see environment variables
function _dcsh {
    docker-compose exec $1 /bin/bash
}

# docker-compose hard reset
function _dchr {
    if [ -z "$1" ]
    then
        echo "Exiting as no container was specified for hard reset"
        return 0
    fi
    docker-compose stop $1
    docker-compose build --no-cache $1
    docker-compose up -d --force-recreate $1
}

# prune docker images to reclaim disk space
function _dpa {
    docker images prune -a
}
