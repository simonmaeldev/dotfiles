-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { "catppuccin/nvim", as = "catppuccin" }

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  use({'neovim/nvim-lspconfig'})
  use({'hrsh7th/nvim-cmp'})
  use({'hrsh7th/cmp-nvim-lsp'})
  use({'williamboman/mason.nvim'})
  use {
    "nvimtools/none-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "nvimtools/none-ls-extras.nvim",
      "jayp0521/mason-null-ls.nvim", -- ensure dependencies are installed
    }
  }

  -- to run tests
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- adapters here
      "nvim-neotest/neotest-python"
    }
  }

  -- to debug
  use {
    'mfussenegger/nvim-dap',
    requires = {
        'rcarriga/nvim-dap-ui', -- Creates a beautiful debbuger UI
        'nvim-neotest/nvim-nio', -- Required dependency for nvim-dap-ui
        -- Install the debugs adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        -- Add the other debuggers here
        'mfussenegger/nvim-dap-python'
    }
  }

  -- to refactor
  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
    }
  }

  print("packer complete")
end)
