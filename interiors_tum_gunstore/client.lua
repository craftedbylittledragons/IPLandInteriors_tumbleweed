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
	ActivateInteriorEntitySets(11778, "Tumbleweed gun store", {
		"tum_gunsmith_int_rentSign",
		"_s_inv_arrowammo01x_dressing",
		"_s_inv_highvlcty_pstAmmo01x_group",
		"_s_inv_highvlcty_revAmmo01x_group",
		"_s_inv_highvlcty_rifleAmmo01x_group",
		"_s_inv_pistolAmmo01x_group",
		"_s_inv_pistol_sign_dressing",
		"_s_inv_repeater_sign_dressing",
		"_s_inv_repeatHV_rifleammo01x_group",
		"_s_inv_repeatXS_rifleammo01x_group",
		"_s_inv_repeat_rifleammo01x_group",
		"_s_inv_revolverAmmo01x_group",
		"_s_inv_revolver_sign_dressing",
		"_s_inv_rifleAmmo01x_group",
		"_s_inv_rifle_sign_dressing",
		"_s_inv_shotgunAmmo01x_group",
		"_s_inv_shotgun_sign_dressing",
		"_s_inv_slug_shotgunAmmo01x_group",
		"_s_inv_varmint_rifleammo01x_group",
		"_s_inv_xpres_pstAmmo01x_group",
		"_s_inv_xpres_revAmmo01x_group",
		"_s_inv_xpres_rifleAmmo01x_group"
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

 