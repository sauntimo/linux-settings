# Rabbit MQ shortcuts

# rabbitmq purge all queues
# nb run from tl root to use env vars
_rmqp(){
    (_tl && docker-compose exec rabbitmq /bin/bash -c "rabbitmqadmin --format tsv list queues | tail +2 | cut -f 1 | xargs -n1 -I@ rabbitmqadmin purge queue name=@")
}
