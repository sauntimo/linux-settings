# Infrastructure shortcuts

# run infrastructure commands from anywhere in a subshell
function _dcri() {
    (_in && docker-compose run infrastructure $@)
}
