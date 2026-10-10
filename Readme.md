# La mia config Neovim

Config basata su [lazy.nvim](https://github.com/folke/lazy.nvim).

## Struttura

```
~/.config/nvim/
├── init.lua              # entry point, carica options/keybinds/lazy
├── stylua.toml           # regole di formattazione per file .lua
├── lazy-lock.json        # versioni bloccate dei plugin (generato da lazy)
└── lua/
    └── config/
        ├── options.lua   # opzioni base di vim
        ├── keybinds.lua  # keymap globali
        ├── lazy.lua      # bootstrap di lazy.nvim
        └── plugins/
            ├── colors.lua       # tema (tokyonight) + statusline (lualine)
            ├── completion.lua   # autocompletamento (nvim-cmp)
            ├── formatting.lua   # formattazione automatica (conform.nvim)
            ├── onliners.lua     # plugin minori (fugitive, highlight-colors, mason)
            ├── telescope.lua    # ricerca file/testo
            └── treesitter.lua   # syntax highlighting avanzato
```

## Opzioni (`options.lua`)

- `number`: mostra i numeri di riga
- `cursorline`: evidenzia la riga corrente
- `shiftwidth = 4`: indentazione a 4 colonne

## Keymap (`keybinds.lua`)

Leader = `<Space>`

| Tasto | Azione |
|---|---|
| `<leader>cd` | apre il file explorer nativo (netrw) nella cartella corrente |

Altri keymap sono definiti dentro i singoli file plugin:

**telescope.lua**
| Tasto | Azione |
|---|---|
| `<leader>ff` | cerca file |
| `<leader>fg` | cerca testo nel progetto (live grep) |
| `<leader>fb` | lista buffer aperti |
| `<leader>fh` | cerca nell'help di vim |

**completion.lua** (solo in insert mode)
| Tasto | Azione |
|---|---|
| `<CR>` | conferma suggerimento |
| `<C-e>` | chiudi menu completamento |
| `<C-Space>` | apri menu completamento |
| `<C-n>` / `<C-p>` | suggerimento succ./prec. |
| `<Tab>` / `<S-Tab>` | naviga suggerimenti |

## Plugin installati

- **tokyonight.nvim** — tema colori (con sfondo trasparente)
- **lualine.nvim** — statusline
- **nvim-cmp** (+ cmp-nvim-lsp, cmp-path, cmp-buffer) — autocompletamento
- **conform.nvim** — formattazione automatica al salvataggio
- **mason.nvim** — installazione tool esterni (formatter, LSP, linter)
- **telescope.nvim** — fuzzy finder
- **nvim-treesitter** — syntax highlighting/indent avanzato
- **vim-fugitive** — comandi Git
- **nvim-highlight-colors** — anteprima colori CSS/hex nel codice

## Formattazione (`formatting.lua`)

Formatter configurati per tipo di file:

| Filetype | Formatter | Installato tramite |
|---|---|---|
| lua | stylua | Mason |
| javascript / typescript / json | prettier | Mason |
| cs | csharpier | Mason (via NuGet) |
| markdown | mdformat | Mason |

Regole di stile per `stylua` in `stylua.toml`: spazi invece di tab, larghezza 4.

Formattazione automatica al salvataggio abilitata (`format_on_save`).

## Comandi utili

| Comando | Cosa fa |
|---|---|
| `:Lazy` | gestisci i plugin (install/update/sync) |
| `:Mason` | installa formatter/LSP/linter esterni |
| `:checkhealth conform` | verifica lo stato dei formatter |
| `:Ex` (o `<leader>cd`) | file explorer nativo |

## Cose da sistemare / TODO

- **Nessun language server configurato**: `cmp-nvim-lsp` è registrato come sorgente di completamento, ma senza un file che configura e avvia dei veri LSP (es. tramite `lspconfig` + `mason-lspconfig`), non arrivano suggerimenti "intelligenti" (definizioni, tipi, errori) — solo path/buffer. Da aggiungere un file tipo `lsp.lua`.
- **Manca il bridge Mason ↔ conform** (es. `mason-conform.nvim`): oggi i formatter vanno installati a mano da `:Mason`; con quel plugin, dichiarando un formatter in `formatting.lua` verrebbe scaricato automaticamente.
- In `onliners.lua` c'è un blocco di `mason.nvim` commentato e uno attivo subito sotto: da rimuovere quello commentato per pulizia.
