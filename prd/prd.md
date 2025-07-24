# Product Requirements Document: Marko.nvim

## Purpose
Marko.nvim aims to make navigating and managing Vim marks easy through a modern popup interface.

## Goals
- Display a list of marks in a floating window
- Preview the line contents at each mark
- Allow quick navigation and deletion of marks
- Support both buffer-local and global marks
- Provide optional virtual text indicators in files
- Expose configuration options for appearance and keymaps

## Non-Goals
- Managing remote marks across different machines
- Replacing Vim's built-in mark system

## Requirements
1. Neovim 0.8 or newer
2. Pure Lua implementation
3. Popup must respond to window resize events
4. Virtual marks refresh automatically as files change

## Nice to Have
- Icons customizable per user
- Integration with color schemes

