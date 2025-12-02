# Avante.nvim Multi-Provider Setup

Avante.nvim now supports **both Claude (Anthropic) and OpenAI**! Switch between them seamlessly.

---

## 🔑 API Key Setup

### Option 1: Scoped Keys (Recommended)

Set provider-specific keys that only Avante uses:

```bash
# Add to ~/.zshrc or ~/.bashrc

# Claude (Anthropic)
export AVANTE_ANTHROPIC_API_KEY="your-claude-api-key"

# OpenAI (GPT-4)
export AVANTE_OPENAI_API_KEY="your-openai-api-key"
```

### Option 2: Global Keys (Legacy)

Use keys shared across all applications:

```bash
# Claude
export ANTHROPIC_API_KEY="your-claude-api-key"

# OpenAI
export OPENAI_API_KEY="your-openai-api-key"
```

**After adding keys:**
```bash
source ~/.zshrc  # or ~/.bashrc
```

---

## 🔄 Switching Between Providers

### Method 1: Keybinding (Easiest)
```vim
<leader>as    " Switch provider (Claude ↔ OpenAI)
```

### Method 2: Command
```vim
:AvanteSwitchProvider
```

### Method 3: Change Default
Edit `lua/custom/plugins/avante.lua`:
```lua
provider = 'claude',  -- Change to 'openai'
```

---

## 🎯 Current Configuration

### Default Provider
**Claude (Sonnet 4)** - Best for:
- Code generation
- Deep reasoning
- Long context understanding

### Alternative Provider
**OpenAI (GPT-4o)** - Best for:
- Fast responses
- General tasks
- When you want variety

---

## 📋 Getting API Keys

### Claude (Anthropic)
1. Go to: https://console.anthropic.com/settings/keys
2. Create new key
3. Copy and set as `AVANTE_ANTHROPIC_API_KEY`

**Models available:**
- `claude-sonnet-4-20250514` (default - balanced)
- `claude-opus-4-20250514` (most capable)
- `claude-3-5-sonnet-20241022` (fast)

### OpenAI
1. Go to: https://platform.openai.com/api-keys
2. Create new key
3. Copy and set as `AVANTE_OPENAI_API_KEY`

**Models available:**
- `gpt-4o` (default - multimodal)
- `gpt-4-turbo` (faster)
- `gpt-4` (most capable)

---

## 🚀 Usage

### Basic Workflow

1. **Open Avante sidebar:**
   ```vim
   <leader>aa
   ```

2. **Ask a question:**
   - Type your prompt
   - Press `<CR>` to submit

3. **Edit code with AI:**
   - Visual select code: `V` + movement
   - Press `<leader>ae` (edit selection)
   - Describe changes
   - Apply diff: `a` or `A`

4. **Switch providers if needed:**
   ```vim
   <leader>as    " Claude ↔ OpenAI
   ```

---

## 💡 When to Use Which Provider

### Use Claude for:
- ✅ Complex code generation
- ✅ Architecture decisions
- ✅ Deep debugging
- ✅ Long context (100k+ tokens)
- ✅ Precise code modifications

### Use OpenAI for:
- ✅ Quick questions
- ✅ General programming help
- ✅ Faster responses
- ✅ When Claude is busy/rate-limited
- ✅ Image understanding (gpt-4o)

---

## 🔧 Advanced Configuration

### Change Models

Edit `lua/custom/plugins/avante.lua`:

```lua
providers = {
  claude = {
    model = 'claude-opus-4-20250514',  -- More powerful
  },
  openai = {
    model = 'gpt-4-turbo',  -- Faster
  },
}
```

### Adjust Temperature

```lua
extra_request_body = {
  temperature = 0.7,  -- 0 = deterministic, 1 = creative
}
```

### Change Max Tokens

```lua
extra_request_body = {
  max_tokens = 8000,  -- Longer responses
}
```

---

## 🆘 Troubleshooting

### "API key not found"
**Solution:** Set environment variable and restart terminal
```bash
export AVANTE_ANTHROPIC_API_KEY="your-key"
source ~/.zshrc
```

### "Rate limit exceeded"
**Solution:** Switch providers
```vim
<leader>as    " Switch to alternative provider
```

### "Invalid API key"
**Solution:** Check key is correct
```bash
echo $AVANTE_ANTHROPIC_API_KEY  # Should show your key
echo $AVANTE_OPENAI_API_KEY
```

### Provider not switching
**Solution:** Restart Neovim
```bash
:qa!
nvim
```

---

## 📊 Cost Comparison

### Claude Pricing
- Sonnet 4: $3/million input, $15/million output tokens
- Opus 4: $15/million input, $75/million output tokens
- Very cost-effective for code tasks

### OpenAI Pricing
- GPT-4o: $2.50/million input, $10/million output tokens
- GPT-4 Turbo: $10/million input, $30/million output tokens
- Good for quick tasks

**Tip:** Use Claude as default, OpenAI as backup for rate limits.

---

## 🎊 All Keybindings

```vim
<leader>aa    " Toggle Avante sidebar
<leader>ar    " Refresh Avante
<leader>ae    " Edit selection with AI (visual mode)
<leader>ac    " Clear Avante
<leader>as    " Switch provider (Claude ↔ OpenAI)
```

**In Avante window:**
```vim
<CR>          " Submit prompt
<C-s>         " Submit prompt (insert mode)
a             " Apply suggestion to cursor
A             " Apply all suggestions
<Tab>         " Switch windows
```

---

## 🌟 Pro Tips

1. **Use both providers:**
   - Claude for complex tasks
   - OpenAI for quick questions

2. **Set scoped keys:**
   - Keeps Avante keys separate from other tools
   - Easier to manage

3. **Monitor usage:**
   - Check API dashboards regularly
   - Set spending limits

4. **Switch on rate limits:**
   - Hit Claude limit? `<leader>as` to OpenAI
   - Hit OpenAI limit? `<leader>as` to Claude

5. **Experiment with models:**
   - Try different models for different tasks
   - Adjust temperature for creativity

---

Enjoy your multi-provider AI coding experience! 🚀🤖
