(use-modules (gnu)
	     (gnu services databases)
	     (gnu services dbus)
	     (gnu services nix)
	     (gnu services virtualization)
	     (gnu packages)
	     (gnu packages golang)
	     (gnu packages databases)

	     ;; Build packages
	     (guix utils)
	     (guix build-system go)
	     (guix download)
	     (guix git-download)
	     (guix packages)
	     ((guix licenses) #:prefix license:))

(define (go-google-golang-org-protobuf-package suffix)
  (package
    (name (string-append
	    "go-google-golang-org-protobuf-"
	    (string-replace-substring suffix "/" "-")))
    (version "1.25.0")
    (source
      (origin
	(method git-fetch)
	(uri (git-reference
	       (url "https://github.com/protocolbuffers/protobuf-go")
	       (commit (string-append "v" version))))
	(sha256
	  (base32 "0apfl42x166dh96zfq5kvv4b4ax9xljik6bq1mnvn2240ir3mc23"))))
    (build-system go-build-system)
    (arguments
      `(#:import-path ,(string-append "google.golang.org/protobuf/" suffix)
	#:unpack-path "google.golang.org/protobuf"))
    (home-page "https://developers.google.com/protocol-buffers")
    (synopsis "Go support for Google's protocol buffers")
    (description "Go support for Protocol Buffers")
    (license license:expat)))

(define-public protoc-gen-go
  (package (inherit (go-google-golang-org-protobuf-package "cmd/protoc-gen-go"))
    (name "protoc-gen-go")))

(define-public go-google-golang-org-protobuf-compiler-protogen
  (package (inherit (go-google-golang-org-protobuf-package "compiler/protogen"))
    (native-inputs
      `(("go-github-com-google-go-cmp-cmp" ,go-github-com-google-go-cmp-cmp)))))

(define-public go-google-golang-org-protobuf-types-descriptorpb
  (package (inherit (go-google-golang-org-protobuf-package "types/descriptorpb"))))

(define-public go-google-golang-org-protobuf-types-pluginpb
  (package (inherit (go-google-golang-org-protobuf-package "types/pluginpb"))))

(define-public go-google-golang-org-protobuf-encoding-prototext
  (package (inherit (go-google-golang-org-protobuf-package "encoding/prototext"))
    (native-inputs
      `(("go-github-com-google-go-cmp-cmp" ,go-github-com-google-go-cmp-cmp)))))

(define-public go-google-golang-org-protobuf-encoding-protowire
  (package (inherit (go-google-golang-org-protobuf-package "encoding/protowire"))
    (native-inputs
      `(("go-github-com-google-go-cmp-cmp" ,go-github-com-google-go-cmp-cmp)))))

(define-public go-google-golang-org-protobuf-reflect-protodesc
  (package (inherit (go-google-golang-org-protobuf-package "reflect/protodesc"))))

(define-public go-google-golang-org-protobuf-reflect-protoreflect
  (package (inherit (go-google-golang-org-protobuf-package "reflect/protoreflect"))))

(define-public go-google-golang-org-protobuf-reflect-protoregistry
  (package (inherit (go-google-golang-org-protobuf-package "reflect/protoregistry"))
    (native-inputs
      `(("go-github-com-google-go-cmp-cmp" ,go-github-com-google-go-cmp-cmp)))))

(define-public go-google-golang-org-protobuf-runtime-protoiface
  (package (inherit (go-google-golang-org-protobuf-package "runtime/protoiface"))))

(define-public go-google-golang-org-protobuf-runtime-protoimpl
  (package (inherit (go-google-golang-org-protobuf-package "runtime/protoimpl"))))

(define-public go-google-golang-org-protobuf-proto
  (package (inherit (go-google-golang-org-protobuf-package "proto"))
    (native-inputs
      `(("go-github-com-google-go-cmp-cmp" ,go-github-com-google-go-cmp-cmp)))))

(define-public go-google-golang-org-protobuf-internal-encoding-defval
  (package (inherit (go-google-golang-org-protobuf-package "internal/encoding/defval"))))

(define-public go-google-golang-org-protobuf-internal-encoding-messageset
  (package (inherit (go-google-golang-org-protobuf-package "internal/encoding/messageset"))))

(define-public go-google-golang-org-protobuf-internal-encoding-text
  (package (inherit (go-google-golang-org-protobuf-package "internal/encoding/text"))
    (native-inputs
      `(("go-github-com-google-go-cmp-cmp" ,go-github-com-google-go-cmp-cmp)))))

(define-public go-google-golang-org-protobuf-internal-encoding-tag
  (package (inherit (go-google-golang-org-protobuf-package "internal/encoding/tag"))))

(define-public go-google-golang-org-protobuf-internal-detrand
  (package (inherit (go-google-golang-org-protobuf-package "internal/detrand"))))

(define-public go-google-golang-org-protobuf-internal-errors
  (package (inherit (go-google-golang-org-protobuf-package "internal/errors"))))

(define-public go-google-golang-org-protobuf-internal-fieldsort
  (package (inherit (go-google-golang-org-protobuf-package "internal/fieldsort"))))

(define-public go-google-golang-org-protobuf-internal-filedesc
  (package (inherit (go-google-golang-org-protobuf-package "internal/filedesc"))
    (native-inputs
      `(("go-github-com-google-go-cmp-cmp" ,go-github-com-google-go-cmp-cmp)))))

(define-public go-google-golang-org-protobuf-internal-filetype
  (package (inherit (go-google-golang-org-protobuf-package "internal/filetype"))))

(define-public go-google-golang-org-protobuf-internal-flags
  (package (inherit (go-google-golang-org-protobuf-package "internal/flags"))))

(define-public go-google-golang-org-protobuf-internal-genid
  (package (inherit (go-google-golang-org-protobuf-package "internal/genid"))))

(define-public go-google-golang-org-protobuf-internal-descfmt
  (package (inherit (go-google-golang-org-protobuf-package "internal/descfmt"))))

(define-public go-google-golang-org-protobuf-internal-descopts
  (package (inherit (go-google-golang-org-protobuf-package "internal/descopts"))))

(define-public go-google-golang-org-protobuf-internal-impl
  (package (inherit (go-google-golang-org-protobuf-package "internal/impl"))
    (native-inputs
      `(("go-github-com-google-go-cmp-cmp" ,go-github-com-google-go-cmp-cmp)))))

(define-public go-google-golang-org-protobuf-internal-mapsort
  (package (inherit (go-google-golang-org-protobuf-package "internal/mapsort"))))

(define-public go-google-golang-org-protobuf-internal-pragma
  (package (inherit (go-google-golang-org-protobuf-package "internal/pragma"))))

(define-public go-google-golang-org-protobuf-internal-set
  (package (inherit (go-google-golang-org-protobuf-package "internal/set"))))

(define-public go-google-golang-org-protobuf-internal-strs
  (package (inherit (go-google-golang-org-protobuf-package "internal/strs"))))

(define-public go-google-golang-org-protobuf-internal-version
  (package (inherit (go-google-golang-org-protobuf-package "internal/version"))))

(define-public protoc-gen-go-grpc
  (package
    (name "protoc-gen-go-grpc")
    (version "1.34.0")
    (source
      (origin
	(method git-fetch)
	(uri (git-reference
	       (url "https://github.com/grpc/grpc-go")
	       (commit (string-append "v" version))))
	(sha256
	  (base32 "0s8y19qvv0zfy2irq8vv12h65v7pw18k6yqfix1j2370yxmsajgm"))))
    (build-system go-build-system)
    (arguments
      '(#:import-path "google.golang.org/grpc/cmd/protoc-gen-go-grpc"
	#:unpack-path "google.golang.org/grpc"))
    (native-inputs
      `(("go-google-golang-org-protobuf-compiler-protogen" ,go-google-golang-org-protobuf-compiler-protogen)
	("go-google-golang-org-protobuf-types-pluginpb" ,go-google-golang-org-protobuf-types-pluginpb)
	("go-google-golang-org-protobuf-types-descriptorpb" ,go-google-golang-org-protobuf-types-descriptorpb)
	("go-google-golang-org-protobuf-encoding-prototext" ,go-google-golang-org-protobuf-encoding-prototext)
	("go-google-golang-org-protobuf-encoding-protowire" ,go-google-golang-org-protobuf-encoding-protowire)
	("go-google-golang-org-protobuf-reflect-protodesc" ,go-google-golang-org-protobuf-reflect-protodesc)
	("go-google-golang-org-protobuf-reflect-protoreflect" ,go-google-golang-org-protobuf-reflect-protoreflect)
	("go-google-golang-org-protobuf-reflect-protoregistry" ,go-google-golang-org-protobuf-reflect-protoregistry)
	("go-google-golang-org-protobuf-runtime-protoiface" ,go-google-golang-org-protobuf-runtime-protoiface)
	("go-google-golang-org-protobuf-runtime-protoimpl" ,go-google-golang-org-protobuf-runtime-protoimpl)
	("go-google-golang-org-protobuf-proto" ,go-google-golang-org-protobuf-proto)
	("go-google-golang-org-protobuf-internal-encoding-defval" ,go-google-golang-org-protobuf-internal-encoding-defval)
	("go-google-golang-org-protobuf-internal-encoding-messageset" ,go-google-golang-org-protobuf-internal-encoding-messageset)
	("go-google-golang-org-protobuf-internal-encoding-text" ,go-google-golang-org-protobuf-internal-encoding-text)
	("go-google-golang-org-protobuf-internal-encoding-tag" ,go-google-golang-org-protobuf-internal-encoding-tag)
	("go-google-golang-org-protobuf-internal-detrand" ,go-google-golang-org-protobuf-internal-detrand)
	("go-google-golang-org-protobuf-internal-errors" ,go-google-golang-org-protobuf-internal-errors)
	("go-google-golang-org-protobuf-internal-fieldsort" ,go-google-golang-org-protobuf-internal-fieldsort)
	("go-google-golang-org-protobuf-internal-filedesc" ,go-google-golang-org-protobuf-internal-filedesc)
	("go-google-golang-org-protobuf-internal-filetype" ,go-google-golang-org-protobuf-internal-filetype)
	("go-google-golang-org-protobuf-internal-flags" ,go-google-golang-org-protobuf-internal-flags)
	("go-google-golang-org-protobuf-internal-genid" ,go-google-golang-org-protobuf-internal-genid)
	("go-google-golang-org-protobuf-internal-descfmt" ,go-google-golang-org-protobuf-internal-descfmt)
	("go-google-golang-org-protobuf-internal-descopts" ,go-google-golang-org-protobuf-internal-descopts)
	("go-google-golang-org-protobuf-internal-impl" ,go-google-golang-org-protobuf-internal-impl)
	("go-google-golang-org-protobuf-internal-mapsort" ,go-google-golang-org-protobuf-internal-mapsort)
	("go-google-golang-org-protobuf-internal-pragma" ,go-google-golang-org-protobuf-internal-pragma)
	("go-google-golang-org-protobuf-internal-set" ,go-google-golang-org-protobuf-internal-set)
	("go-google-golang-org-protobuf-internal-strs" ,go-google-golang-org-protobuf-internal-strs)
	("go-google-golang-org-protobuf-internal-version" ,go-google-golang-org-protobuf-internal-version)))
    (home-page "https://github.com/grpc/grpc-go")
    (synopsis "The Go language implementation of gRPC. HTTP/2 based RPC")
    (description "The Go implementation of gRPC: A high performance, open source, general RPC framework that puts mobile and HTTP/2 first")
    (license license:expat)))

(define-public protoc-gen-go-grpc-mock
  (package
    (name "protoc-gen-go-grpc-mock")
    (version "0.2.0")
    (source
      (origin
	(method git-fetch)
	(uri (git-reference
	       (url "https://github.com/nefixestrada/protoc-gen-go-grpc-mock")
	       (commit (string-append "v" version))))
	(sha256
	  (base32 "0dgsd9kplpqzdfd78gr0yssw0iriljb05rcwlkzdqpg44ksdxl4g"))))
    (build-system go-build-system)
    (arguments
      '(#:import-path "github.com/nefixestrada/protoc-gen-go-grpc-mock"))
    (native-inputs
      `(("go-google-golang-org-protobuf-compiler-protogen" ,go-google-golang-org-protobuf-compiler-protogen)
	("go-google-golang-org-protobuf-types-pluginpb" ,go-google-golang-org-protobuf-types-pluginpb)
	("go-google-golang-org-protobuf-types-descriptorpb" ,go-google-golang-org-protobuf-types-descriptorpb)
	("go-google-golang-org-protobuf-encoding-prototext" ,go-google-golang-org-protobuf-encoding-prototext)
	("go-google-golang-org-protobuf-encoding-protowire" ,go-google-golang-org-protobuf-encoding-protowire)
	("go-google-golang-org-protobuf-reflect-protodesc" ,go-google-golang-org-protobuf-reflect-protodesc)
	("go-google-golang-org-protobuf-reflect-protoreflect" ,go-google-golang-org-protobuf-reflect-protoreflect)
	("go-google-golang-org-protobuf-reflect-protoregistry" ,go-google-golang-org-protobuf-reflect-protoregistry)
	("go-google-golang-org-protobuf-runtime-protoiface" ,go-google-golang-org-protobuf-runtime-protoiface)
	("go-google-golang-org-protobuf-runtime-protoimpl" ,go-google-golang-org-protobuf-runtime-protoimpl)
	("go-google-golang-org-protobuf-proto" ,go-google-golang-org-protobuf-proto)
	("go-google-golang-org-protobuf-internal-encoding-defval" ,go-google-golang-org-protobuf-internal-encoding-defval)
	("go-google-golang-org-protobuf-internal-encoding-messageset" ,go-google-golang-org-protobuf-internal-encoding-messageset)
	("go-google-golang-org-protobuf-internal-encoding-text" ,go-google-golang-org-protobuf-internal-encoding-text)
	("go-google-golang-org-protobuf-internal-encoding-tag" ,go-google-golang-org-protobuf-internal-encoding-tag)
	("go-google-golang-org-protobuf-internal-detrand" ,go-google-golang-org-protobuf-internal-detrand)
	("go-google-golang-org-protobuf-internal-errors" ,go-google-golang-org-protobuf-internal-errors)
	("go-google-golang-org-protobuf-internal-fieldsort" ,go-google-golang-org-protobuf-internal-fieldsort)
	("go-google-golang-org-protobuf-internal-filedesc" ,go-google-golang-org-protobuf-internal-filedesc)
	("go-google-golang-org-protobuf-internal-filetype" ,go-google-golang-org-protobuf-internal-filetype)
	("go-google-golang-org-protobuf-internal-flags" ,go-google-golang-org-protobuf-internal-flags)
	("go-google-golang-org-protobuf-internal-genid" ,go-google-golang-org-protobuf-internal-genid)
	("go-google-golang-org-protobuf-internal-descfmt" ,go-google-golang-org-protobuf-internal-descfmt)
	("go-google-golang-org-protobuf-internal-descopts" ,go-google-golang-org-protobuf-internal-descopts)
	("go-google-golang-org-protobuf-internal-impl" ,go-google-golang-org-protobuf-internal-impl)
	("go-google-golang-org-protobuf-internal-mapsort" ,go-google-golang-org-protobuf-internal-mapsort)
	("go-google-golang-org-protobuf-internal-pragma" ,go-google-golang-org-protobuf-internal-pragma)
	("go-google-golang-org-protobuf-internal-set" ,go-google-golang-org-protobuf-internal-set)
	("go-google-golang-org-protobuf-internal-strs" ,go-google-golang-org-protobuf-internal-strs)
	("go-google-golang-org-protobuf-internal-version" ,go-google-golang-org-protobuf-internal-version)))
    (home-page "https://github.com/nefixestrada/protoc-gen-go-grpc-mock")
    (synopsis "protoc-gen-go-grpc-mock is a protobuf plugin that autogenerates gRPC mocks in Go")
    (description "protoc-gen-go-grpc-mock is a protobuf plugin that autogenerates gRPC services mocks in Go using the github.com/stretchr/testify/mock package")
    (license license:expat)))

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
			  (service postgresql-service-type
				   (postgresql-configuration
				     (postgresql postgresql-11)))
			  (service redis-service-type))
		    %base-services))
  (packages (append 
	      (map specification->package
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
			   "graphviz"

			   ;; Used for compiling the gRPC transport
			   "protobuf@3.14"
			   ;; Used for the hyper microservice
			   "pkg-config"
			   "libvirt"))

		    (list protoc-gen-go
			  protoc-gen-go-grpc
			  protoc-gen-go-grpc-mock)
		    %base-packages))
  (skeletons
    `((".bash_profile" ,(plain-file "bash_profile" "\
 # Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi\n"))
      (".bashrc" ,(plain-file "bashrc" "\
  # Bash initialization for interactive non-login shells and
  # for remote shells (info \"(bash) Bash Startup Files\").

  if [ \"$USER\" == \"root\" ]; then
        su - dev ; exit
  fi

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
      PS1='\\e[1;36m\\u@\\h \\w\\$ \\e[m'
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
  export PATH=$PATH:~/.nix-profile/bin:~/go/bin
  [ -f /data/dev/.env ] && export $(grep -v '^#' /data/dev/.env | xargs)

  if [ -e /data/$(whoami)/.config ]; then
    if [ ! -e ~/.config ]; then
      ln -s /data/$(whoami)/.config ~/.config
    fi 
  fi

  if [ ! -f ~/.config/.isard-dev-configured ]; then
    sudo chown -R $(whoami):users /data/dev

    mkdir -p /data/$(whoami)/.config/VSCodium/User
    ln -s /data/$(whoami)/.config ~/.config
    touch /data/$(whoami)/.nix-channels
    ln -s /data/$(whoami)/.nix-channels ~/.nix-channels
    mkdir /data/dev/workspace

    for dir in .cache .local .vscode-oss go; do
      mkdir -p /data/$(whoami)/$dir
      ln -s /data/$(whoami)/$dir ~/$dir
    done

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
	
	go get -v golang.org/x/tools/gopls
	go get -v golang.org/x/tools/cmd/stringer

	mkdir -p ~/.local/share
	ln -s /run/current-system/profile/share/fonts ~/.local/share/fonts

	echo \"[user]
	name = ${GITLAB_NAME}
	email = ${GITLAB_EMAIL}\" > ${HOME}/.gitconfig

	cd /data/dev/workspace

	for repo in isardvdi isardvdi-dev; do
        if [ ! -d ${repo}/.git ]; then
            git clone https://gitlab.com/${GITLAB_USER}/${repo}
            cd ${repo}

            git config url.\"https://${GITLAB_USER}@gitlab.com\".InsteadOf \"https://gitlab.com\"
            git remote add upstream https://gitlab.com/isard/${repo}

            git flow init -d

            [ -f go.mod ] && go mod tidy

            cd -
        fi
	done

	touch ~/.config/.isard-dev-configured
  else
    for dir in .cache .local .nix-channels .vscode-oss go; do
      if [ ! -e ~/$dir ]; then
        ln -s /data/$(whoami)/$dir ~/$dir
      fi 
    done

    if [ ! -e ~/.nix-profile ]; then
	ln -s /nix/var/nix/profiles/per-user/$(whoami)/profile ~/.nix-profile
    fi 

    cd /data/dev/workspace
  fi
  \n")))))
