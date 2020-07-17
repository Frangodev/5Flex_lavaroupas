-----------------------------------------------------------------------------------------------------------------------------------------
-- 5FLEX | NOSSO DISOCRD | https://discord.gg/K3FBEFy
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES | FUNÇÃO BASICA DO SCRIPT, AONDE O ITEM SE TRANSFORMA EM OUTRO ITEM E ASSIM POR DIANTE
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WEBHOOK ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local lavagemdedinheiro = ""
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNCTION WEBHOOK ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local perm = "lavagem.permissao"  -- | AQUI VOCÊ BOTA A PERMISSÃO DE QUEM VAI PODER LAVAR!
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('blip:lavagem')
AddEventHandler('blip:lavagem',function(LaV)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id,perm) then
        local menu = {name = "Lavagem"}
            menu["Dinheiro Sujo"] = {function(source,choice)
                        TriggerEvent('depositar:dinheirosujo',source,LaV)
                        vRP.closeMenu(source,verb)
            end}vRP.openMenu(source,menu) 
    end 
end)
-----------------------------------------------------------------------------------------------------------------------------------------
---------- FUNÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('depositar:dinheirosujo')
AddEventHandler('depositar:dinheirosujo',function(source,LaV)
    local user_id = vRP.getUserId(source)
        if user_id then
            local vdepostio = vRP.prompt(source,"Quanto deseja Lavar?","")
            local intDeposito = parseInt(vdepostio)
            if vdepostio then
                random = math.random(80,90)
                if vRP.tryGetInventoryItem(user_id,'dinheirosujo',vdepostio) then
                    vRP.giveInventoryItem(user_id,"money",vdepostio*("0."..random))
                    TriggerClientEvent('Notify',source,'sucesso','Você lavou R$'..vdepostio..", de dinheiro sujo!")
                    SendWebhookMessage(lavagemdedinheiro,"```prolog\n[ID]: "..user_id.." \n[LAVOU DE DINHEIRO SUJO]: "..vRP.format(parseInt(vdepostio)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                else
                    TriggerClientEvent('Notify',source,'negado','Você não tem dinheiro sujo suficiente!!')
                end
            end
        end
end)