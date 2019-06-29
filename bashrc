if [ -f /etc/bashrc ]; then
 . /etc/bashrc
fi

export PATH="${HOME}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

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

chef-info() {
  tput setaf 2
  if [ -f "${HOME}/.chef/credentials" ]; then
    XCHEF_SERVER=$(grep ^chef_server_url "${HOME}/.chef/credentials" | cut -d "'" -f2 2>/dev/null )
    XCHEF_USER=$(grep ^client_name "${HOME}/.chef/credentials" | cut -d "'" -f2 2>/dev/null )
    if [ "x" != "x${XCHEF_SERVER}" ]; then
       echo -e "Chef URL: ${XCHEF_SERVER}\nUsername: ${XCHEF_USER}" | cowthink -p -n -W120
    else
      tput setaf 1
      cowthink -p -W120 'No server configuration found'
    fi
  else
    tput setaf 1
    cowthink -p -W120 'No chef configuration found'
  fi
  tput sgr0
}


chef-info
