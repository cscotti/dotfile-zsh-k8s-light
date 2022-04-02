export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster2"
# ZSH_THEME="miloshadzic"

# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  gcloud
  docker
  kubectl
  docker
  docker-compose
  terraform
  minikube
  helm
  kubectl
  node
  npm
  python
  pip
  pipenv
  pyenv
  systemd
  golang
  history
  tmux
  ansible
  postgres
  vagrant
  helm
  history
  systemd
  vagrant
  zsh-autosuggestions
  )

source $ZSH/oh-my-zsh.sh

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

# =====================
#  powerline10k

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add a space in the first prompt
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
# Visual customisation of the second prompt line
# local user_symbol="$"
# if [[ $(print -P "%#") =~ "#" ]]; then
#     user_symbol = "#"
# fi
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"

# =====================
#french keyboard

setxkbmap fr

# =====================
#  functions

fgl() { find . -type f -not -path "./.git/*" -exec grep -l "$1" '{}' \; }
fglp() { find . -type f -not -path "./.git/*" -exec grep "$1" '{}' \; }
fg() { find . -name "*$1*" -type f|grep -v "/.git/"|xargs grep "$2"; }
f() { find . -name "*$1*" |grep -v "/.git/";}
kgpc() { kubectl get po -l component="$1";}
decode () {
  echo "$1" | base64 -d ; echo
}

kgpcomp() { kubectl get po -l component="$1";}
kgpcont() { kubectl get pods -o="custom-columns=NameSpace:.metadata.namespace,NAME:.metadata.name,CONTAINERS:.spec.containers[*].name,status:.status.phase" |grep "$1";}


# =====================
#  Divers

alias -g G='| grep -i'
alias ip="ifconfig | grep inet | grep broadcast | cut -d' ' -f2"
alias pubip="curl ipinfo.io/ip"
alias sf="screenfetch -E"
alias vzsh="vim ~/.zshrc"
alias szsh="source ~/.zshrc"

function grepe {
  grep --color -E "$1|$" $2
}

# =====================
# gcloud

# gcloud key for Terraform
# export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.token/xxxxx.json
alias gc="gcloud"
alias ggmaster="gcloud container clusters get-credentials master"
alias gctxl="gcloud config configurations list"
alias gctx="gcloud config configurations activate"
alias gtol="gcloud pubsub topics list"
alias gsubl="gcloud pubsub subscriptions"
alias gtosubl="gcloud pubsub topics list-subscriptions"

# =====================
# kubectl

export KUBE_EDITOR=nano

source ~/.kube-prompt.sh

alias k="kubectl"
alias kclf="kubectl logs -f"
alias kc="kubecolor --force-colors"
alias kdoc="kubectl explain $1 --recursive"
alias kport="kubectl get po --all-namespaces -o=jsonpath=\"{range .items[*]}{.spec.nodeName}{'\t'}{.spec.hostNetwork}{'\t'}{.metadata.namespace}{'\t'}{.metadata.name}{'\t'}{.spec.hostNetwork}{'\t'}{.spec.containers..containerPort}{'\n'}{end}\""
alias ktaint="kubectl get node  -o=jsonpath='{range .items[*]}{.metadata.name}{\"\t\"}{.spec.taints}{\"\n\"}{end}'"
alias klabel="kubectl get nodes --show-labels"
alias kupscale="kubectl get hpa | awk '{if (\$4 < \$6) print \$0}'"
alias ksearch="kubectl get po| grep "
alias kpf="kubectl port-forward"
alias kapi="kubectl explain $1 --recursive"
alias kres="kubectl api-resources -o wide" #--api-group=extension
alias kport="kubectl get po --all-namespaces -o=jsonpath=\"{range .items[*]}{.spec.nodeName}{'\t'}{.spec.hostNetwork}{'\t'}{.metadata.namespace}{'\t'}{.metadata.name}{'\t'}{.spec.hostNetwork}{'\t'}{.spec.containers..containerPort}{'\n'}{end}\""
alias ktaint="kubectl get node  -o=jsonpath='{range .items[*]}{.metadata.name}{\"\t\"}{.spec.taints}{\"\n\"}{end}'"
alias klabel="kubectl get nodes --show-labels"
alias kjob="kubectl get job -o=\"custom-columns=NAME:.metadata.name,STATUS:.status.conditions[].status,TYPE:.status.conditions[].type,REASON:.status.conditions[].reason,DESC:.status.conditions[].message,lastProbeTime:.status.conditions[].lastProbeTime,lastTransitionTime:.status.conditions[].lastTransitionTime\""

alias ggmaster="gcloud container clusters get-credentials master"
alias gctxl="gcloud config configurations list"
alias gctx="gcloud config configurations activate"

alias tol="gcloud pubsub topics list"
alias subl="gcloud pubsub subscriptions"
alias tosubl="gcloud pubsub topics list-subscriptions"

function ksecretpass {
  kubectl get secret "$1" -o jsonpath='{ .data.password}'  | base64 --decode
}

function kcgpg() {
   kubectl get pods | grep $1 | cut -d" " -f 1
}

function kcpfg() {
   kubectl port-forward `kcgpg $1 | head -n 1` $2 
}

function kclogsg() {
   kubectl logs -f `kcgpg $1 | head -n 1`
}

function kcgorec() {
   kubectl config set-context gke-rec --cluster=gke_rec_europe-west1-d_master --user=gke_rec_europe-west1-d_master --namespace=default
   kubectl config use-context gke-rec
}

function kcgetport() {
   kubectl describe pod $1 | grep Port:
}

function portki() {
   sudo lsof -i tcp:$1
}

function kcchangenamespace() {
   echo "kubectl config set-context $(kubectl config current-context) --namespace=<insert-namespace-name-here>"
   kubectl config set-context $(kubectl config current-context) --namespace=$1
}

# =====================
# kubectx and kubens

export PATH=~/.kubectx:$PATH
alias kctx="kubectx"
alias kns="kubens"

# =====================
# Terraform

#export PATH="$HOME/.tfenv/bin:$PATH"

alias tp="terraform plan"
alias ti="terraform init"

# =====================
# Mongo
alias cleanmongors=" sed -e 's/ObjectId(\"/\"/g' | sed -e 's/ISODate(\"/\"/g' | sed -e 's/\")/\"/g'"


# =====================
# Git
alias git_config="git config --global --list"

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

alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias pullover="git stash && git pull && git stash pop"
alias gds="git diff --staged"
alias devopspush="git pull --rebase origin master && git pull --rebase origin auto-deploy && git pull --rebase origin master && git push"

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

# ==========================
# FLUXCD
# install
# curl -s https://fluxcd.io/install.sh | sudo bash

. <(flux completion zsh)
#export GITHUB_TOKEN=cscotti
#export GITHUB_USER=

flux_check(){ flux check --pre}
flux_get()  { flux get kustomizations --watch}


# =====================
# Macos tips

#  launch chrome for local https testing 
#  alias chrome-ignore-cert "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --ignore-certificate-errors &> /dev/null &"

# macfix / fix brew folder
#  sudo chown -R $(whoami) /usr/local/share/zsh /usr/local/share/zsh/site-functions
#  chmod go-w '/usr/local/share'

# macfix / fix minikube completion
# declare -A aliashash 2>/dev/null # the only way I found to make the completion work on my laptop
# source <(minikube completion zsh)


