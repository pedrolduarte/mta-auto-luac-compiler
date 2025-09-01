--[[ 
    Script feito por » Pedro Developer
    Sistema de compilação automático para arquivos.
]]

config = {
    compileFiles = { -- Tipos de arquivos que serão compilados
        ['client'] = true;
        ['shared'] = false;
        ['server'] = false;
    };

    resourcesBlacklist = { -- Recursos que não serão compilados
        ["compilacao_teste"] = true;
    };
};