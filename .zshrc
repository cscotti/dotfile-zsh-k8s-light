export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster2"

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
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add a space in the first prompt
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
# Visual customisation of the second prompt line
local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"

# =====================
#french keyboard

setxkbmap fr

# =====================
#  functions

fgl() { find . -type f -not -path "./.git/*" -exec grep -l "$1" '{}' \; }
fglp() { find . -type f -not -path "./.git/*" -exec grep "$1" '{}' \; }
fg() { find . -name "*$1*" -type f|grep -v "/.git/"|xargs grep "$2"; }
f() { find . -name "*$1*" |grep -v "/.git/";}

kgpcomp() { kubectl get po -l component="$1";}
kgpcont() { kubectl get pods -o="custom-columns=NameSpace:.metadata.namespace,NAME:.metadata.name,CONTAINERS:.spec.containers[*].name,status:.status.phase" |grep "$1";}


# =====================
#  Divers

alias -g G='| grep -i'

function grepe {
  grep --color -E "$1|$" $2
}

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

export KUBE_EDITOR=nano

source ~/.kube-prompt.sh

alias k="kubectl"
alias kc="kubecolor --force-colors"
alias kdoc="kubectl explain $1 --recursive"
alias kport="kubectl get po --all-namespaces -o=jsonpath=\"{range .items[*]}{.spec.nodeName}{'\t'}{.spec.hostNetwork}{'\t'}{.metadata.namespace}{'\t'}{.metadata.name}{'\t'}{.spec.hostNetwork}{'\t'}{.spec.containers..containerPort}{'\n'}{end}\""
alias ktaint="kubectl get node  -o=jsonpath='{range .items[*]}{.metadata.name}{\"\t\"}{.spec.taints}{\"\n\"}{end}'"
alias klabel="kubectl get nodes --show-labels"
alias kupscale="kubectl get hpa | awk '{if (\$4 < \$6) print \$0}'"
alias ksearch="kubectl get po| grep "

function ksecretpass {
  kubectl get secret "$1" -o jsonpath='{ .data.password}'  | base64 --decode
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
