# ### Start page ###
_tl
clear

# Check that DNS is working okay after persistant issue with WSL overwriting nameservers
_check_yarn(){
    lines="=========="
    printf "\n\n$lines$lines$lines$lines$lines$lines\n\n"
    printf "Here's your /etc/resolv.conf, does it look okay?\n\n"
    cat /etc/resolv.conf
    printf "\nPinging registry.yarnpkg.com... "
    res=$(ping -c 1 registry.yarnpkg.com 2>&1 >/dev/null ; echo $?)
    restext=$([ "$res" == 0 ] && echo "SUCCESS!" || echo "FAILED :(")
    printf "$restext"
    printf "\n\n$lines$lines$lines$lines$lines$lines\n\n"
}

function getDate {
    date "+%H:%M %A %d %B %Y"
}

# prints the day of the week in big fancy ascii art
figlet $(date "+%A")
printf "\nHello $USER, it's $(getDate), let's write some code." 
_check_yarn

printf "PRs currently awaiting review:"
gh pr list --label "needs reviewer"
printf "\n"
git status
printf "\n"
