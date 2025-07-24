# Running Tests

This repository uses [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) and Neovim's built in headless mode for testing.

Follow the steps below to run the tests.

1. **Install Neovim** (v0.9 or later). On Ubuntu you can install it via apt:
   ```bash
   sudo apt-get update
   sudo apt-get install -y neovim
   ```
2. **Clone plenary.nvim** inside the project (only required once):
   ```bash
   git clone https://github.com/nvim-lua/plenary.nvim
   ```
3. **Run the tests** using Neovim's headless mode:
   ```bash
   nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedDirectory tests"
   ```
   The command will execute all specs under the `tests` directory and print the results.

If everything is set up correctly you should see output indicating that all tests passed.
