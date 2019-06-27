if [ -f /etc/bashrc ]; then
 . /etc/bashrc
fi

alias ll='ls -Al'
alias s='cd ..'

export EDITOR='vim'
export HISTCONTROL='ignoredups'
export PROMPT_COMMAND='history -a; history -c; history -r'

shopt -s histappend
shopt -s checkwinsize

fancy_prompt() {
  local red=$(tput setaf 208)
  local green=$(tput setaf 2)
  local blue=$(tput setaf 4)
  local purple=$(tput setaf 5)
  local reset=$(tput sgr0)
  export PS1=" \[$green\]\u \[$red\]\w\[$green\]\$(__git_ps1)\n └─▶\[$reset\] "
}

if [ -f /usr/local/share/git-prompt.sh ]; then
  source /usr/local/share/git-prompt.sh
  if [ "$(type -t __git_ps1)" == 'function' ]; then
    fancy_prompt
  fi
fi

if [ -f "${HOME}/.chef/credentials" ]; then
  XCHEF_SERVER=$(grep ^chef_server_url "${HOME}/.chef/credentials" | cut -d \' -f2')
  if [ "x" != "x${XCHEF_SERVER}" ]; then
    cowthink -p -W120 "$(tput setaf 2)${XCHEF_SERVER}$(tput sgr0)"
  fi
fi
