# dotfiles

個人用 dotfiles リポジトリ。  
Homebrew でツールを入れて、GNU Stow で設定ファイルをシンボリックリンク管理する。

## 管理対象

- `nvim` - Neovim 設定
- `starship` - Starship 設定
- `karabiner` - Karabiner-Elements 設定
- `zsh` - zsh 設定
- `Brewfile` - Homebrew / VSCode 拡張の一覧

## 前提

macOS を想定。

必要なもの:

- Homebrew
- GNU Stow

## 初回セットアップ

### 1. リポジトリを clone

```bash
git clone https://github.com/inbook58/dotfiles.git ~/dotfiles
cd ~/dotfiles

2. Homebrew パッケージをインストール

brew bundle

3. dotfiles を反映

stow nvim
stow starship
stow karabiner
stow zsh

Terraform / tenv

Terraform 本体は tenv で管理する。

最新版を入れる場合

tenv terraform install latest
tenv terraform use latest

バージョンを指定する場合

tenv terraform install 1.14.7
tenv terraform use 1.14.7

更新方法

設定を編集

dotfiles 配下のファイルを直接編集する。

例:

~/dotfiles/nvim/.config/nvim
~/dotfiles/starship/.config/starship.toml
~/dotfiles/karabiner/.config/karabiner
~/dotfiles/zsh/.zshrc

変更を反映

通常は symlink 済みなので、編集した時点で反映される。
新しく管理対象を追加した場合は stow を再実行する。

stow nvim
stow starship
stow karabiner
stow zsh

Brewfile を更新

brew bundle dump --force

不要な項目が混ざることがあるので、必要に応じて手で整理する。

確認コマンド

シンボリックリンク確認

ls -l ~/.config
ls -l ~/.zshrc

Terraform 確認

terraform version
tenv version

トラブルシュート

stow で競合する場合

既存ファイルがあると競合することがある。
たとえば .zshrc が既存ファイルなら退避してから stow する。

mv ~/.zshrc ~/.zshrc.backup
stow zsh

karabiner や nvim の反映先確認

ls -l ~/.config | grep -E 'nvim|starship|karabiner'

管理しないもの

以下はこのリポジトリでは基本的に管理しない。
	•	gcloud の認証情報やローカル状態
	•	configstore
	•	.DS_Store
	•	キャッシュ類
	•	一時ファイル
	•	Terraform の state / .terraform ディレクトリ

メモ
	•	設定はホームディレクトリ側ではなく、~/dotfiles 側を編集する
	•	新しい Mac でも brew bundle と stow でだいたい復元できる

ファイル作成はこれでいける。

```bash
cat <<'EOF' > README.md
# dotfiles

個人用 dotfiles リポジトリ。  
Homebrew でツールを入れて、GNU Stow で設定ファイルをシンボリックリンク管理する。

## 管理対象

- `nvim` - Neovim 設定
- `starship` - Starship 設定
- `karabiner` - Karabiner-Elements 設定
- `zsh` - zsh 設定
- `Brewfile` - Homebrew / VSCode 拡張の一覧

## 前提

macOS を想定。

必要なもの:

- Homebrew
- GNU Stow

## 初回セットアップ

### 1. リポジトリを clone

```bash
git clone https://github.com/inbook58/dotfiles.git ~/dotfiles
cd ~/dotfiles

2. Homebrew パッケージをインストール

brew bundle

3. dotfiles を反映

stow nvim
stow starship
stow karabiner
stow zsh

Terraform / tenv

Terraform 本体は tenv で管理する。

最新版を入れる場合

tenv terraform install latest
tenv terraform use latest

バージョンを指定する場合

tenv terraform install 1.14.7
tenv terraform use 1.14.7

更新方法

設定を編集

dotfiles 配下のファイルを直接編集する。

例:

~/dotfiles/nvim/.config/nvim
~/dotfiles/starship/.config/starship.toml
~/dotfiles/karabiner/.config/karabiner
~/dotfiles/zsh/.zshrc

変更を反映

通常は symlink 済みなので、編集した時点で反映される。
新しく管理対象を追加した場合は stow を再実行する。

stow nvim
stow starship
stow karabiner
stow zsh

Brewfile を更新

brew bundle dump --force

不要な項目が混ざることがあるので、必要に応じて手で整理する。

確認コマンド

シンボリックリンク確認

ls -l ~/.config
ls -l ~/.zshrc

Terraform 確認

terraform version
tenv version

トラブルシュート

stow で競合する場合

既存ファイルがあると競合することがある。
たとえば .zshrc が既存ファイルなら退避してから stow する。

mv ~/.zshrc ~/.zshrc.backup
stow zsh

karabiner や nvim の反映先確認

ls -l ~/.config | grep -E 'nvim|starship|karabiner'

管理しないもの

以下はこのリポジトリでは基本的に管理しない。
	•	gcloud の認証情報やローカル状態
	•	configstore
	•	.DS_Store
	•	キャッシュ類
	•	一時ファイル
	•	Terraform の state / .terraform ディレクトリ

メモ
	•	設定はホームディレクトリ側ではなく、~/dotfiles 側を編集する
	•	新しい Mac でも brew bundle と stow でだいたい復元できる
