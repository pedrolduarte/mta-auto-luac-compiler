# PedroDeveloper Auto Compiler para MTA:SA

![PedroDeveloper](https://img.shields.io/badge/Feito%20por-Pedro%20Developer-204852?style=flat-square)

## 🚀 Sobre o sistema

Este recurso é um sistema de compilação automática de scripts Lua para servidores MTA:SA, desenvolvido para facilitar a proteção e otimização dos seus scripts. Ele percorre todos os recursos do servidor, compila os arquivos `.lua` conforme sua configuração e atualiza o `meta.xml` para utilizar os arquivos compilados, tudo de forma automática e segura.

## ✨ Funcionalidades

- Compilação automática de scripts `.lua` (client, server, shared)
- Atualização automática do `meta.xml` para usar os arquivos compilados
- Blacklist de recursos para não compilar
- Controle de acesso por ACL
- Integração com o serviço oficial de compilação da MTA:SA (`luac.mtasa.com`)
- Mensagens de debug detalhadas

## ⚙️ Configuração

A configuração é feita no arquivo `LDg.lua`:

```lua
config = {
    command = 'compilar', -- Comando para compilar os arquivos
    acl = 'Console',      -- ACL necessária para usar o comando
    compileFiles = {
        ['client'] = true,
        ['shared'] = false,
        ['server'] = false,
    },
    resourcesBlacklist = {
        ["compilacao_teste"] = true,
    },
}
```

- **command**: comando para executar a compilação no servidor
- **acl**: grupo ACL necessário para executar o comando
- **compileFiles**: tipos de scripts que serão compilados
- **resourcesBlacklist**: recursos que não serão compilados

## 🛠️ Como usar

1. Coloque o recurso na pasta de recursos do seu servidor.
2. Ajuste a configuração em `LDg.lua` conforme sua necessidade.
3. Inicie o recurso.
4. No servidor, use o comando configurado (ex: `/compilar`) com uma conta que tenha permissão ACL.
5. Os scripts serão compilados e os metas atualizados automaticamente!

## 💡 Observações

- O sistema não sobrescreve seus arquivos `.lua`, ele cria arquivos compilados com sufixo `c` (ex: `script.lua` → `script.luac`).
- O `meta.xml` de cada recurso é atualizado para usar o arquivo compilado.
- Recursos na blacklist não serão processados.

## 📂 Estrutura do recurso

```
LDg.lua
meta.xml
assets/
  main/
    LDs.lua
```

## 👨‍💻 Créditos

- Desenvolvido por **Pedro Developer**
- Sistema inspirado em boas práticas de proteção de scripts para MTA:SA

## 📜 Licença

Este projeto é gratuito para uso e modificação, desde que mantidos os créditos ao autor.

---

Se gostou, deixe seu feedback e compartilhe com outros desenvolvedores! 🚗💻
