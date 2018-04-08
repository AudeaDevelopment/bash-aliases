# git aliases
alias ac='git add . && git commit -m'
alias commit=myCommit
alias c=myCommit
alias p='git push origin'
alias push='git push origin'
alias s='git status'
alias status='git status'
alias gc=gitClone
alias gp='git pull origin'
alias gb='git branch'
alias branch='git branch'
alias gk='git checkout'
alias gkb='git checkout -b '
alias gkm='git checkout master'

# personal aliases
alias getm=pullMaster
alias gcme=cloneMyRepo
alias gca=cloneAudeaRepo
alias all=allBranches
alias pro=projects
alias md='mkdir -p'
alias rmf="rm -rf $*"

# bash profile edit
function be() {
  code ~/.bashrc
}

# bash profile refresh
function br() {
  source ~/.bash_aliases
}

# clone repo name of input text
 gitClone() {
  git clone "$1"
}

 projects() {
  cd ~/projects/$*
}

function pullMaster() {
  git checkout master
  git pull origin master
}

function cloneMyRepo() {
  git clone https://github.com/{YOUR_GITHUB}/"$1".git  
}

function cloneAudeaRepo() {
  git clone https://github.com/{YOUR_REPO}/"$1".git  
}

# pull all new  branches
allBranches() {
  git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done && git pull --all
}

# test function
function pass_back_a_string() {
    eval "$1='foo bar rab oof'"
}

# change all filenames in current dir to same format
function replace() {
ls | while read upName; do loName=`echo "${upName}" | tr ' ' '_/'`;mv "$upName" "$loName"; done
ls | while read upName; do loName=`echo "${upName}" | tr '[:upper:]' '[:lower:]'`; mv "$upName" "$loName"; done
}

# addCollab() {
#   > curl -i -u "my_user_name:my_password" -X PUT -d '' 'https://api.github.com/repos/my_gh_userid/my_repo/collaborators/my_collaborator_id'
# } 

# create new github repo for myself
function newrepo() {
  read -p 'Auto init?: ' init
  read -p 'Private?: ' private

if [ $init == 'y' ]
  then
    init=true
  else
    init=false
fi
  
if [ $private == 'y' ]
  then
    private=true
  else
    private=false
fi
  echo Making Repo: $1 $init $private
  curl -i -H 'Authorization: token {YOUR_TOKEN}' -d "{\"name\": \"$1\", \"auto_init\": \"$init\", \"private\": \"$private\"}" https://api.github.com/user/repos
  gcme $1
}

# make a new repo in an org
function arepo() {
  read -p 'Auto init?: ' init
  read -p 'Private?: ' private

if [ $init == 'y' ]
  then
    init=true
  else
    init=false
fi
  
if [ $private == 'y' ]
  then
    private=true
  else
    private=false
fi
  echo Making Repo: $1 $init $private
  curl -i -H 'Authorization: token {YOUR_TOKEN}' -d "{\"name\": \"$1\", \"auto_init\": \"$init\", \"private\": \"$private\"}" https://api.github.com/orgs/{YOUR_ORG}/repos
  gca $1 then boilbase $1
}

# Delete a repo
function delRepo() {
  curl -X DELETE -H 'Authorization: token {YOUR_TOKEN}' https://api.github.com/repos/dbyers24/"$1"
}

myCommit() {
  git commit -m "$1"
}

# copy basic boilerplate into current dir
function boilbasic() {
    cp -a ~/projects/boiler-plate/basic/. ./
}

# copy bare files (.gitignore, linter, etc)
function boilbase() {
    cp -a ~/projects/boiler-plate/basic/. ./$1
}

# acp with message & current branch as origin
function acp() {
    git add .
    git commit -m "$*"
    git push origin HEAD
}
