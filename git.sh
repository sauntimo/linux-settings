# Git functions and aliases

# Git status
function gs(){
    clear
    git status
}

function gb(){
    clear
    git branch
}

# checkout a branch by issue number
function gcon(){
    git checkout $(git branch | grep $1 )
    # clear webpack cache
    _cwpc
}

# clear and diff
function gd {
        clear
        git diff
}

alias gg='git grep -i'
alias ga='git add .'

# grep piped to word count to count instances
function gcount {
    git grep -l '$1' | wc -l
}

# git fix last commit message
function gfm {
    clear
    git commit --amend -m "$1"
    printf '\nNew commit details:\n\n'
    git log -1
    printf '\n'
}

# git undo last commit
function gulc {
    # undo last commit
    git reset --soft HEAD~
    # unstage edited files
    git reset
    clear
    git status
}

# get git branch
function get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# push current branch to origin ("git push up")
function gpu(){
    branch=$(get_git_branch)
    git push origin $branch 
}

# git search remote branches for term ("git branch all grep")
function gbag {
    git fetch
    git branch -a | grep "$1" | grep "remotes"
}

# Git Checkout
function gco() {
    # go to top level which is required for sqitch
    _tl
    # get latest state from git
    git fetch
    # use sqitch to checkout which should sync code/schema changes
    git checkout $1
    # clear webpack cache
    _cwpc
    # View sqitch status
    sqitch status
    printf '\n'
}

# 2 args, $1 greps the remote branches and $2 returns the nth result
# git track remote branch locally and check it out ("git track checkout number")
function gtcon {
    branch=$(gbag $1 |  sed -n $2p | grep -o -P "(?<=remotes\/origin\/)(.*)$")
    echo $branch
    gco $branch
}

# ack find and replace
function afar {
    ack -l "$1" | xargs sed -i s/"$1"/"$2"/g
}

# clear and pretty log ("git log")
function gl {
	clear
    prev_time=""
    printf '%-10s : %-9s : %-9s : %s\n' "Date" "Hash" "Author" "Message (Branch)"
    printf '%-10s : %-9s : %-9s : %s\n' "----------" "---------" "---------" "-----------------------------------------------------------------------------"
        # --pretty=tformat puts new lines after commits rather than between them. Without that, we lose the last line in the while read.
        git log --pretty=tformat:'%C(green)%cd%Creset :|%C(red)%h%Creset :|%C(bold blue)%an |%Creset:%C(yellow)%d%Creset %s' --date=short -50 --abbrev-commit |
        while IFS='|' read time hash author message
        do
            # format the author to just show first name
            author_short=$author
            author_short=$( echo $author | cut -d' ' -f 1)
            author_short="${author_short/deannamarbeck/Deanna}"
            author_short="${author_short/thisoldbear/Daniel}"
            author_short="${author_short/dependabot/bot}"       

            # Let's only show the date when it's a new one
            time_print="$time"

            if [[ "$time" == "$prev_time" ]]
            then
                time_print="           :"
            fi

            # truncate the message to 77 chars
            print_message=$message
            if [ ${#print_message} -gt 77 ]
            then
                print_message="${message:0:77}.."
            fi

            printf '%-12s %s %-9s %s\n' "$time_print" "$hash" "$author_short" "$print_message"
            prev_time="$time"
        done
}
