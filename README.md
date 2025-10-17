# Neovim Configuration

Personal Neovim configuration based on [LazyVim](https://github.com/LazyVim/LazyVim).

## Setup

This configuration uses LazyVim as a base. To use:

1. Clone this repository to `~/.config/nvim`
2. Start Neovim - plugins will install automatically
3. Refer to the [LazyVim documentation](https://lazyvim.github.io) for usage

## Customizations

### UI & Theme (`lua/plugins/ui.lua`)

- **GitHub Dark Theme**: High-contrast colorscheme with custom syntax highlighting
  - Functions: Bright yellow (`#FFE66D`)
  - Strings: Bright orange (`#FFA657`)
  - Numbers: Bright light green (`#7FFF00`)
  - Variables: Bright light blue (`#66D9EF`)
  - Keywords: Bright purple/magenta (`#FF6AC1`)
  - Types: Bright cyan/teal (`#00E8C6`)
  - Comments: Bright green (`#87D96B`)
- **No Animations**: Disabled all UI animations (Noice, Snacks, indent-blankline) for faster performance
- **Treesitter**: Extended language support (bash, c, lua, python, javascript, typescript, json, html, css, go, rust)

### Kotlin & Java Development (`lua/plugins/kotlin.lua`)

- **Kotlin Language Server**: Full LSP support with Spring Boot compatibility
  - Document highlight disabled to prevent crashes
  - Inlay hints disabled for stability
  - Debounced linting (250ms)
  - JVM target: Java 17
- **Java Support**: nvim-jdtls for enhanced Java/Spring Boot development
  - Eclipse workspace integration
  - Spring Boot annotation completions
  - Filtered error messages (Java warnings, SLF4J suppressed)
- **Formatting**: ktlint with format-on-save
- **Mason Integration**: Auto-installs kotlin-language-server, ktlint, jdtls
- **Spring Boot Snippets**: Quick annotations for @RestController, @Service, @GetMapping, etc.
- **Trouble Integration**: Better diagnostic display

### Performance Options (`lua/config/options.lua`)

- **Faster UI Response**:
  - `updatetime = 250`: Faster completion and diagnostics
  - `timeoutlen = 300`: Faster which-key popup
  - `ttimeoutlen = 10`: Faster key code delay
- **Smooth Scrolling Disabled**
- **LSP Log Level**: Set to "error" to reduce noise
- **Diagnostic Configuration**: Inline errors, rounded borders, source attribution

### Keymaps (`lua/config/keymaps.lua`)

- **Move Lines** (`Alt+j/k`): Modified to check buffer modifiability before moving lines (prevents errors in read-only buffers)

### Additional Plugins

- **Typr** (`lua/plugins/typr.lua`): Typing game for practice (`:Typr`, `:TyprStats`)

## Remotes

- **origin**: Personal backup at `git@github.com:0OZ/vim-v2.git`
- **upstream**: LazyVim starter for updates at `https://github.com/LazyVim/starter`

## Updating from LazyVim

To pull updates from LazyVim starter:

```bash
git fetch upstream
git merge upstream/main
```

## Dependencies

For full Kotlin/Spring Boot support, ensure you have:
- Java 17+ (configured via SDKMAN)
- kotlin-language-server (auto-installed via Mason)
- ktlint (auto-installed via Mason)
- jdtls (auto-installed via Mason)
