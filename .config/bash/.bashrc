# bashrc

export EDITOR='nvim'
export VISUAL='nvim'
alias lc='colorls -lA --sd'


[[ $- != *i* ]] && return

#alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# draw horiz line under prompt
draw_line() {
  local COLUMNS="$COLUMNS"
  while ((COLUMNS-- > 0)); do
    printf '\e[30m\u2500'
  done
}

# my prompt
PS1="\[\033[32m\]  \[\033[37m\]\[\033[34m\]\w \[\033[0m\]"
PS2="\[\033[32m\]  > \[\033[0m\]"


alias ls='logo-ls'
alias la='logo-ls -A'
alias ll='logo-ls -al'
# equivalents with Git Status on by Default
alias lsg='logo-ls -D'
alias lag='logo-ls -AD'
alias llg='logo-ls -alD'
alias lf='/home/gregor/.local/bin/lfub'

alias ncmcpp=" ~/.config/ncmpcpp/ncmpcpp-ueberzug/ncmpcpp-ueberzug"

alias 1B='echo 10 | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias 5B='echo 50 | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias 10B='echo 150 | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias 25B='echo 250 | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias 50B='echo 400 | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias 75B='echo 575 | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias 100B='echo 900 | sudo tee /sys/class/backlight/intel_backlight/brightness'



# fnm
export PATH=/home/gregor/.fnm:$PATH
eval "`fnm env`"
