# Shortcuts for stuff to do with javascript tools

# Webpack

# clear webpack cache
function _cwpc() {
    (
        _tl && 
        rm -rf frontend/node_modules/.cache && 
        rm -rf backend/node_modules/.cache && 
        rm -rf bothends/node_modules/.cache
    )
    printf '\n==> Webpack cache cleared, make sure you restart your watch tasks.\n\n'
}

# Yarn

# run backend watch task
function _yb() {
    _tlb
    yarn install
    clear
    yarn build-watch
}

# run frontend watch task
function _yf() {
    _tlf
    yarn install
    clear
    yarn dev-client
    printf '\n\n\Have you run yarn dev-server recently? maybe you should\n\n'
}

# run fontend server rebuild
function _yds() {
    _tlf
    yarn install
    clear
    yarn dev-server
}

# # run travellocal backend tests
# function test-b() {
#     _tlb
#     clear
#     pwd
#     CI=1 yarn test --grep "@api" -i
# }

# # run a specified test suite
# function _yt() {
#     if [ -z "$1" ]
#     then
#         echo "Exiting as no test suite was specified. Remember to quote it, especially if it begins with a '#'."
#         return 0
#     fi
#     clear
#     yarn test --grep $1
# }

# run a specified backend test file
function _ytb() {
    if [ -z "$1" ]
    then
        echo "Exiting as no test suite was specified. Remember to quote it, especially if it begins with a '#'."
        return 0
    fi
    clear
    printf "Attempting to run tests matching this regex: .*$1.*\.test\.ts$"
    _tlb
    yarn test --testRegex ".*$1.*\.test\.ts$"
}