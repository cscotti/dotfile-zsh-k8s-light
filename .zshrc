export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster2"

# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  go
  gcloud
  docker
  kubectl
  docker-compose
  terraform
  node
  minikube
  helm
  kubectl
  npm
  python
  systemd
  go
  golang
  history
  tmux
  )

source $ZSH/oh-my-zsh.sh

# =====================
#french keyboard

setxkbmap fr

# =====================
#  functions

fgl() { find . -type f |grep -v "/.git/"|xargs grep -l "$1"; }
fg() { find . -name "*$1*" -type f|grep -v "/.git/"|xargs grep "$2"; }
f() { find . -name "*$1*" |grep -v "/.git/";}

# =====================
# gcloud

# gcloud key for Terraform
# export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.token/xxxxx.json

alias ggmaster="gcloud container clusters get-credentials master"
alias gctxl="gcloud config configurations list"
alias gctx="gcloud config configurations activate"
alias gtol="gcloud pubsub topics list"
alias gsubl="gcloud pubsub subscriptions"
alias gtosubl="gcloud pubsub topics list-subscriptions"

# =====================
# kubectl

source ~/.kube-prompt.sh

alias k="kubectl"
alias kctx="kubectx"
alias kns="kubens"
alias kport="kubectl get po --all-namespaces -o=jsonpath=\"{range .items[*]}{.spec.nodeName}{'\t'}{.spec.hostNetwork}{'\t'}{.metadata.namespace}{'\t'}{.metadata.name}{'\t'}{.spec.hostNetwork}{'\t'}{.spec.containers..containerPort}{'\n'}{end}\""
alias ktaint="kubectl get node  -o=jsonpath='{range .items[*]}{.metadata.name}{\"\t\"}{.spec.taints}{\"\n\"}{end}'"
alias klabel="kubectl get nodes --show-labels"

# =====================
# kubectx and kubens

export PATH=~/.kubectx:$PATH

# =====================
# Terraform

#export PATH="$HOME/.tfenv/bin:$PATH"

alias tp="terraform plan"
alias ti="terraform init"

# =====================
# Git

alias gitpv='git -c core.sshCommand="ssh -vvv" pull'
alias gitl="git log --name-status --since='7 days ago'"
alias gitlg="git lg --since='7 days ago'"
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff | mate'
alias gb='git branch'
alias gco='git checkout'
alias gcob='git checkout -b'
alias glog='git log'
alias glogp='git log --pretty=format:"%h %s" --graph'

# =====================
# completion

#gcloud completion
#source /usr/share/google-cloud-sdk/completion.zsh.inc


# =====================
# node
#export PATH=~/.npm-global/bin:$PATH
#export PATH=~/.local/bin:$PATH

# =====================
# Java
## https://www.oracle.com/java/technologies/javase-downloads.html
#export JAVA_HOME=/usr/java/jdk1.8.0_241/bin/java
#export PATH="/usr/java/jdk1.8.0_241/bin:$PATH"

# =====================
# golang
#export PATH=$PATH:/usr/local/go/bin

# =====================
# Python

alias pyenv_on='pyenv activate venv'
alias pyenv_off='pyenv deactivate venv'

##pyenv 
##https://github.com/pyenv/pyenv/blob/master/COMMANDS.md
##https://akrabat.com/creating-virtual-environments-with-pyenv/
##============================================================
#export PATH="$HOME/.pyenv/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
#pyenv install 3.7.5
#pyenv install 2.7.6
#pyenv local 3.7.5 2.7.6
#pyenv versions
