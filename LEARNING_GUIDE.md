# Vim/Neovim Learning Guide

Your Neovim is now equipped with **learning-focused plugins** that will accelerate your Vim journey! This guide will help you master Vim efficiently.

---

## 🎯 Learning Philosophy

These plugins work together to teach you Vim the right way:
1. **Precognition** - Shows you what's possible
2. **Hardtime** - Prevents bad habits
3. **Flash** - Makes navigation intuitive
4. **Treesitter Textobjects** - Teaches code-aware editing

---

## 📚 The Plugins

### 1. Precognition - Your Motion Teacher

**What it does:** Shows ghost hints for available motions as you navigate.

**You'll see hints like:**
```
function calculateTotal(items) {
    ^   w      w    w    e     e
```

**Common hints you'll learn:**
- `w` = next word start
- `b` = previous word start
- `e` = end of word
- `^` = first non-blank character
- `$` = end of line
- `{` = previous paragraph
- `}` = next paragraph

**Keybindings:**
- `<leader>tp` - Toggle precognition on/off
- `<leader>pp` - Peek at available motions

**Learning tip:** Don't ignore the hints! When you see a hint, try using that motion.

---

### 2. Hardtime - Break Bad Habits

**What it does:** Gently reminds you to use better motions instead of repeating `hjkl`.

**How it works:**
- Press `jjjjj` → Get hint: "Use } or 5j instead"
- Press `llllll` → Get hint: "Use w or 6l instead"
- After 4 repetitions, you'll see suggestions

**Configuration:**
- **Currently set to:** Hint mode (gentle)
- **Max repetitions:** 4 (beginner-friendly)
- **Does NOT block** - just reminds you

**Keybindings:**
- `<leader>th` - Toggle hardtime on/off
- `<leader>hr` - View hardtime report (see your patterns)

**Learning tip:** Read the hints! They tell you exactly what motion to use instead.

---

### 3. Flash - Enhanced Navigation

**What it does:** Jump anywhere on screen with 2-3 keystrokes using labeled jumps.

#### Basic Usage

**Jump to any location:**
1. Press `s`
2. Type 2 characters (e.g., `fu` for "function")
3. Labels appear: `a`, `b`, `c`, etc.
4. Press the label letter to jump there

**Example:**
```
Before:
function calculateTotal(items) {
    const total = items.reduce()
}

Type: s + fu
Shows:
a
function calculateTotal(items) {
    const total = items.reduce()
}

Press: a
Cursor jumps to "function"!
```

#### Keybindings

**Navigation:**
- `s` - Flash jump (2 chars + label)
- `S` - Treesitter jump (select function/class)
- `r` - Remote flash (use with operators like `d`, `c`)

**In search:**
- `/search<CR>` then `<C-s>` - Toggle flash in search results

**With operators:**
- `dsfu` - Delete from cursor to "fu" match
- `csfu` - Change from cursor to "fu" match
- `ysfu` - Yank from cursor to "fu" match

**Learning tip:** Use `s` instead of counting (`5w`) or searching (`/term`). It's faster once you get used to it!

---

### 4. Treesitter Textobjects - Code-Aware Editing

**What it does:** Adds code structure text objects (functions, classes, parameters).

#### Text Object Selections

**Functions:**
- `vaf` - Select entire function (including definition)
- `vif` - Select inside function (body only)
- `daf` - Delete entire function
- `yif` - Yank function body
- `cif` - Change function body

**Classes:**
- `vac` - Select entire class
- `vic` - Select inside class

**Parameters/Arguments:**
- `via` - Select inside parameter
- `vaa` - Select parameter including comma
- `cia` - Change parameter
- `daa` - Delete parameter

**Conditionals (if/else):**
- `vii` - Select inside if block
- `vai` - Select entire if statement

**Loops:**
- `vil` - Select inside loop
- `val` - Select entire loop

**Comments:**
- `va/` - Select comment

#### Navigation

**Jump to next/previous:**
- `]f` / `[f` - Next/Previous function
- `]c` / `[c` - Next/Previous class
- `]a` / `[a` - Next/Previous parameter
- `]i` / `[i` - Next/Previous conditional
- `]l` / `[l` - Next/Previous loop

**Jump to end:**
- `]F` - Next function end
- `[F` - Previous function end

#### Parameter Swapping

- `<leader>sn` - Swap parameter with next
- `<leader>sp` - Swap parameter with previous

**Example:**
```javascript
function foo(first, second, third) {
    //              ^^^^^^
    // Cursor here, press <leader>sn
}

// Becomes:
function foo(first, third, second) {
}
```

#### Incremental Selection

- `<C-space>` - Start/expand selection
- `<C-s>` - Expand to scope
- `<C-backspace>` - Shrink selection

**Learning tip:** These become second nature after a week. Start with `vif`, `daf`, `]f`, `[f`.

---

## 🚀 Learning Path (Week-by-Week)

### Week 1: Basic Motions
**Focus:** Learn to use `w`, `b`, `e`, `{`, `}`

**Practice:**
1. Watch Precognition hints - try every motion you see
2. Let Hardtime remind you when you use `hjkl` too much
3. Don't disable anything yet!

**Goals:**
- Stop using arrow keys
- Use `w` instead of `lllll`
- Use `{`/`}` instead of `jjjjj`

### Week 2: Flash Navigation
**Focus:** Master Flash for quick jumps

**Practice:**
1. Use `s` + 2 chars to jump around
2. Try `S` to select functions/classes
3. Use Flash with operators: `dsfu` (delete to "fu")

**Goals:**
- Jump to any visible text in 3 keystrokes
- Stop using `/search` for short jumps

### Week 3: Text Objects
**Focus:** Learn function/class operations

**Practice:**
1. Use `vif` to select function body
2. Use `daf` to delete entire functions
3. Navigate with `]f` and `[f`

**Goals:**
- Think in code structures, not lines
- Delete/change functions without counting lines

### Week 4: Advanced Combinations
**Focus:** Combine everything

**Practice:**
1. `s` + label + `vif` - Jump and select function
2. `]f` then `daf` - Jump to next function and delete it
3. `via` + `cia` - Select and change parameters

**Goals:**
- Edit code at the speed of thought
- Rarely use `hjkl` anymore

---

## 💡 Quick Reference Card

### Essential Motions (Learn These First)
```
w   - Next word start          ]f  - Next function
b   - Previous word start      [f  - Previous function
e   - End of word              vif - Select in function
{   - Previous paragraph       daf - Delete function
}   - Next paragraph           s   - Flash jump
^   - Line start (non-blank)   S   - Treesitter select
$   - Line end
```

### Practice Exercises

**Exercise 1: Navigation**
```javascript
function calculateTotal(items) {
    const total = items.reduce((sum, item) => {
        return sum + item.price
    }, 0)
    return total
}

Tasks:
1. Jump to "reduce" using: sre<label>
2. Select entire function: vaf
3. Jump to next function: ]f
4. Go back: <C-o>
```

**Exercise 2: Editing**
```python
def calculate_total(items, tax, discount):
    total = sum(item.price for item in items)
    return total * (1 + tax) - discount

Tasks:
1. Change parameter "tax": /tax<CR> then ciw
2. Or use: [a then cia
3. Delete entire function: daf
4. Undo: u
```

**Exercise 3: Combining Tools**
```typescript
function processData(data: string[], options: Options) {
    const filtered = data.filter(item => item.length > 0)
    const mapped = filtered.map(item => item.toUpperCase())
    return mapped
}

Tasks:
1. Jump to "filter": sfi<label>
2. Select the entire filter call: va(
3. Jump to next function: ]f
4. Select and change function name: viwcnewName<Esc>
```

---

## 🎮 Daily Practice Routine

**5-Minute Warm-Up:**
1. Open any code file
2. Use ONLY these motions for 5 minutes:
   - `w`, `b`, `e` (no `l` or `h`)
   - `{`, `}` (no `j` or `k`)
   - `s` for jumps
3. Try one new textobject (`vif`, `daf`, etc.)

**Track Progress:**
- `:Hardtime report` - See how many times you used bad motions
- Goal: Reduce count each day

---

## 🔧 Customization

### If Hardtime Is Too Strict
```vim
" Disable temporarily
<leader>th

" Or edit: lua/custom/plugins/hardtime.lua
" Change: max_count = 6  (allow more repetitions)
```

### If Precognition Is Distracting
```vim
" Toggle off temporarily
<leader>tp

" Or edit: lua/custom/plugins/precognition.lua
" Change: startVisible = false
```

### Adjust Flash Colors
Flash labels are bright pink by default. To change:
```lua
-- Edit: lua/custom/plugins/flash.lua
-- Find: FlashLabel highlight
-- Change colors to your preference
```

---

## 📖 Resources

### Learn More
- `:help motion.txt` - All available motions
- `:help text-objects` - Text object documentation
- `:help flash.nvim` - Flash documentation
- `:Tutor` - Built-in Vim tutorial

### Practice Sites
- [Vim Adventures](https://vim-adventures.com/) - Game to learn Vim
- [OpenVim](https://www.openvim.com/) - Interactive tutorial
- [VimGolf](https://www.vimgolf.com/) - Vim challenges

---

## 🎯 Success Metrics

**You're getting good at Vim when:**
- ✅ You rarely use `hjkl` for navigation
- ✅ You use `s` + label instead of counting (`5w`)
- ✅ You think "delete this function" → `daf` (instant)
- ✅ You navigate between functions with `]f` / `[f`
- ✅ You can edit without looking at the keyboard
- ✅ Hardtime report shows <10 bad motions per session

---

## 🆘 Troubleshooting

**"Precognition hints are too distracting"**
- They'll become invisible once you learn the motions
- Toggle off: `<leader>tp`

**"Hardtime is frustrating me"**
- It's meant to be slightly frustrating - that's learning!
- Toggle off temporarily: `<leader>th`
- Check report: `<leader>hr` to see patterns

**"Flash labels are confusing"**
- Start with just `s` + 2 chars
- Practice on one file for 10 minutes
- It becomes muscle memory quickly

**"I don't know what motion to use"**
- Watch Precognition hints - they tell you!
- Start with: `w`, `b`, `{`, `}`, `s`
- Add one new motion per day

---

## 🎊 Congratulations!

You now have a world-class Vim learning environment. The plugins work together to:
1. Show you what's available (Precognition)
2. Prevent bad habits (Hardtime)
3. Make navigation intuitive (Flash)
4. Teach code-aware editing (Textobjects)

**Remember:** The first week will feel slow. By week 3, you'll be faster than you ever were with a mouse!

Happy Vimming! 🚀
