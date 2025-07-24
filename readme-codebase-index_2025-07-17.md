# Codebase Index - marko.nvim (2025-07-17)

This document summarizes the structure and key components of the `marko.nvim` repository.
It was generated to provide quick reference for development without needing to inspect
all files individually.

## File Inventory

- `plugin/marko.lua` – Neovim plugin loader. Registers the `:Marko` command and sets a default keymap after reading user configuration. Depends on `lua/marko/init.lua` and `lua/marko/config.lua`.
- `lua/marko/init.lua` – Main module exposing setup and command functions. Initializes config, syntax, virtual mark features, and handles toggling/showing the marks popup. Relies on other modules in `lua/marko/`.
- `lua/marko/config.lua` – Handles configuration defaults and highlight groups. Provides `setup`, `get`, `get_namespace`, and `refresh_highlights` utilities.
- `lua/marko/icons.lua` – Defines icon set and helpers to pick icons and format lines for the popup.
- `lua/marko/marks.lua` – Collects buffer/global marks, deduplicates them, and implements deletion/goto functionality. Uses `config.lua` for settings.
- `lua/marko/popup.lua` – Builds the floating window interface listing marks, applies syntax highlighting, and binds navigation/deletion keymaps. Depends on `marks.lua`, `icons.lua`, and `config.lua`.
- `lua/marko/syntax.lua` – Defines syntax rules for the popup buffer and sets filetype autocommands.
- `lua/marko/virtual.lua` – Manages virtual text marks in buffers, including a timer-based refresh system and toggle functions.
- `README.md` – Documentation describing plugin features, installation, configuration, and usage.

No dedicated test files are present.

## Function/Method Catalog

- `config.setup(opts)` → nil. Merge user options with defaults and create highlight groups; uses `vim.api.nvim_set_hl`.
- `config.get()` → table. Returns current configuration.
- `config.get_namespace()` → integer namespace id.
- `config.refresh_highlights()` → nil. Reapplies highlight groups after theme changes.
- `icons.get_file_icon(filename)` → string icon based on file extension.
- `icons.get_mark_icon(mark_type)` → string icon for buffer/global mark.
- `icons.format_mark_line(mark, config)` → formatted string combining mark info and icons.
- `marks.get_buffer_marks()` → list<mark>. Retrieves marks in current buffer using `vim.fn.getmarklist`.
- `marks.get_all_buffer_marks()` → list<mark>. Collects marks from all loaded buffers.
- `marks.get_global_marks()` → list<mark>. Reads global marks from shada and loaded files.
- `marks.deduplicate_marks(marks)` → list<mark>. Removes duplicates preferring buffer marks over globals.
- `marks.debug_marks()` → nil. Prints diagnostic information about marks for debugging.
- `marks.get_all_marks()` → list<mark>. Returns sorted set of buffer and global marks.
- `marks.delete_mark(mark_info)` → nil. Deletes buffer or global mark via API calls or `:delmarks`.
- `marks.goto_mark(mark_info)` → nil. Opens file if needed and moves cursor to mark position.
- `popup.is_open()` → boolean. Checks if popup window exists.
- `popup.create_popup()` → nil. Creates floating window, populates lines, and sets keymaps.
- `popup.populate_buffer(marks)` → nil. Formats mark list into buffer and stores mark metadata for keymaps.
- `popup.apply_highlighting(marks, start)` → nil. Adds extmark-based highlights across popup lines.
- `popup.setup_keymaps()` → nil. Binds goto/delete/close actions within popup.
- `popup.close_popup()` → nil. Closes popup and shadow windows.
- `syntax.setup_syntax()` → nil. Defines syntax groups for popup buffer using `vim.cmd`.
- `syntax.setup_filetype()` → nil. Registers FileType autocmd to activate syntax and local options.
- `virtual.setup(opts)` → nil. Updates virtual text settings in state table.
- `virtual.refresh_buffer_marks(bufnr)` → nil. Clears existing virtual marks and adds extmarks for each mark.
- `virtual.toggle()` → nil. Enables or disables virtual marks and notifies user.
- `virtual.cleanup()` → nil. Stops timer and clears all virtual marks.
- `virtual.start_timer()` / `stop_timer()` – Manage loop timer to refresh visible buffers periodically.
- `virtual.setup_autocmds()` – Establishes BufEnter/BufDelete autocommands and starts timer.
- `init.setup(opts)` → nil. Entry point called by user to configure plugin, initialize subsystems, and set keymaps.
- `init.toggle_marks()` / `init.show_marks()` – Toggle or show the marks popup via `popup` module.
- `init.debug_marks()`, `init.refresh_highlights()`, `init.toggle_virtual_marks()`, `init.refresh_virtual_marks()` – wrappers delegating to respective modules.

## Data Structures & Classes

- **`default_config` (config.lua)** – Table containing UI dimensions, keymaps, highlight definitions, and virtual text settings.
  - Key subfields: `keymaps`, `virtual_text`, `columns`, `highlights`.
- **`config`** – Active configuration table derived from `default_config` after `setup` is called.
- **`state` (virtual.lua)** – Holds virtual marks namespace, buffers, timer object, and virtual text configuration options.
- **Mark object** – Each mark table contains `mark`, `line`, `col`, `text`, `filename?`, and `type` (`"buffer"` or `"global"`) as built in `marks.lua`.
- Popup module keeps `popup_buf`, `popup_win`, and `shadow_win` globals for managing windows.

## Project Architecture

- **Module Organization** – Lua modules live under `lua/marko/`; plugin loader resides in `plugin/marko.lua`. Each module focuses on a specific area: configuration, marks retrieval, popup UI, syntax, and virtual text management.
- **Entry Points** – When the plugin loads, `plugin/marko.lua` registers the `:Marko` command and default keymap. These invoke `init.show_marks` or `init.toggle_marks`, which create the popup via `popup.create_popup`.
- **Main Flow** – `init.setup` merges user config, sets highlights, activates virtual marks, and establishes autocommands. `popup.create_popup` fetches marks from `marks.lua`, formats them with `icons.lua`, highlights via `syntax.lua` rules, and binds actions. Optional virtual marks are maintained by `virtual.lua`, refreshed periodically.
- **External Dependencies** – Relies solely on Neovim’s Lua API (`vim.api`, `vim.fn`, `vim.loop`) for buffers, windows, marks, and timers. No third‑party Lua libraries are used.

