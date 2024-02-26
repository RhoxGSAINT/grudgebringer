local grudgebringers_api = get_grudgebringers_api()
local TEB_installed = vfs.exists("script/frontend/mod/cataph_teb.lua")
if TEB_installed then
    -- Add Cataph's Southern Realms to the Order list.
    local TEB_units = {
        {name = "teb_pikemen", min =2, max=2},
        {name = "teb_conqui_adventurers", min =2, max=2},
        {name = "teb_pavisiers", min =2, max=2},
        {name = "teb_galloper"},
        {name = "teb_encarmine"}
    }
    grudgebringers_api:grudgebringer_add_faction_or_culture(
        "mixer_teb_southern_realms",
        OVN_GRUDGEBRINGERS_ORDER,
        TEB_units
    )
    -- There seems to be some oddities with wh_main_sc_teb_teb vs the actual wh_main_teb_X_CB subcultures between Mixer and TEB, 
    -- so adding the one from vanilla here just in case.
    grudgebringers_api:grudgebringer_add_faction_or_culture(
        "wh_main_sc_teb_teb",
        OVN_GRUDGEBRINGERS_ORDER,
        TEB_units
    )
else
    -- Add the vanilla Southern Realms subculture to the Order list with their legacy units.
    grudgebringers_api:grudgebringer_add_faction_or_culture(
        "wh_main_sc_teb_teb",
        OVN_GRUDGEBRINGERS_ORDER,
        {
            {name = "wh3_main_ogr_inf_maneaters_0"},
            {name = "wh3_main_ogr_cav_mournfang_cavalry_0"},
            {name = "wh_main_emp_inf_halberdiers", min =2, max=2},
            {name = "wh_main_emp_cav_outriders_0", min =2, max=2}
        }
    )
end