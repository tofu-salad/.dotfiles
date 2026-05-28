case $- in
    *i*) ;;
    *) return ;;
esac

# use fish if available
if grep -qv fish /proc/$PPID/comm && [[ $SHLVL == [12] ]]; then
    SHELL=$(command -v fish) exec fish
fi
