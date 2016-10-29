--Current BLM level: 75

-----------------------------------------------------
--These functions set gearsets for specific instances
-----------------------------------------------------
function get_sets()
	--Precast occurs before actions are sent to the server
	sets.precast = {}
	sets.precast.sid = {
		main="Eremite's Wand +1", sub="Tortoise Shield", ammo="Phantom Tathlum", 
		neck="Willpower Torque", ear2="Phantom Earring +1", 
		body="Ixion Cloak", hands='Mahatma cuffs', ring1="Omniscient Ring +1", ring2="Omniscient Ring +1", 
		waist="Druid's Rope", legs="Mahatma slops", feet="Wizard's Sabots"}
	
	--Midcast occurs RIGHT/JUST/etc. before actions are sent to the server
	sets.midcast = {}
	sets.midcast.ele = {
		main="Chatoyant Staff", sub="Vivid Strap +1", 
		head="Demon helm +1", neck="Lemegeton medallion +1", ear1="Moldavite Earring", 
		body="Genie Weskit", hands="Genie manillas",
		back="Hecate's Cape", waist="Witch sash", legs="Mahatma slops", feet="Mountain gaiters"}
	sets.midcast.eleIce = {
		main="Aquilo's Staff",
		hands="Wizard's Gloves",
		back="Hecate's Cape"}
	sets.midcast.enf = {
		main="Chatoyant Staff", sub="Vivid Strap +1", 
		head="Genie tiara", neck="Enfeebling Torque", ear1="Enfeebling Earring", 
		body="Wizard's Coat", hands='Mahatma cuffs', 
		back="Ixion Cape", waist="Witch Sash", legs="Genie lappas"}
	sets.midcast.drk = {
		main="Chatoyant Staff", sub="Vivid Strap +1", 
		head="Demon helm +1", neck="Dark Torque", ear1="Dark Earring", 
		body="Mahatma houppelande", hands='Mahatma cuffs', 
		back="Ixion Cape", waist="Witch sash", legs="Wizard's Tonban", feet="Genie Huaraches"}
	sets.midcast.cure = {
		main="Chatoyant Staff", sub="Bugard Strap +1",
		head="Walahra Turban", neck="Fylgja Torque +1", ear1="Roundel Earring",
		body="Mahatma houppelande", ring1="Celestial Ring", ring2="Celestial Ring",
		back="Ixion Cape"}
	sets.midcast.enh = {
		main="Chatoyant Staff", sub="Bugard Strap +1",
		head="Walahra Turban",
		body="Goliard Saio",
		back="Ixion Cape", feet="Genie Huaraches"}
	sets.midcast.SR = {
		ring1="Sorcerer's Ring"}
	sets.midcast.UP = {
		neck="Uggalepih Pendant"}
	
	--Aftercast occurs after actions are sent to the server
	sets.aftercast = {}
	sets.aftercast.idle = {
		main="Terra's Staff", sub = "Reaver Grip +1",
		neck="Orochi nodowa +1", ear1="Harmonius Earring", ear2="Harmonius Earring",
		body="Ixion Cloak", hands="Creek M mitts", ring1="Harmonius Ring", ring2="Harmonius Ring",
		back="Umbra Cape", waist="Steppe sash", legs="Genie Lappas", feet="Herald's Gaiters"}
	sets.aftercast.rest = {
		main="Chatoyant Staff", sub="Bugard Strap+1", 
		head="Genie tiara",
		neck='Beak Necklace +1', ear1='Antivenom Earring', ear2="Rapture Earring",
		body="Mahatma houppelande", hands="Genie Gages", ring1="Celestial Ring", ring2="Celestial Ring",
		back="Invigorating Cape", waist="Qiqirn Sash +1", legs="Baron's Slops"}

-----------------------------------------------------------------------------------------------------------------------------
--These functions are used to set specific gearsets before actions are sent to the server                                    
--eg. 'sets.precast.sid' is a gearset that equips gear that maximizes spell interruption down while in the process of casting
-----------------------------------------------------------------------------------------------------------------------------
function precast(spell)
	if spell.type:contains('Magic') then
		equip(sets.precast.sid)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------
--These functions are used after precast, but before the action is sent to the server                                              
--This will always happen before the action takes effect, even if it has a cast-time of 0. So this can be used on JA and WS as well
--eg. 'sets.midcast.ele' is a geaerset that equips gear that maximizes Elemental Skill for elemental spells                        
-----------------------------------------------------------------------------------------------------------------------------------
function midcast(spell)
	if spell.skill:contains('Elemental') then
		equip(sets.midcast.ele)
	end
	if spell.element == "Ice" then
		equip(sets.midcast.eleIce)
	end
	if spell.skill:contains('Healing') then
		equip(sets.midcast.cure)
	end
	if spell.skill:contains('Enfeebling') then
		equip(sets.midcast.enf)
	end
	if spell.skill:contains('Dark') then
		equip(sets.midcast.drk)
	end
	if player.hpp < 76 and player.tp < 100 then
		equip(sets.midcast.SR)
	end
	if player.hpp < 51 then
		equip(sets.midcast.UP)
	end
	if spell.skill:contains('Enhancing') then
		equip(sets.midcast.enh)
	end
end

-------------------------------------------------------------------------------
--This function performs after the action finishes or is interrupted in any way
-------------------------------------------------------------------------------
function aftercast(spell)
	if player.status == "Engaged" then
		equip()
	elseif player.status == "Idle" then
		equip(sets.aftercast.idle)
	end
end

---------------------------------------------------------------------------------------------
--This function is called every time a player's status changes (Engaged, Idle, Resting, Dead)
--eg. 'sets.aftercast.rest' is a gearset that maximizes MP recovery when resting             
---------------------------------------------------------------------------------------------
function status_change(new,old)
	if new == 'Idle' then
		equip(sets.aftercast.idle)
	elseif new == 'Resting' then
		equip(sets.aftercast.rest)
	end
end
