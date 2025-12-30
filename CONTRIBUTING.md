# Contributing to OpenCode Vibe Theme

Thank you for your interest in contributing to OpenCode Vibe! We welcome contributions of all kinds.

## Ways to Contribute

### Report Issues
- Found a color that's hard to read? Let us know!
- Notice inconsistencies between editors? File an issue!
- Have suggestions for improvement? We'd love to hear them!

### Suggest Improvements
- Color palette adjustments
- Better contrast ratios
- New semantic highlighting rules
- Documentation improvements

### Add Support for New Tools
Want to port this theme to another editor or terminal? That's awesome! Please:
1. Follow the existing color palette (see [docs/COLOR_PALETTE.md](docs/COLOR_PALETTE.md))
2. Test thoroughly in the target application
3. Include installation instructions in your PR
4. Add screenshots showing the theme in action

### Improve Documentation
- Fix typos or unclear instructions
- Add examples or tips
- Translate documentation
- Add screenshots

## Contribution Process

1. **Fork the repository** on GitHub

2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/opencode-vibe-theme.git
   cd opencode-vibe-theme
   ```

3. **Create a branch** for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bugfix-name
   ```

4. **Make your changes**:
    - For color changes, update all theme files (Zed, Ghostty, OpenCode) to maintain consistency
    - Test your changes in the respective applications
    - Update documentation if needed

5. **Commit your changes** with clear, descriptive messages:
   ```bash
   git add .
   git commit -m "Add: brief description of changes"
   ```

6. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Open a Pull Request** on GitHub:
   - Describe what you changed and why
   - Include screenshots if you changed colors
   - Reference any related issues

## Guidelines

### Color Changes
- Maintain consistency across all applications (Zed, Ghostty, OpenCode)
- Ensure adequate contrast ratios for accessibility (WCAG AA minimum)
- Test with multiple programming languages
- Consider both light and dark backgrounds when relevant

### Code Style
- Keep JSON files properly formatted with 2-space indentation
- Use consistent naming conventions
- Add comments where helpful (especially in Ghostty theme files)

### Testing Your Changes

Before submitting:

1. **Zed**: Install locally and test with multiple file types (JS/TS, Python, Rust, etc.)
2. **Ghostty**: Apply the theme and verify all ANSI colors look correct
3. **OpenCode**: Test in both global and project-specific installations

### Validation

Use the provided validation tools:
```bash
# Validate JSON theme files
jq empty themes/opencode/opencode-vibe.json
jq empty themes/zed/opencode-vibe.json

# Validate install script
shellcheck install.sh
```

### Documentation
- Keep the README up to date
- Update COLOR_PALETTE.md if you change colors
- Include screenshots for visual changes

## Questions or Need Help?

- Open an issue with the `question` label
- Reach out to [@olivierreuland](https://github.com/olivierreuland)

## Code of Conduct

Be respectful, inclusive, and constructive. We're all here to make great tools together!

## License

By contributing to this project, you agree that your contributions will be licensed under the MIT License.
