" Startify

" Don't show [e] and [q] options
let g:startify_enable_special = 0

" Change directory when opening file using Startify
let g:startify_change_to_dir  = 1  " This is the default value

" Add bashrc and nvim config files
let g:startify_bookmarks = [
          \ {'c': '~/.zshrc'},
          \ {'a': '~/.oh-my-zsh/custom/aliases.zsh'},
          \ {'d': '~/work/ngworkers/lumberjack/'},
          \ {'n': '~/.config/nvim/'},
          \ {'m': '~/work/insurgrid/roost/'}
          \ ]

" Change list order
let g:startify_lists = [
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'files',     'header': ['   Recent Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]
