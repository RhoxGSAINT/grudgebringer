local grudgebringers_api = get_grudgebringers_api()
local albion_installed = vfs.exists("script/frontend/mod/ovn_albion_frontend.lua")
if albion_installed and grudgebringers_api._version == "1.0" then
    -- Add the Albion culture to the Order list.
    local albion_units = {
        {name = "albion_hearthguard_grudgebringer", max=2},
        {name = "albion_chariot_grudgebringer", max=2},
        {name = "albion_giant_grudgebringer"},
        {name = "albion_huntresses_grudgebringer"}
    }
    grudgebringers_api:grudgebringer_add_faction_or_culture(
        "ovn_albion",
        OVN_GRUDGEBRINGERS_ORDER,
        albion_units
    )
end