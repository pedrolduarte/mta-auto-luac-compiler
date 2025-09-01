--[[ 
    Script feito por » Pedro Developer
    Sistema de compilação automático para arquivos.
]]

config = {

    command = 'compilar'; -- Comando para compilar os arquivos
    acl = 'Console'; -- ACL necessária para usar o comando

    compileFiles = { -- Tipos de arquivos que serão compilados
        ['client'] = true;
        ['shared'] = false;
        ['server'] = false;
    };

    resourcesBlacklist = { -- Recursos que não serão compilados
        ["compilacao_teste"] = true;
    };
};