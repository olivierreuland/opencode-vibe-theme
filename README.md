# OpenCode Vibe Theme

I use [Zed](https://zed.dev/), [Ghostty](https://ghostty.org/), [VS Code](https://code.visualstudio.com/), and [OpenCode](https://opencode.ai/). I like most of OpenCode's self-titled theme, but prefer a more tame background colour for example. So here is my vibe-coded-with-some-hand-crafted-adjustments answer. 

## Features

- Available in dark and light variants for Zed, Ghostty, VS Code, and OpenCode
- Dark background with carefully balanced contrast
- Vibrant accent colors that pop without eye strain
- Consistent color scheme across all applications
- Optimized for syntax highlighting with semantic color choices
- Support for multiple installation methods (global, user, per-project)

## Color Palette

The theme uses these key colors:

- **Primary Accent**: Warm peach (`#fab283`)
- **Keywords**: Soft purple (`#9d7cd8`)
- **Strings**: Mint green (`#7fd88f`)
- **Functions**: Warm peach (`#fab283`)
- **Types**: Golden yellow (`#e5c07b`)
- **Variables**: Soft red (`#e06c75`)
- **Operators**: Cyan (`#56b6c2`)
- **Numbers**: Orange (`#f5a742`)
- **Comments**: Gray (`#808080`)

See [docs/COLOR_PALETTE.md](docs/COLOR_PALETTE.md) for the complete color reference, including git diff colors, terminal ANSI colors, and all UI element mappings.

## Installation

### Quick Install (All Applications)

Use the automated installer to install themes for all supported applications:

```bash
./install.sh
```

Or force overwrite existing themes:

```bash
./install.sh --force
```

### Selective Installation

Install themes for specific applications only:

```bash
# Install only VS Code and Ghostty
./install.sh --only vscode,ghostty

# Install all except Zed
./install.sh --skip zed

# Force reinstall only OpenCode
./install.sh --only opencode --force
```

**Available applications:** `zed`, `ghostty`, `vscode` (or `vs-code`), `opencode`

### Manual Installation

If you prefer to install manually or need platform-specific instructions, see the individual sections below.

### Zed

#### Global Installation (Recommended)

1. Copy the theme file to Zed's themes directory:
   ```bash
   mkdir -p ~/.config/zed/themes
   cp themes/zed/opencode-vibe.json ~/.config/zed/themes/
   ```

2. Open Zed and select the theme:
   - Press `Cmd+K` then `Cmd+T` (or `Ctrl+K` then `Ctrl+T` on Linux/Windows)
   - Search for "OpenCode Vibe" or "OpenCode Vibe Light"
   - Select it to apply

Alternatively, you can manually set it in your Zed settings (`~/.config/zed/settings.json`):
```json
{
  "theme": "OpenCode Vibe"
}
```

Or for the light theme:
```json
{
  "theme": "OpenCode Vibe Light"
}
```

### Ghostty

#### Global/User Installation

1. Copy the theme files to Ghostty's themes directory:
   ```bash
   mkdir -p ~/.config/ghostty/themes
   cp themes/ghostty/opencode-vibe ~/.config/ghostty/themes/
   cp themes/ghostty/opencode-vibe-light ~/.config/ghostty/themes/
   ```

2. Edit your Ghostty config file (`~/.config/ghostty/config`) and add:
   
   For dark theme:
   ```
   theme = opencode-vibe
   ```
   
   Or for light theme:
   ```
   theme = opencode-vibe-light
   ```

3. Restart Ghostty or reload the configuration

**Note**: Ghostty uses a single global configuration, so themes apply system-wide rather than per-project.

### VS Code

#### Via Marketplace (Coming Soon)

Once published, install directly from VS Code:
1. Open Extensions (Ctrl+Shift+X / Cmd+Shift+X)
2. Search for "OpenCode Vibe"
3. Click Install

#### Manual Installation

1. Copy the theme directory to VS Code extensions:
   ```bash
   # macOS/Linux
   cp -r themes/vscode ~/.vscode/extensions/opencode-vibe-1.0.0
   
   # Windows
   xcopy /E /I themes\vscode %USERPROFILE%\.vscode\extensions\opencode-vibe-1.0.0
   ```

2. Reload VS Code (Ctrl+Shift+P / Cmd+Shift+P → "Developer: Reload Window")

3. Select the theme:
   - Press Ctrl+K Ctrl+T (or Cmd+K Cmd+T on macOS)
   - Search for "OpenCode Vibe" or "OpenCode Vibe Light"
   - Select it to apply

See [themes/vscode/README.md](themes/vscode/README.md) for detailed installation options and recommended settings.

### OpenCode

#### Global Installation

1. Copy the theme file to OpenCode's global themes directory:
   ```bash
   mkdir -p ~/.config/opencode/themes
   cp themes/opencode/opencode-vibe.json ~/.config/opencode/themes/
   ```

2. Edit your global OpenCode config (`~/.config/opencode/opencode.json`) and set:
   ```json
   {
     "theme": "opencode-vibe"
   }
   ```

#### Per-Project Installation

1. Create a themes directory in your project:
   ```bash
   mkdir -p .opencode/themes
   cp themes/opencode/opencode-vibe.json .opencode/themes/
   ```

2. Create or edit `.opencode/config.json` in your project root:
   ```json
   {
     "theme": "opencode-vibe"
   }
   ```

**Note**: Project-level settings override global settings when working in that project. OpenCode automatically switches between dark and light variants based on your system preferences.

## Recommended Fonts

I like Zed's font as well. `.ZedMono` is based on **IBM Plex Mono**, a typeface originally designed by IBM. I kept this font for Zed, but use **BlexMono Nerd Font**, which is IBM Plex Mono patched with [Nerd Fonts](https://www.nerdfonts.com/). This version includes thousands of additional glyphs and icons that are essential for modern terminal experiences, including:

- File type icons
- Git status indicators
- Powerline symbols
- Development tool icons

**Download:**
- **Nerd Fonts**: [Download BlexMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases) (look for `BlexMono.zip`)
- **Homebrew** (macOS): `brew install --cask font-blex-mono-nerd-font`

### IBM Plex Mono (Original)

If you prefer the original IBM Plex Mono without additional icons:

- **Official Repository**: [IBM/plex on GitHub](https://github.com/IBM/plex/releases)
- **Google Fonts**: [IBM Plex Mono](https://fonts.google.com/specimen/IBM+Plex+Mono)
- **Homebrew** (macOS): `brew install --cask font-ibm-plex-mono`

### Font Features

IBM Plex Mono and BlexMono Nerd Font support several OpenType features that enhance the coding experience:

| Feature | Description |
|---------|-------------|
| `calt` | Contextual alternates - improves character spacing in context |
| `onum` | Old-style numerals - more organic number appearance |
| `ss01`-`ss09` | Stylistic sets - alternative character designs |

#### Example Configuration (Ghostty)

Here's a complete Ghostty configuration combining the OpenCode Vibe theme with recommended font settings:

```
theme = opencode-vibe

# Font configuration
font-family = BlexMono Nerd Font
font-size = 14

# Font features for enhanced rendering
font-feature = calt
font-feature = onum
font-feature = ss01
font-feature = ss02
font-feature = ss03
font-feature = ss04
font-feature = ss05
font-feature = ss06
font-feature = ss07
font-feature = ss08
font-feature = ss09
```

#### Example Configuration (Zed)

For Zed, add this to your `settings.json`:

```json
{
  "theme": "OpenCode Vibe",
  "buffer_font_family": "BlexMono Nerd Font",
  "buffer_font_size": 14,
  "buffer_font_features": {
    "calt": true,
    "onum": true,
    "ss01": true,
    "ss02": true,
    "ss03": true,
    "ss04": true,
    "ss05": true,
    "ss06": true,
    "ss07": true,
    "ss08": true,
    "ss09": true
  }
}
```

### Alternative Fonts

While IBM Plex Mono / BlexMono Nerd Font is my top recommendation, these alternatives also work beautifully with OpenCode Vibe:

| Font | Best For | Download |
|------|----------|----------|
| **JetBrains Mono** | Excellent ligatures, great for code | [jetbrains.com/mono](https://www.jetbrains.com/lp/mono/) |
| **Fira Code** | Popular ligature support | [github.com/tonsky/FiraCode](https://github.com/tonsky/FiraCode) |
| **Cascadia Code** | Microsoft's coding font with ligatures | [github.com/microsoft/cascadia-code](https://github.com/microsoft/cascadia-code) |
| **Iosevka** | Highly customizable, narrow variant available | [github.com/be5invis/Iosevka](https://github.com/be5invis/Iosevka) |
| **MonoLisa** | Premium option with unique character design | [monolisa.dev](https://www.monolisa.dev/) (paid) |

**Note**: Most of these fonts are also available as Nerd Font variants with icon support.

## Screenshots

Coming soon! Add screenshots to the `screenshots/` directory to see the theme in action.

## Contributing

We welcome contributions! Whether you want to:
- Report a bug or issue with the theme
- Suggest color improvements
- Add support for additional editors or tools
- Improve documentation

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This theme is released under the MIT License. See [LICENSE](LICENSE) for details.

You are free to use, modify, and distribute this theme for any purpose, including commercial projects.

## Credits

Created by [Olivier Reuland](https://github.com/olivierreuland)

Inspired by modern editor themes and designed for developers who appreciate vibrant yet comfortable color schemes.
