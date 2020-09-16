# Tim's Aliases
alias _eb="exec bash"
alias l="ls -halt"

# TL navigation
alias _tl="cd ~/code/travellocal"
alias _tlf="cd ~/code/travellocal/frontend"
alias _tlb="cd ~/code/travellocal/backend"
alias _in="cd ~/code/infrastructure"
alias _data="cd ~/coce/data"
alias _tap="cd ~/code/tap"

export HISTTIMEFORMAT="%d/%m/%y %T "

# Shortcut menu

_print_heading(){
    printf "\n\n$1\n--------------------"
}

_print_item(){
    printf "\n$1 - $2"
}

_shortcuts(){
    printf "\nTim's shortcuts:"

    _print_heading "Git"
    _print_item "gs" "git status"
    _print_item "gl" "git log formatted"
    _print_item "gd" "git diff"
    _print_item "gb" "list local git branch"
    _print_item "gcon" "git checkout branch by issue number"
    _print_item "gcount" "git count grep result"
    _print_item "gfm" "git fix last commit message"
    _print_item "gulc" "git undo last commit"
    _print_item "get_git_branch" "get git branch"
    _print_item "gpu" "git push up to origin / current branch"
    _print_item "gbag" "git branch all grep (search remote branches for term)"
    _print_item "gco" "git chekcout (with cache clearing etc)"
    _print_item "gtcon" "track remote branch locally by issue number"
    _print_item "afar" "ack find and replace"
    _print_item "_cwpc" "clear webpack cache"
    _print_item "_updateGithubCli [x.x.x]" "Update Github CLI"

    _print_heading "Postgres"
    _print_item "_pgl" "log in to dev"
    _print_item "_pgq" "run query on dev"
    _print_item "_pgu" "check dev is up with simple query"
    _print_item "_pgtl" "log in to test"
    _print_item "_pgtq" "run query on test"
    _print_item "_pgtu" "check test is up with simple query"

    _print_heading "Docker"
    _print_item "_dcl" "get logs for a docker container"
    _print_item "_dcs" "get status of all docker containers"
    _print_item "_dcup" "start a docker container"
    _print_item "_dcstop" "stop a docker container"
    _print_item "_dip" "get local docker ip addresses and ports"
    _print_item "_drs" "restart a specific docker container"
    _print_item "_drb" "rebuild a specific docker container"
    _print_item "_drb_all" "rebuild all docker containers"
    _print_item "_dcsh" "open a shell in a docker container"
    _print_item "_dchr" "hard reset a docker container"
    _print_item "_dpa" "prune docker images"
    
    _print_heading "Infrastructure"
    _print_item "_dcri" "docker-compose run infrastructure"

    _print_heading "RabbitMQ"
    _print_item "_rmqp" "purge all queues"
    printf "\n\n"
}
