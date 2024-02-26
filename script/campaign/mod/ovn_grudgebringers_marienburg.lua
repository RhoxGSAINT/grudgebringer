local grudgebringers_api = get_grudgebringers_api()
local marienburg_installed = vfs.exists("script/frontend/mod/cataph_teb.lua")
if marienburg_installed and grudgebringers_api._version == "1.1" then
    -- Add the Marienburg factions to the Order list.
    local marienburg_units = {
        {name = "snek_hkrul_mar_landship"},
        {name = "hkrul_mar_knights_griffon"},
        {name = "hkrul_mar_riverwarden", min =2, max=2},
        {name = "hkrul_mar_sons_of_manann"}
    }
    grudgebringers_api:grudgebringer_add_faction_or_culture(
        "wh_main_emp_marienburg",
        OVN_GRUDGEBRINGERS_ORDER,
        marienburg_units
    )
    grudgebringers_api:grudgebringer_add_faction_or_culture(
        "ovn_mar_house_den_euwe",
        OVN_GRUDGEBRINGERS_ORDER,
        marienburg_units
    )
    grudgebringers_api:grudgebringer_add_faction_or_culture(
        "ovn_mar_cult_of_manann",
        OVN_GRUDGEBRINGERS_ORDER,
        marienburg_units,
        {
            "ovn_mar_cult_of_manann"
        }
    )
    grudgebringers_api:grudgebringer_add_faction_or_culture(
        "ovn_mar_house_fooger",
        OVN_GRUDGEBRINGERS_ORDER,
        marienburg_units,
        {
            "climate_mountain"
        }
    )
end