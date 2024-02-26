local grudgebringers_api = { 
    _version = "1.1",
    __tostring = function() return "grudgebringers_api"; end,
    culture_faction_db = {}, -- Should never be directly accessed or directly modified; use the helpers on grudgebringers_api
    additional_units = {} -- Should never be directly accessed or directly modified; use the helpers on grudgebringers_api
}

setmetatable(grudgebringers_api, grudgebringers_api)

OVN_GRUDGEBRINGERS_ORDER = "good"
OVN_GRUDGEBRINGERS_NOT_ORDER = "bad"
OVN_GRUDGEBRINGERS_ALIGNMENT_KEY = "alignment"
OVN_GRUDGEBRINGERS_UNIT_RETURN_KEY = "unit_return"
OVN_GRUDGEBRINGERS_CLIMATE_SUITABILITY_KEY = "preferred_climate"
OVN_GRUDGEBRINGERS_DEFAULT_UNIT_MIN = 1
OVN_GRUDGEBRINGERS_DEFAULT_UNIT_MAX = 1

OVN_GRUDGEBRINGERS_KEYLIST = {OVN_GRUDGEBRINGERS_ALIGNMENT_KEY, OVN_GRUDGEBRINGERS_UNIT_RETURN_KEY, OVN_GRUDGEBRINGERS_CLIMATE_SUITABILITY_KEY}

-- Use this to add a faction or culture to Grudgebringers's order/not order system. All arguments except faction_or_culture_id are optional, but missing info could result in issues.
-- For units, the arguments min and max can be defined to adjust min/maxes, otherwise the code will default to OVN_GRUDGEBRINGERS_DEFAULT_UNIT_MIN and OVN_GRUDGEBRINGERS_DEFAULT_UNIT_MAX respectively.
function grudgebringers_api:grudgebringer_add_faction_or_culture(faction_or_culture_id, alignment, return_reward_units, preferred_climate)
    alignment = alignment or nil
    return_reward_units = return_reward_units or nil
    preferred_climate = preferred_climate or nil
    out("DEBUG: OVN Grudgebringers: Added faction/culture " .. faction_or_culture_id .. " as " .. alignment .. " to the database.")
    self.culture_faction_db[faction_or_culture_id] = {
        [OVN_GRUDGEBRINGERS_ALIGNMENT_KEY] = alignment,
        [OVN_GRUDGEBRINGERS_UNIT_RETURN_KEY] = return_reward_units,
        [OVN_GRUDGEBRINGERS_CLIMATE_SUITABILITY_KEY] = preferred_climate
    }
end

-- Use this to add a unit to the mercenary pool for Grudgebringers. Your unit won't be properly accessible if it isn't added to this list.
-- Supports a string with a unit id, or a table of strings.
function grudgebringers_api:grudgebringer_add_unit(unit_path)
    if type(unit_path) == "string" then 
        out("DEBUG: OVN Grudgebringers: Added unit " .. unit_path .. " to the database.")
        table.insert(self.additional_units, unit_path)
    elseif type(unit_path) == "table" then
        for _, v in pairs(unit_path) do
            out("DEBUG: OVN Grudgebringers: Added unit " .. v .. " to the database.")
            table.insert(self.additional_units, v)
        end
    else
        out("ERROR: OVN Grudgebringers: Incorrect type passed to grudgebringer_add_unit; must be string or array of strings.")
    end
end
-- Use this to remove a unit from the mercenary pool for Grudgebringers. Don't use this unless you know what you're doing.
-- Supports a string with a unit id, or a table of strings.
function grudgebringers_api:grudgebringer_remove_unit(unit_path)
    if type(unit_path) == "string" then 
        out("DEBUG: OVN Grudgebringers: Removed unit " .. unit_path .. " from the database.")
        self.additional_units[unit_path] = nil
    elseif type(unit_path) == "table" then
        for _, v in pairs(unit_path) do
            out("DEBUG: OVN Grudgebringers: Removed unit " .. v .. " from the database.")
            self.additional_units[v] = nil
        end
    else
        out("ERROR: OVN Grudgebringers: Incorrect type passed to grudgebringer_remove_unit; must be string or array of strings.")
    end
end

-- Use this to remove an entry so you can re-add it with changes, for mods that adjust it.
function grudgebringers_api:grudgebringer_remove_faction_or_culture(faction_or_culture_id)
    out("DEBUG: OVN Grudgebringers: Deleted faction/culture " .. faction_or_culture_id .. " from the database.")
    self.culture_faction_db[faction_or_culture_id] = nil
end

--- Returns all faction units possible, used for mercenary pool initialization.
function grudgebringers_api:grudgebringer_get_all_faction_units()
    local all_units = {}
    for id, entry in pairs(self.culture_faction_db) do
        if entry[OVN_GRUDGEBRINGERS_UNIT_RETURN_KEY] ~= nil then
            for k,v in pairs(entry[OVN_GRUDGEBRINGERS_UNIT_RETURN_KEY]) do
                local unit_name = v["name"]
                local has_unit_already = false
                for _, value in pairs(all_units) do
                    if value == unit_name then
                        has_unit_already = true
                        break
                    end
                end
                if not has_unit_already then -- We don't want to add a unit twice if it already exists.
                    table.insert(all_units, "rhox_grudge_" .. unit_name) -- All of these have rhox_grudge_ in front of them in the table, so need to add it here for proper addition.
                end
            end
        end
    end
    for _, unit in pairs(self.additional_units) do
        table.insert(all_units, unit) -- Except the base RoRs for Grudgebringers, they don't have it.
    end
    return all_units
end

function grudgebringers_api:grudgebringer_get_faction_info(faction, check_culture, check_subculture, check_faction)
    local info = {}
    local culture_id = faction:culture()
    local subculture_id = faction:subculture()
    local faction_id = faction:name()
    local function check_db(fed_info, used_id)
        for id, entry in pairs(self.culture_faction_db) do
            if id == used_id then
                for _, v in pairs(OVN_GRUDGEBRINGERS_KEYLIST) do
                    if entry[v] ~= nil then
                        fed_info[v] = entry[v]
                    end
                end
            end
        end
        return fed_info
    end
    -- We'll go over the DB thrice, culture first, then subculture, then faction. That way if a faction has specific overrides, we pull it's info over the base culture info.
    -- For example, Drycha isn't someone Grudgebringers will do contracts for by default, despite being Wood Elves.
    -- Some cleverer LUA work might let us cut this down to one iteration, but I'm feeling a bit lazy right now.
    if check_culture then
        info = check_db(info, culture_id)
    end
    if check_subculture then
        info = check_db(info, subculture_id)
    end
    if check_faction then
        info = check_db(info, faction_id)
    end
    for _, v in pairs(OVN_GRUDGEBRINGERS_KEYLIST) do
        if info[v] == nil then
            --out("WARNING: OVN Grudgebringers: grudgebringer_get_faction_info could not find " .. v .. " info for " .. faction_id .. "/" .. subculture_id ..  "/" .. culture_id)
        end
    end
    return info[OVN_GRUDGEBRINGERS_ALIGNMENT_KEY], info[OVN_GRUDGEBRINGERS_UNIT_RETURN_KEY], info[OVN_GRUDGEBRINGERS_CLIMATE_SUITABILITY_KEY]
end

function get_grudgebringers_api()
    return core:get_static_object(tostring(grudgebringers_api))
end

core:add_static_object(tostring(grudgebringers_api), grudgebringers_api, false)

_G.get_grudgebringers_api = get_grudgebringers_api()