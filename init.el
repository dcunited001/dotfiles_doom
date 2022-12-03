;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

(doom! :input
       ;;chinese
       ;;japanese
       ;;layout            ; auie,ctsrnm is the superior home row

       :completion (company +childframe)
 
       ;; helm              ; the *other* search engine for love and life
       ;; ido               ; the other *other* search engine...
       (ivy +prescient +icons -childframe -fuzzy)
       ;; vertico           ; the search engine of the future

       :ui doom doom-dashboard doom-quit
       hydra
       (emoji +unicode) unicode nav-flash
       hl-todo
       ;; vc-gutter
       ;; deft              ; notational velocity for Emacs

       ;; NOTE: ligatures conflicts with prism.el
       ;; ligatures        ; ligatures and symbols to make your code pretty again
       ;; indent-guides     ; highlighted indent columns
       ;; minimap           ; show a map of the code on the side
       (modeline +light)

       ;; neotree           ; a project drawer, like NERDTree for vim
       ophints
       (popup +defaults)
       ;; tabs              ; a tab bar for Emacs
       ;; treemacs          ; a project drawer, like neotree but cooler


       ;; vi-tilde-fringe                  fringe tildes to mark beyond EOB
       window-select
       ;; workspaces       ; tab emulation, persistence & separate workspaces
       ;; zen               ; distraction-free coding or writing

       :editor
       ;; (evil +everywhere); come to the dark side, we have cookies
       file-templates
       ;; fold              ; (nigh) universal code folding
       (format +onsave)
       ;; god               ; run Emacs commands without modifier keys
       lispy
       multiple-cursors
       ;; (objed +manual)
                                        ; text object editing for the innocent
       ;; parinfer          ; turn lisp into python, sort of
       ;; rotate-text       ; cycle region at point between text candidates
       snippets
       ;; word-wrap         ; soft wrapping with language-aware indent

       :emacs
       (dired +icons)
       electric
       ;; ibuffer
       ;; undo
       (undo +tree)
       vc

       :term eshell vterm
       ;; shell
       ;; term              ; basic terminal emulator for Emacs

       :checkers
       (syntax +childframe)
       ;; (spell +flyspell) ; tasing you for misspelling mispelling
       ;; grammar           ; tasing grammar mistake every you make

       :tools
       ansible
       ;; biblio            ; Writes a PhD for you (citation needed)
       (debugger +lsp)
       direnv
       docker
       ;; editorconfig      ; let someone else argue about tabs vs spaces
       ;; ein               ; tame Jupyter notebooks with emacs
       (eval +overlay)
       ;; gist              ; interacting with github gists
       (lookup +docsets)
       (lsp +peek)
       (magit +forge)
       make
       ;; pass              ; password manager for nerds
       pdf                              ;; pdf enhancements
       prodigy           ; FIXME managing external services & code builders
       rgb                              ; creating color strings

       ;; TODO what is taskrunner?
       taskrunner        ; taskrunner for all your projects
       ;;terraform         ; infrastructure as code
       ;;tmux              ; an API for interacting with tmux
       ;;upload            ; map local to remote projects via ssh/ftp

       :os
       (:if IS-MAC macos)               ; improve compatibility with macOS
       tty                              ; improve the terminal Emacs experience

       :lang
       ;;agda              ; types of types of types of types...
       ;;beancount         ; mind the GAAP
       (cc +lsp)                        ; C > C++ == 1
       (clojure +lsp)
       common-lisp       ; if you've seen one lisp, you've seen them all
       ;;coq               ; proofs-as-programs
       ;;crystal           ; ruby at the speed of c
       ;;csharp            ; unity, .NET, and mono shenanigans
       data                     ; config/data formats
       ;;(dart +flutter)   ; paint ui and not much else
       ;;dhall
       ;;elixir            ; erlang done right
       ;;elm               ; care for a cup of TEA?
       emacs-lisp                       ; drown in parentheses
       ;;erlang            ; an elegant language for a more civilized age
       ;;ess               ; emacs speaks statistics
       ;;factor
       ;;faust             ; dsp, but you get to keep your soul
       ;;fsharp            ; ML stands for Microsoft's Language
       ;;fstar             ; (dependent) types and (monadic) effects and Z3
       ;;gdscript          ; the language you waited for
       ;;(go +lsp)         ; the hipster dialect
       (haskell +lsp)                   ; a language that's lazier than I am
       ;;hy                ; readability of scheme w/ speed of python
       ;;idris             ; a language you can depend on
       json    ; At least it ain't XML
       ;;(java +meghanada) ; the poster child for carpal tunnel syndrome
       javascript           ; all(hope(abandon(ye(who(enter(here))))))
       (julia +lsp)         ; a better, faster MATLAB
       ;;kotlin            ; a better, slicker Java(Script)
       (latex +cdlatex +fold)    ; writing papers in Emacs has never been so fun
       ;;lean              ; for folks with too much to prove
       ;;ledger            ; be audit you can be
       lua               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
       ;;nim               ; python + lisp at the speed of c
       ;;nix               ; I hereby declare "nix geht mehr!"
       ;;ocaml             ; an objective camel
       (org +pomodoro +present +gnuplot +pandoc +dragndrop +noter +roam2)

       ;; TODO decide on +jupyter
       ;; TODO try removing +pretty

       ;;php               ; perl's insecure younger brother
       plantuml
       ;;purescript        ; javascript, but functional
       (python +poetry)
       qt               ; the 'cutest' gui framework ever
       ;;racket            ; a DSL for DSLs
       ;;raku              ; the artist formerly known as perl6
       rest                             ; Emacs as a REST client
       ;;rst               ; ReST in peace
       ;;(ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       ;;rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;scala             ; java, but good

       ;; NOTE: depend on emacs-geiser/guile and emacs-guix instead
       ;; (scheme +guile)
                                        ; a fully conniving family of lisps
       sh     ; she sells {ba,z,fi}sh shells on the C xor
       ;;sml
       ;;solidity          ; do you need a blockchain? No.
       ;;swift             ; who asked for emoji variables?
       ;;terra             ; Earth and Moon in alignment for performance.
       web                              ; the tubes
       yaml                             ; JSON, but readable
       ;;zig               ; C, but simpler

       :email
       ;;(mu4e +org +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       ;;calendar
       ;;emms
       ;;everywhere        ; *leave* Emacs!? You must be joking
       ;;irc               ; how neckbeards socialize
       (rss +org)        ; emacs as an RSS reader
       ;;twitter           ; twitter client https://twitter.com/vnought

       :config
       literate
         
       ;; TODO reactivate if it doesn't interfere with lispy
       ;;(default +bindings +smartparens)
       (default +bindings))
