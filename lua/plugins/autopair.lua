return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
	version = false
    },
    {
        "kylechui/nvim-surround",
        version = false,  
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
            })
        end
    }
}
