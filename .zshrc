# Profiling ZSH shell
# zmodload zsh/zprof
# use "zprof" or add it at the end

# load our files (aliases, export, oh-my-zsh config etc)
for file in ~/.dotfiles/*.zsh; do
    source "$file"
done

# Lazy load stuff
group_lazy_load $HOME/.rvm/scripts/rvm rvm irb rake rails
unset -f group_lazy_load
