(use-modules (gnu)
	     (gnu services databases)
	     (gnu services dbus)
	     (gnu services nix)
	     (gnu services virtualization)
	     (gnu packages))

(operating-system
  (host-name "isard-dev")
  (timezone "Europe/Madrid")
  (bootloader (bootloader-configuration
		(bootloader grub-efi-bootloader)
		(target "/boot/efi")))
  (file-systems (append (list (file-system
				(device (file-system-label "root"))
				(mount-point "/")
				(type "ext4")))
			%base-file-systems))
  (users (append (list (user-account
			 (name "dev")
			 (group "users")
			 (home-directory "/home/dev")
			 (supplementary-groups
			   '("libvirt"
			     "audio"))))
		 %base-user-accounts))
  (sudoers-file
    (plain-file "sudoers"
		(string-append (plain-file-content %sudoers-specification)
			       (format #f "~a ALL = NOPASSWD: ALL ~%"
				       "dev"))))
  (services (append (list (service libvirt-service-type
				   (libvirt-configuration
				     (unix-sock-group "libvirt")))
			  (service nix-service-type)
			  (service postgresql-service-type)
			  (service redis-service-type))
		    %base-services))
  (packages (append (map specification->package
			 '(;; System packages
			   "nss-certs"
			   "nix"
			   "fontconfig"
			   "font-google-noto"
			   "font-iosevka"

			   ;; General development packages
			   "go@1.14"
			   "make"
			   "gcc-toolchain"
			   "git"
			   "git-flow"
			   "neovim"
			   "tmux"
			   "redis"
			   "curl"

			   ;; Used for compiling the gRPC transport
			   "protobuf@3.6"
			   ;; protobuf-go
			   ;; grpc-go

			   ;; Used for the hyper microservice
			   "pkg-config"
			   "libvirt"))
		    %base-packages))
  (skeletons
    `((".bash_profile" ,(plain-file "bash_profile" "\
 # Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi\n"))
      (".bashrc" ,(plain-file "bashrc" "\
  # Bash initialization for interactive non-login shells and
  # for remote shells (info \"(bash) Bash Startup Files\").

  # Export 'SHELL' to child processes.  Programs such as 'screen'
  # honor it and otherwise use /bin/sh.
  export SHELL

  if [[ $- != *i* ]]
  then
      # We are being invoked from a non-interactive shell.  If this
      # is an SSH session (as in \"ssh host command\"), source
      # /etc/profile so we get PATH and other essential variables.
      [[ -n \"$SSH_CLIENT\" ]] && source /etc/profile

      # Don't do anything else.
      return
  fi

  # Source the system-wide file.
  source /etc/bashrc

  # Adjust the prompt depending on whether we're in 'guix environment'.
  if [ -n \"$GUIX_ENVIRONMENT\" ]
  then
      PS1='\\u@\\h \\w [env]\\$ '
  else
      PS1='\\u@\\h \\w\\$ '
  fi
  alias ls='ls -p --color=auto'
  alias ll='ls -l'
  alias grep='grep --color=auto'
  alias vim='nvim'

  #
  # Isard Development
  #

  # env setup
  source /run/current-system/profile/etc/profile.d/nix.sh
  export PATH=$PATH:~/.nix-profile/bin

  if [ ! -f ~/.isard-dev-configured ]; then
  	sudo chown -R $(whoami):users /data/dev

    mkdir -p /data/$(whoami)/isard
    mkdir -p /data/$(whoami)/isard-dev
    mkdir -p /data/$(whoami)/.config/VSCodium/User

    mkdir ~/.config

    ln -s /data/$(whoami)/isard isard
    ln -s /data/$(whoami)/isard-dev isard-dev
    ln -s /data/$(whoami)/.config/VSCodium ~/.config/VSCodium

	guix pull
	hash guix

	nix-channel --add https://nixos.org/channels/nixos-20.03 nixos
	nix-channel --update

	ln -s /nix/var/nix/profiles/per-user/$(whoami)/profile ~/.nix-profile

	nix-env -iA nixos.vscodium

    if [ ! -f ~/.config/VSCodium/User/settings.json  ]; then
        echo '{
            \"workbench.iconTheme\": \"material-icon-theme\",
            \"workbench.colorTheme\": \"Ayu Mirage Bordered\",
            \"go.useLanguageServer\": true,
            \"[go]\": {
                \"editor.formatOnSave\": true,
                \"editor.codeActionsOnSave\": {
                    \"source.organizeImports\": true,
                },
            },
            \"[go.mod]\": {
                \"editor.formatOnSave\": true,
                \"editor.codeActionsOnSave\": {
                    \"source.organizeImports\": true,
                },
            },
            \"gopls\": {
                \"usePlaceholders\": true,
                \"staticcheck\": false,
            }
        }'> ~/.config/VSCodium/User/settings.json
    fi

	codium --install-extension golang.go
	codium --install-extension pkief.material-icon-theme
	codium --install-extension zxh404.vscode-proto3
	codium --install-extension redhat.vscode-yaml
	codium --install-extension teabyii.ayu
	codium --install-extension hediet.vscode-drawio

	mkdir -p ~/.local/share
	ln -s /run/current-system/profile/share/fonts ~/.local/share/fonts

	echo \"[user]
	name = ${GITHUB_NAME}
	email = ${GITHUB_EMAIL}\" > ${HOME}/.gitconfig

	for repo in isard isard-dev; do
        if [ ! -d ${repo}/.git ]; then
            git clone https://github.com/${GITHUB_USER}/${repo}
            cd ${repo}

            git config url.\"https://${GITHUB_USER}@github.com\".InsteadOf \"https://github.com\"
            git remote add upstream https://github.com/isard-vdi/${repo}

            git flow init -d

            [ -f go.mod ] && go mod tidy

            cd -
        fi
	done

	touch ~/.isard-dev-configured
  fi
  \n")))))
