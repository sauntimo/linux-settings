# Rabbit MQ shortcuts

# rabbitmq purge all queues
# nb run from tl root to use env vars
_rmqp(){
    (_tl && docker-compose exec rabbitmq /bin/bash -c "rabbitmqadmin --format tsv list queues | tail +2 | cut -f 1 | xargs -n1 -I@ rabbitmqadmin purge queue name=@")
}


# Run a rabbit mq command inside the rabbit mq container
_rabbitMQWrapper(){
    (_tl && docker-compose exec rabbitmq /bin/bash -c "$1")
}

# post a message to a rabbitmq queue
_rabbitMQPostMessage(){
    _rabbitMQWrapper "rabbitmqadmin publish exchange=amq.default routing_key='""$1""' payload='""$2""'"
}

# Post a message to the event queue
_rabbitMQPostMessageEvent(){
    _rabbitMQPostMessage 'TravelLocal.Event' "$1"
}

# Post a customerNewMessage event to the event queue
_rabbitMQCustomerNewMessageEvent(){
    _rabbitMQPostMessageEvent '{"type":1,"messageId":181241}'
}

# Post a newEnquiry event to the event queue
_rabbitMQNewEnquiryEvent(){
    _rabbitMQPostMessageEvent '{"type":2,"enquiryId":26425}'
}

# Post a customerNewMessage event to the event queue
_rabbitMQNewEnquiryItineraryMessageEvent(){
    _rabbitMQPostMessageEvent '{"type":3,"enquiryItineraryMessageId":181218}'
}

_rmqe(){
    case $1 in
        1)
            _rabbitMQCustomerNewMessageEvent
        ;;
        2)
            _rabbitMQNewEnquiryEvent
        ;;
        3)
            _rabbitMQNewEnquiryItineraryMessageEvent
        ;;
    esac
}
