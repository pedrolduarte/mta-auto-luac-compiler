--[[
    --» sᴄʀɪᴘᴛ ғᴇɪᴛᴏ ᴘᴏʀ » Pedro Developer
--]]

outputDebugString("[PEDRO DEVELOPER] RESOURCE "..getResourceName(getThisResource()).." ATIVADA COM SUCESSO", 4, 204, 82, 82);

local compileEnabled = 1;
local debugLevel = 0;
local obfuscateLevel = 3;
local postData = true;

addCommandHandler(config.command,
    function(player, cmd)
        if (isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup(config.acl))) then
	        local fetchURL = string.format("https://luac.mtasa.com/?compile=%i&debug=%i&obfuscate=%i", compileEnabled, debugLevel, obfuscateLevel)
            for _, resource in ipairs(getResources()) do
                local resourceName = getResourceName(resource)
                if not config.resourcesBlacklist[resourceName] then
                    local metaFile = xmlLoadFile(":"..resourceName.."/meta.xml")
                    if metaFile then
                        for _, node in ipairs(xmlNodeGetChildren(metaFile)) do
                            if xmlNodeGetName(node) == "script" then
                                local src = xmlNodeGetAttribute(node, "src")
                                local type = xmlNodeGetAttribute(node, "type") or "client"
                                if src and config.compileFiles[type] then
                                    if (string.sub(src, -4) == ".lua") then

                                        local filePath = ':'..resourceName..'/'..src;
                                        local luacPath = filePath..'c';
                                        if (fileExists(luacPath)) then
                                            fileDelete(luacPath);
                                            outputDebugString("[PEDRO DEVELOPER] O ARQUIVO "..luacPath.." FOI REMOVIDO PARA SER SUBSTITUÍDO", 4, 204, 82, 82);
                                        end

                                        -- fileCreate(luacPath);
                                        iprint(filePath)
                                        local scriptRaw = loadResourceScript(filePath);
                                        fetchRemote(fetchURL, onScriptCompile, scriptRaw, postData, luacPath);

                                        local newSrc = src .. "c"
                                        xmlNodeSetAttribute(node, "src", newSrc);
                                        xmlSaveFile(metaFile);
                                        outputDebugString("[PEDRO DEVELOPER] META DO RECURSO "..resourceName.." ATUALIZADO PARA USAR '"..newSrc.."'", 4, 204, 82, 82);
                                    end
                                end
                            end
                        end
                        xmlUnloadFile(metaFile)
                    end
                end
            end
        end
    end
);


local apiCodes = {
	["ERROR Nothing to do - Please select compile and/or obfuscate"] = true,
	["ERROR Could not compile file"] = true,
	["ERROR Could not read file"] = true,
	["ERROR Already compiled"] = true,
	["ERROR Already encrypted"] = true,
}

function loadResourceScript(pPath)
	local scriptExists = fileExists(pPath)

	if not scriptExists then
		outputDebugString("[LUAC]: '"..pPath.."' doesn't exists.", 4, 255, 127, 0)

		return false
	end

	local scriptHandler = fileOpen(pPath)

	if not scriptHandler then
		outputDebugString("[LUAC]: '"..pPath.."' failed to open.", 4, 255, 127, 0)

		return false
	end

	local scriptSize = fileGetSize(scriptHandler)
	local scriptRaw = fileRead(scriptHandler, scriptSize)

	fileClose(scriptHandler)

	return scriptRaw
end

function onScriptCompile(pCompiledLUA, pErrors, pScript)
	local compileSuccess = pErrors == 0

	if not compileSuccess then
		outputDebugString("[LUAC]: '"..pScript.."' failed to compile.", 4, 255, 127, 0)

		return false
	end

	local compileError = apiCodes[pCompiledLUA]

	if compileError then
		outputDebugString("[LUAC]: '"..pScript.."' failed to compile - "..pCompiledLUA, 4, 255, 127, 0)

		return false
	end

	local compiledScript = fileCreate(pScript)
	if not compiledScript then
		outputDebugString("[LUAC]: '"..pScript.."' failed to create.", 4, 255, 127, 0)

		return false
	end

	fileWrite(compiledScript, pCompiledLUA)
	fileClose(compiledScript)

	outputDebugString("[LUAC]: '"..pScript.."' compiled successfully.", 4, 255, 127, 0)

	return true
end