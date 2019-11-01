# Rabbit MQ shortcuts

# rabbitmq purge all queues
_rmqp(){
    docker-compose exec rabbitmq /bin/bash -c "rabbitmqadmin --format tsv list queues | tail +2 | cut -f 1 | xargs -n1 -I@ rabbitmqadmin purge queue name=@"  
}
