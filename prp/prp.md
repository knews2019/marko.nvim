# Product Requirements Prompt: Marko.nvim Development

This document guides contributors on how to implement features or changes for Marko.nvim.

## Workflow
1. Review `prd/prd.md` for the current goals and requirements.
2. Plan feature work in small, testable steps.
3. Update `prd/prd.md` and this file as requirements evolve.
4. Keep pull requests focused and reference relevant sections of the PRD.

## Coding Guidelines
- Use idiomatic Lua and Neovim APIs.
- Keep code modular within the `lua/marko` directory.
- Update the README when user-facing behavior changes.
- Add comments for complex logic.

## Testing
Currently the repository has no automated tests. Manual testing should verify:
- Marks display correctly in the popup.
- Key mappings work as configured.
- Virtual marks toggle on and off without errors.

