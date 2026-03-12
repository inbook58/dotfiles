export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH=$PATH:$HOME/google-cloud-sdk/bin

eval "$(starship init zsh)"

# git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gb='git branch'
alias gco='git checkout'

# lazygit aliases
alias lgit='lazygit'
alias lg='lazygit'

# vscode alias
alias c='code'

# neovim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias nv='nvim'

# docker aliases
alias d='docker'
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcb='docker compose build'

# grep aliases with color
alias grep='grep --color=auto'
alias grepn='grep --color=auto -n'
alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'

# kubernetes aliases
alias k='kubectl'
alias kx='kubectx'
alias kn='kubens'
alias kctx='kubectx'
alias kns='kubens'
alias kg='kubiectl get'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deploy'
alias kgn='kubectl get nodes'
alias kdp='kubectl describe pod'
alias kdi='kubectl describe ingress'
alias kl='kubectl logs -f'
alias kap='kubectl apply -f'
alias kimg='kubectl get pods -n app -o jsonpath="{.items[*].spec.containers[*].image}" | tr " " "\n" | grep -v stage-latest'

# gcloud
alias gcloudsp='gcloud config set project'
alias gcloudp='gcloud config get-value project'
alias gcloudl='gcloud config list'
alias stmysql='gcloud compute ssh st-bastion-prod --project=sitest-147004 --zone=asia-east1-a --tunnel-through-iap -- -L 23306:172.21.96.3:3306'

# repgrepとfzfのパイプ用ショトカ関数 e.g.'gr user' 現在のディレクトリ以下で絞り込み検索. -cオプションを付けるとvscodeで開く
gr() {
  local opener="nvim"
  local force_file_mode=0

  # ===== オプション処理 =====
  while [[ "$1" == -* ]]; do
    case "$1" in
      -c)
        opener="code"
        shift
        ;;
      -f)
        force_file_mode=1
        shift
        ;;
      *)
        break
        ;;
    esac
  done

  local selected

  # ===== ファイル名検索モード =====
  if [[ $# -eq 0 || $force_file_mode -eq 1 ]]; then
    selected=$(
      rg --files --hidden --glob "!.git" \
      | fzf --prompt 'file> ' \
            --preview 'bat --style=numbers --color=always {} 2>/dev/null' \
            --preview-window 'up:40%:wrap'
    )

    [[ -z "$selected" ]] && return

    if [[ "$opener" == "code" ]]; then
      code -g "$selected"
    else
      nvim "$selected"
    fi
    return
  fi

  # ===== 中身検索モード =====
  selected=$(
    rg --line-number --no-heading --smart-case "$@" \
    | fzf --delimiter : \
          --preview '
            bash -c "
              file=\$1
              line=\$2
              start=\$((line-5)); [ \$start -lt 1 ] && start=1
              end=\$((line+5))
              bat --style=numbers --color=always \
                  --line-range \$start:\$end \
                  --highlight-line \$line \
                  \"\$file\" 2>/dev/null
            " _ {1} {2}
          ' \
          --preview-window 'up:40%:wrap'
  )

  [[ -z "$selected" ]] && return

  local file line
  file=$(echo "$selected" | cut -d: -f1)
  line=$(echo "$selected" | cut -d: -f2)

  if [[ "$opener" == "code" ]]; then
    code -g "${file}:${line}"
  else
    nvim +"$line" "$file"
  fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height=80% --layout=reverse --border=rounded --color=dark'

# 補完候補をメニューで選べるようにする
zstyle ':completion:*' menu select
bindkey '^[[Z' reverse-menu-complete

autoload -Uz compinit
compinit

setopt auto_menu
setopt auto_list
setopt complete_in_word

# sudo付け忘れたときの救済措置
alias please='sudo $(fc -ln -1)'
