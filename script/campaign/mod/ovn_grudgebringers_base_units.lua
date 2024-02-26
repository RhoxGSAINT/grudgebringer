local grudgebringers_api = get_grudgebringers_api()
local grudgebringer_rors = {
    "helmgart_bowmen",
    "keelers_longbows",
    "dargrimm_firebeard_dwarf_warriors",
    "azguz_bloodfist_dwarf_warriors",
    "urblab_rotgut_mercenary_ogres",
    "treeman_knarlroot",
    "galed_elf_archers",
    "elrod_wood_elf_glade_guards",
    "black_avangers",
    "carlsson_cavalry",
    "carlsson_guard",
    "countess_guard",
    "vannheim_75th",
    "treeman_gnarl_fist",
    "ragnar_wolves",
    "flagellants_eusebio_the_bleak",
    "dieter_schaeffer_carroburg_greatswords",
    "imperial_cannon_darius_flugenheim",
    "knights_of_the_realm_bertrand_le_grande",
    "grail_knights_tristan_de_la_tourtristan_de_la_tour",
    "dwarf_envoy_dwarf_warriors",
    "jurgen_muntz_outlaw_infantry",
    "stephan_weiss_outlaw_pistoliers",
    "boris_von_raukov_4th_nuln_halberdiers",
    "uter_blomkwist_imperial_mortar",
    "dwarf_envoy_dwarf_warriors",
    "leitdorf_9th_crossbows",
    "emperors_hellblaster_volley_gun",
    "reiksguard_knights_todbringer"
}
-- Add the RoRs to the Grudgebringers unit pool for initialization.
grudgebringers_api:grudgebringer_add_unit(grudgebringer_rors)