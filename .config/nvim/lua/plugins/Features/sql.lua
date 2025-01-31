local identity = "dv8-identity-server.database.windows.net,1433;Initial Catalog=DV8Identity;Persist Security Info=False;User ID=dv8identityservice;Password=YF*_-qH2c?<&V{vPxzh]%J;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";
-- os.getenv 'IdentitySqlServerConnectionString'
local hall_data = os.getenv 'SQLServerConnectionString'
return {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod', lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.dbs = {
            { name = 'DV8_Identity', url = identity },
            { name = 'DV8_HallData', url = hall_data },
        }
    end,
}
