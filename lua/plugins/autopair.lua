return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },
    {
        "kylechui/nvim-surround",
        version = "*", 
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
            })
        end
    }
}
