local rhox_climate_culture_join_table ={
    ["climate_chaotic"] ={
    --nobody
    },
    ["climate_desert"] ={
        ["wh_main_brt_bretonnia"] =true,--crusaders
        ["wh3_main_cth_cathay"] = true
    },
    ["climate_frozen"] ={
        ["wh3_main_ksl_kislev"] = true,
        ["ovn_albion"] = true
        
    },
    ["climate_island"] ={
        ["ovn_albion"]=true
    },
    ["climate_jungle"] ={
        ["wh_main_emp_empire"] = true, --Markus
        ["wh_main_brt_bretonnia"] = true, --bordaux
        ["mixer_teb_southern_realms"] = true --Colombo
    },
    ["climate_magicforest"] ={
        ["wh_dlc05_wef_wood_elves"] = true
    },
    ["climate_mountain"] ={
        ["wh_main_dwf_dwarfs"] = true
    },
    ["climate_ocean"] ={
    },
    ["climate_savannah"] ={ --almost everybody
        ["wh3_main_cth_cathay"] = true,
        ["wh_main_emp_empire"] = true,
        ["wh_main_brt_bretonnia"] = true,
        ["wh_main_dwf_dwarfs"] = true,
        ["mixer_teb_southern_realms"] = true
    },
    ["climate_temperate"] ={
        ["wh3_main_cth_cathay"] = true,
        ["wh_main_emp_empire"] = true,
        ["wh_main_brt_bretonnia"] = true,
        ["wh3_main_ksl_kislev"] = true,
        ["mixer_teb_southern_realms"] = true
    },
    ["climate_wasteland"] ={
        ["wh_main_dwf_dwarfs"] = true,
        ["mixer_teb_southern_realms"] = true --that vampire guy
    }
}


local rhox_climate_faction_join_table ={
    ["climate_chaotic"] ={
    --nobody
    },
    ["climate_desert"] ={},
    ["climate_frozen"] ={},
    ["climate_island"] ={},
    ["climate_jungle"] ={},
    ["climate_magicforest"] ={},
    ["climate_mountain"] ={
        ["ovn_mar_house_fooger"] = true
    },
    ["climate_ocean"] ={
        ["ovn_mar_cult_of_manann"] = true
    },
    ["climate_savannah"] ={},
    ["climate_temperate"] ={},
    ["climate_wasteland"] ={}
}

local rhox_grudge_missing_ror_chance_settlement = 5

local rhox_faction_candidate_table={}
local rhox_target_settlement_name

local grudgebringers_api = get_grudgebringers_api()


local function rhox_find_5_faction_for_climate(character, climate)
    rhox_faction_candidate_table={} --initialize it
    local faction_list = cm:model():world():faction_list();
	
	local pos_x = character:logical_position_x()
	local pos_y = character:logical_position_y()
	
	for i = 0, faction_list:num_items() - 1 do
		local current_faction = faction_list:item_at(i);
        local alignment, possible_units, climate_compatibility = grudgebringers_api:grudgebringer_get_faction_info(current_faction, true, true, true)
        local distance_to_closest_region = nil
        out("DEBUG: OVN Grudgebringers: Faction " .. current_faction:name() .. " is " .. tostring(alignment))
        out("DEBUG: OVN Grudgebringers: Faction " .. current_faction:name() .. " climate suitability for " .. climate .. " is " .. current_faction:get_climate_suitability(climate))
        local climate_compatible = current_faction:get_climate_suitability(climate) == "suitability_good"
        if RHOX_GRUDGEBRINGER_MCT.climate_return == true then -- We want to check the manual lookup tables instead of relying on vanilla game suitability.
            climate_compatible = false
            if climate_compatibility ~= nil then
                for _, compatible_climate in pairs(climate_compatibility) do
                    if climate == compatible_climate then
                        climate_compatible = true
                        break
                    end
                end
            end
        end
        if climate_compatible then
            if alignment ~= nil and possible_units ~= nil then -- Don't try to return to anything we don't have a unit list or alignment for.
                if current_faction:is_dead() == false and alignment == OVN_GRUDGEBRINGERS_ORDER then
                    local region_list = current_faction:region_list()
                    for k = 0, region_list:num_items() - 1 do
                        local current_settlement = region_list:item_at(k):settlement();
                        local reg_pos_x = current_settlement:logical_position_x();
                        local reg_pos_y = current_settlement:logical_position_y();
                        
                        local distance = distance_squared(pos_x, pos_y, reg_pos_x, reg_pos_y);
                        if distance_to_closest_region == nil then
                            distance_to_closest_region = distance
                        elseif distance < distance_to_closest_region then
                            distance_to_closest_region = distance
                        end
                    end
                end
            end
		end
		if distance_to_closest_region ~= nil then --if it was nil, faction did not pass muster for a return
            out("Rhox Grudge Looked at: "..current_faction:name())
            out("Rhox Grudge Distance is: ".. tostring(distance_to_closest_region))
            local x ={
                name= current_faction:name(),
                distance= distance_to_closest_region
            }
            table.insert(rhox_faction_candidate_table, x)
		end
		
	end

end
local choice_string ={
    "FIRST",
    "SECOND",
    "THIRD",
    "FOURTH",
    "FIFTH"
}

core:add_listener(
    "rhox_grudge_CharacterPerformsSettlementOccupationDecision",
    "CharacterPerformsSettlementOccupationDecision",
    function(context)
        --out("Rhox Grudge: You're here???????")
        return context:occupation_decision() == "2205198931" --check occupation type and if this is human
    end,
    function(context) 
        local climate = context:garrison_residence():settlement_interface():get_climate()
        local character = context:character()
        out("Rhox Grudge climate: "..climate)
        rhox_find_5_faction_for_climate(character, climate)
        out("Rhox Grudge: Size of table: "..#rhox_faction_candidate_table)
        table.sort(rhox_faction_candidate_table, function(a,b) return a.distance < b.distance end)
        
        rhox_target_settlement_name = context:garrison_residence():settlement_interface():region():name()
        
        if #rhox_faction_candidate_table ==0 then
            return --it means there was no suitable candidate, should leave that settlement alone
            --[[
        elseif #rhox_faction_candidate_table >= 5 then
            for i=1,5 do
                local current = rhox_faction_candidate_table[i]
                out("Rhox Grudge "..i.."th faction:"..current.name.."/distance: "..current.distance)
            end
            --]]
        end
        
        
        if character:faction():is_human() ==false or not cm:is_factions_turn_by_key(character:faction():name()) then --it's not human or it's enemy's turn so just give the item to the most closest guy and begone
            out("Rhox Grudge climate: Grudge bringer was not human or it wasn't his turn")
            local target_faction =  cm:get_faction(rhox_faction_candidate_table[1].name)
            cm:transfer_region_to_faction(rhox_target_settlement_name, rhox_faction_candidate_table[1].name)--return the place to the most closest guy
            
            local _, target_unit_table, _ = grudgebringers_api:grudgebringer_get_faction_info(target_faction, true, true, true)
            local ti = cm:random_number(#target_unit_table, 1)
            local max_unit = (target_unit_table[ti]["max"] or OVN_GRUDGEBRINGERS_DEFAULT_UNIT_MAX) + character:faction():bonus_values():scripted_value("rhox_grudge_settlement_bonus_unit_number_modifier", "value")
            cm:add_units_to_faction_mercenary_pool(character:faction():command_queue_index(), target_unit_table[ti].name, cm:random_number(max_unit, target_unit_table[ti]["min"] or OVN_GRUDGEBRINGERS_DEFAULT_UNIT_MIN))
            
            if target_faction:is_human() then
                local incident_builder = cm:create_incident_builder("rhox_grudgebringer_get_settlement_from_grudgebringer")
                --incident_builder:add_target("default", character)
                incident_builder:add_target("default", context:garrison_residence():settlement_interface():region())
                
                local payload_builder = cm:create_payload()
                payload_builder:text_display("rhox_grudgebringer_settlement_returned")
                incident_builder:set_payload(payload_builder)
                cm:launch_custom_incident_from_builder(incident_builder, target_faction)
            end
            
            return
        end
    
        local dilemma_choice_count=3
        if #rhox_faction_candidate_table < 3 then
            dilemma_choice_count= #rhox_faction_candidate_table
        end
        
        if #rhox_faction_candidate_table == 0 then
            out("Rhox Grudge: There wasn't enough faction to return the settlement. Closing it.")
            return
        end
        out("Rhox Grudge climate: Launching dilemma!")
        local dilemma_builder = cm:create_dilemma_builder("rhox_grudge_return_settlement");
		local payload_builder = cm:create_payload();
        for i=1,dilemma_choice_count do
            local target_faction =  cm:get_faction(rhox_faction_candidate_table[i].name)
            local _, target_unit_table, _ = grudgebringers_api:grudgebringer_get_faction_info(target_faction, true, true, true)
            local ti = cm:random_number(#target_unit_table, 1)
            
            
            local treasury_mod = 1 + (character:faction():bonus_values():scripted_value("rhox_grudge_settlement_bonus_money_number_modifier", "value") / 100)
            out("Rhox Grudge: Treasury mod: ".. treasury_mod)
            local treasury_value = math.floor(cm:random_number(500, 250)*treasury_mod)
            out("Rhox Grudge: Treasury value: ".. treasury_value)
            payload_builder:treasury_adjustment(treasury_value);
            
            local diplo_mod = cm:random_number(2,1) + math.floor(character:faction():bonus_values():scripted_value("rhox_grudge_contracts_diplo_payload_modifier", "value") / 100); --diplomatic_attitude_adjustment are using 1~6 value you have to use /100
            out("Rhox Grudge: diplo mod: ".. diplo_mod)
            payload_builder:diplomatic_attitude_adjustment(target_faction, diplo_mod)
            
            --out("Rhox Grudge: Before checking ifs for missing RoR")
            if rhox_is_missed_ror_in_the_table() and cm:model():random_percent(rhox_grudge_missing_ror_chance_settlement) then --5%
                out("Rhox Grudge: I'm giving RoR as a reward")
                local effect_bundle_key, ancillary_key = rhox_get_missing_ror_bundle()
                local effect_bundle = cm:create_new_custom_effect_bundle(effect_bundle_key)
				effect_bundle:set_duration(2)
                payload_builder:effect_bundle_to_faction(effect_bundle)
                
                if ancillary_key ~=false and character:faction():ancillary_exists(ancillary_key) ~= true then --you could conquer same settlement twice in a turn.
                    payload_builder:faction_ancillary_gain(ancillary_key)
                end
                
            else
                local max_unit = (target_unit_table[ti]["max"] or OVN_GRUDGEBRINGERS_DEFAULT_UNIT_MAX)+math.floor(character:faction():bonus_values():scripted_value("rhox_grudge_settlement_bonus_unit_number_modifier", "value"))
                out("Rhox Grudge: Giving normal units, Max unit with modifier applied ".. max_unit)
                out("Rhox Gurdge: Unit name: " ..target_unit_table[ti].name)
                payload_builder:add_mercenary_to_faction_pool(target_unit_table[ti].name, cm:random_number(max_unit, target_unit_table[ti]["min"] or OVN_GRUDGEBRINGERS_DEFAULT_UNIT_MIN))
            end
            
            dilemma_builder:add_choice_payload(choice_string[i], payload_builder);
            payload_builder:clear()
        end
        dilemma_builder:add_target("default", context:character():military_force());
        dilemma_builder:add_choice_payload("CANCEL", payload_builder);
        cm:launch_custom_dilemma_from_builder(dilemma_builder, cm:get_faction("ovn_emp_grudgebringers"));
        
        out("Rhox Grudge climate: Dilemma Launched?")
        --cm:trigger_dilemma("ovn_emp_grudgebringers", "rhox_grudge_return_settlement")
        --cm:treasury_mod(cm:get_local_faction_name(true), 9999000)--do something
    end,
    true
);



core:add_listener(
    "rhox_grudge_settlements_dilemma_issued",
    "DilemmaIssuedEvent",
    function(context)
        return context:dilemma() == "rhox_grudge_return_settlement"
    end,
    function(context)
        out("Rhox Grudge: Dilemma issued")
        core:add_listener(
        "rhox_grudge_dilemma_panel_listener",
        "PanelOpenedCampaign",
        function(context)
            return (context.string == "events")

        end,
        function(context)

            cm:callback(function()
                local dilemma_choice_count=3
                if #rhox_faction_candidate_table < 3 then
                    dilemma_choice_count= #rhox_faction_candidate_table
                end
                
                
                for i=1,dilemma_choice_count do 
                    local target_faction= cm:get_faction(rhox_faction_candidate_table[i].name)
                    out("Rhox Grudge: Target faction: "..rhox_faction_candidate_table[i].name)
                    local flag_path = target_faction:flag_path()
                    local faction_name_string = ("[[img:"..flag_path.."/mon_24.png]][[//img]] "..common.get_localised_string("factions_screen_name_"..rhox_faction_candidate_table[i].name))
                    

                    local dilemma_location = find_uicomponent(core:get_ui_root(),"events", "event_layouts", "dilemma_active", "dilemma", "background","dilemma_list", "CcoCdirEventsDilemmaChoiceDetailRecordrhox_grudge_return_settlement"..choice_string[i], "choice_button", "button_txt")
                    if dilemma_location then
                        dilemma_location:SetText(faction_name_string)
                    end
                end

            end,
            0.3
            )

        end,
        false --see you next time
    )
    end,
    true
)



core:add_listener(
    "rhox_grudge_return_dilemma_choice_made",
    "DilemmaChoiceMadeEvent",
    function(context)
        local dilemma = context:dilemma();
        local choice = context:choice();
        return dilemma == "rhox_grudge_return_settlement" and choice ~=3 and choice < #rhox_faction_candidate_table; --choice starts from 0 --second is to prevent giving the trait in the case of Chaos wastes
    end,
    function(context)
        local choice = context:choice();
        cm:transfer_region_to_faction(rhox_target_settlement_name, rhox_faction_candidate_table[choice+1].name)--return the place to the selected
        
        cm:force_add_trait("character_cqi:"..context:faction():faction_leader():cqi(), "rhox_grudge_settlement_helper", true, 1);
        cm:replenish_action_points("character_cqi:"..context:faction():faction_leader():cqi(), 0.3) --replenish action points for returning the settlement
        rhox_check_ror_rewards(context:faction())--get RoRs
    end,
    true
);