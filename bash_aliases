alias ls='ls -CF'
alias rm='rm -i'
alias mv='mv -i'
alias pa='ps -ef'

alias blck='echo -n [q'
alias whte='echo -n [p'
alias hue='echo -n [w'
alias pwd='echo $PWD'

##
## Root can't read news
if test "$USER" = "root" -o "$USER" = "rmichael"; then
    alias rn="echo 'No news for root'"
    alias trn="echo 'No news for root'"
    alias tin="echo 'No news for root'"
fi
##
## Console only
if [ "x$TERM" == "xsun" -o "x$TERM" == "xat386" ]; then
    :
else
    alias sunview="echo 'Only on the console.'"
    alias suntools="echo 'Only on the console.'"
    alias xinit="echo 'Only on the console.'"
    alias startx="echo 'Only on the console.'"
    alias startv="echo 'Only on the console.'"
fi  

