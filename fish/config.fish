if status is-interactive
    set -g fish_greeting ''
    oh-my-posh init fish --config ~/.config/fish/theme.omp.json | source
end