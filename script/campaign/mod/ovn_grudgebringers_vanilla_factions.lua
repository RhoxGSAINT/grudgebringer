local grudgebringers_api = get_grudgebringers_api()

-- Vanilla game factions/cultures we consider Order.
grudgebringers_api:grudgebringer_add_faction_or_culture(
    "wh_dlc05_wef_wood_elves",
    OVN_GRUDGEBRINGERS_ORDER,
    {
        {name = "wh2_dlc16_wef_inf_bladesingers_0"},
        {name = "wh_dlc05_wef_inf_waywatchers_0"},
        {name = "wh_dlc05_wef_mon_treekin_0"}
    },
	{
		"climate_magicforest"
	}
)

grudgebringers_api:grudgebringer_add_faction_or_culture(
    "wh_main_brt_bretonnia",
    OVN_GRUDGEBRINGERS_ORDER,
    {
        {name = "wh_main_brt_cav_grail_knights"},
        {name = "wh_dlc07_brt_inf_battle_pilgrims_0", max=2},
        {name = "wh_main_brt_cav_knights_of_the_realm"}   
    },
	{
		"climate_desert", 
		"climate_jungle",
		"climate_savannah",
		"climate_temperate"
	}
)

grudgebringers_api:grudgebringer_add_faction_or_culture(
    "wh3_main_cth_cathay",
    OVN_GRUDGEBRINGERS_ORDER,
    {
        {name = "wh3_main_cth_inf_dragon_guard_0"},
        {name = "wh3_main_cth_inf_dragon_guard_crossbowmen_0"},
        {name = "wh3_main_cth_art_fire_rain_rocket_battery_0"}
    },
	{
		"climate_desert",
		"climate_savannah",
		"climate_temperate"
	}
)

grudgebringers_api:grudgebringer_add_faction_or_culture(
    "wh_main_emp_empire",
    OVN_GRUDGEBRINGERS_ORDER,
    {
        {name = "wh2_dlc13_emp_inf_huntsmen_0", max=2},
        {name = "wh_main_emp_cav_reiksguard"},
        {name = "wh_main_emp_art_helblaster_volley_gun"},
        {name = "wh_main_emp_art_helstorm_rocket_battery"}   
    },
	{
		"climate_jungle",
		"climate_savannah",
		"climate_temperate"
	}
)

grudgebringers_api:grudgebringer_add_faction_or_culture(
    "wh_main_dwf_dwarfs",
    OVN_GRUDGEBRINGERS_ORDER,
    {
        {name = "wh_main_dwf_inf_ironbreakers"},
        {name = "wh_main_dwf_inf_hammerers"},
        {name = "wh_main_dwf_inf_longbeards_1"},
        {name = "wh_main_dwf_veh_gyrocopter_0"},
        {name = "wh_main_dwf_art_organ_gun"}
    },
	{
		"climate_mountain",
		"climate_wasteland",
		"climate_savannah"
	}
)

grudgebringers_api:grudgebringer_add_faction_or_culture(
    "wh2_main_hef_high_elves",
    OVN_GRUDGEBRINGERS_ORDER,
    {
        {name = "wh2_dlc10_hef_inf_sisters_of_avelorn_0"},
        {name = "wh2_main_hef_inf_phoenix_guard"},
        {name = "wh2_main_hef_inf_swordmasters_of_hoeth_0"},
        {name = "wh2_main_hef_cav_dragon_princes"}
    },
	{
		"climate_frozen",
		"climate_island",
		"climate_jungle",
		"climate_ocean",
		"climate_savannah",
		"climate_wasteland"
	}
)

grudgebringers_api:grudgebringer_add_faction_or_culture(
    "wh3_main_ksl_kislev",
    OVN_GRUDGEBRINGERS_ORDER,
    {
        {name = "wh3_main_ksl_cav_war_bear_riders_1"},
        {name = "wh3_main_ksl_cav_gryphon_legion_0"},   
        {name = "wh3_main_ksl_inf_ice_guard_0"},
        {name = "wh3_main_ksl_inf_streltsi_0"}
    },
	{
		"climate_frozen",
		"climate_temperate"
	}
)

-- Vanilla game factions/cultures we consider Not Order.
-- To avoid balance changes, this has been kept 1:1 with the existing mod, but I would recommend condensing this
-- via taking advantage of the new API functionality to target cultures and subcultures as NOT_ORDER.
grudgebringers_api:grudgebringer_add_faction_or_culture(
    "wh2_dlc16_wef_drycha",
    OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_dlc15_grn_bonerattlaz",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh_main_grn_crooked_moon",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh_main_grn_greenskins",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh_main_grn_orcs_of_the_bloody_hand",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh_main_vmp_vampire_counts",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh_main_vmp_schwartzhafen",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_main_vmp_caravan_of_blue_roses",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_dlc20_chs_azazel",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_dlc20_chs_festus",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_dlc20_chs_kholek",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_dlc20_chs_sigvald",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_dlc20_chs_valkia",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_main_chs_shadow_legion",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_dlc20_chs_vilitch",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh_main_chs_chaos",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_dlc17_bst_malagor",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_dlc17_bst_taurox",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_main_bst_shadowgor",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh_dlc03_bst_beastmen",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh_dlc08_nor_norsca",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh_dlc08_nor_wintertooth",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_dlc11_def_the_blessed_dread",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_main_def_cult_of_pleasure",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_main_def_hag_graef",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_main_def_har_ganeth",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_main_def_naggarond",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_twa03_def_rakarth",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_dlc09_skv_clan_rictus",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_main_skv_clan_eshin",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_main_skv_clan_mors",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_main_skv_clan_moulder",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_main_skv_clan_pestilens",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_dlc11_cst_noctilus",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_dlc11_cst_pirates_of_sartosa",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_dlc11_cst_the_drowned",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh2_dlc11_cst_vampire_coast",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_main_kho_exiles_of_khorne",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_main_nur_poxmakers_of_nurgle",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_main_tze_oracles_of_tzeentch",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_main_sla_seducers_of_slaanesh",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_main_ogr_disciples_of_the_maw",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_main_ogr_goldtooth",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_dlc23_chd_astragoth",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_dlc23_chd_legion_of_azgorh",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_dlc23_chd_zhatan",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
grudgebringers_api:grudgebringer_add_faction_or_culture(
	"wh3_dlc24_tze_the_deceivers",
	OVN_GRUDGEBRINGERS_NOT_ORDER
)
