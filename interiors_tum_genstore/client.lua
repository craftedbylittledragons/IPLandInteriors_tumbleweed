---------- Manual definitions ---  
local interiorsActive = false
local character_selected = false 

----------- turn on the bar ------
function EnableResouresYMAPS()            
    --[[ 
        --## Tumbleweed ##--
        RemoveImap(1296658155) -- New Austin -- Tumbleweed -- Sheriffs Office -- Bounty Board
 
    if Config.Unknow == true then
        RequestImap(_________________) -- Something relating to BizTemplate
    end     
    --]] 
end

function EnableResouresINTERIORS(x, y, z)     
    --[[
    local interior = GetInteriorAtCoords(x, y, z) 
    ActivateInteriorEntitySet(interior, "_________________")       
    if Config.Unknow == true then  
        ActivateInteriorEntitySet(interior, "_________________")         
    end   
   
	ActivateInteriorEntitySets(514, "Tumbleweed general store", {
		"_p_apple01x_dressing",
		"_p_apple01x_group",
		"_p_cigarettebox01x_dressing",
		"_p_cigarettebox01x_group",
		"_p_corn02x_dressing",
		"_p_corn02x_group",
		"_p_tin_pomade01x_dressing",
		"_p_tin_pomade01x_group",
		"_p_tin_soap01x_dressing",
		"_p_tin_soap01x_group",
		"_saltedmeats_dressing",
		"_s_canCorn01x_dressing",
		"_s_canCorn01x_group",
		"_s_canPeas01x_dressing",
		"_s_canPeas01x_group",
		"_s_canStrawberries01x_dressing",
		"_s_canStrawberries01x_group",
		"_s_coffeeTin01x_dressing",
		"_s_coffeeTin01x_group",
		"_s_gunOil01x_dressing",
		"_s_gunOil01x_group",
		"_s_inv_baitHerb01x_dressing",
		"_s_inv_baitherb01x_group",
		"_s_inv_baitMeat01x_dressing",
		"_s_inv_baitmeat01x_group",
		"_s_inv_gin01x_dressing",
		"_s_inv_gin01x_group",
		"_s_inv_tabacco01x_dressing",
		"_s_inv_tabacco01x_group",
		"_s_inv_whiskey01x_dressing",
		"_s_inv_whiskey01x_group",
		"_s_oatcakes01x_dressing",
		"_s_oatcakes01x_group",
		"_s_saltedbeef01x_group",
		"_s_saltedbeef02x_group"
	})    
    --]]
end

-- currently there are two hitching posts. 

----------- turn off the bar ------
function DisableResourcesYMAPS() 
    --[[
    RemoveImap(6666_________________17953) -- Something relating to BizTemplate  
    --]]  
end

function DisableResourcesINTERIORS(x, y, z)  
    --[[
    local interior = GetInteriorAtCoords(x, y, z)    
    DeactivateInteriorEntitySet(interior, "_________________")     
    DeactivateInteriorEntitySet(interior, "_________________")  
    --]]       
end    
 
 
-----------------------------------------------------
---remove all on resource stop---
-----------------------------------------------------
AddEventHandler('onResourceStop', function(resource) 
    if resource == GetCurrentResourceName() then     
        -- when resource stops disable them, admin is restarting the script
        DisableResourcesYMAPS() 
        DisableResourcesINTERIORS(Config.x, Config.y, Config.z)
    end
end)

-----------------------------------------------------
--- clear all on resource start ---
-----------------------------------------------------
AddEventHandler('onResourceStart', function(resource) 
    if resource == GetCurrentResourceName() then         
        Citizen.Wait(3000)
        -- interiors loads all of these, so we need to disable them 
        DisableResourcesYMAPS() 
        DisableResourcesINTERIORS(Config.x, Config.y, Config.z)
        Citizen.Wait(3000)        
        -- because the character is already logged in on resource "re"start
        character_selected = true
    end
end)
 

-----------------------------------------------------
-- Trigger when character is selected
-----------------------------------------------------
RegisterNetEvent("vorp:SelectedCharacter") -- NPC loads after selecting character
AddEventHandler("vorp:SelectedCharacter", function(charid) 
	character_selected = true
end)
  
-----------------------------------------------------
-- Main thread that controls the script
-----------------------------------------------------
Citizen.CreateThread(function()
    while character_selected == false do 
        Citizen.Wait(1000)
    end 
    if character_selected == true and interiorsActive == false then 
        --- cleanup any previous scripts loading content
        DisableResourcesYMAPS() 
        DisableResourcesINTERIORS(Config.x, Config.y, Config.z)

        -- basically run once after character has loadded in  
        EnableResouresYMAPS() 
        EnableResouresINTERIORS(Config.x, Config.y, Config.z)
        interiorsActive = true
        unlockDoors()  
    end
end)

 