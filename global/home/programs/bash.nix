{
  programs.bash = {
    enable = true;
    promptInit = ''
      RED='\[\e[0;31m\]'
      GREEN='\[\e[0;32m\]'
      YELLOW='\[\e[0;33m\]'
      BLUE='\[\e[0;34m\]'
      MAGENTA='\[\e[0;35m\]'
      CYAN='\[\e[0;36m\]'
      WHITE='\[\e[0;37m\]'
      RESET='\[\e[0m\]'

      PS1="${GREEN}\u${BLUE}@\h ${YELLOW}\w${RESET} \$ "
    '';
  };
}
