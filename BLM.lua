--Current BLM level: 70

-----------------------------------------------------
--These functions set gearsets for specific instances
-----------------------------------------------------
function get_sets()
	--Precast occurs before actions are sent to the server
	sets.precast = {}
	sets.precast.sid = {
		main="Eremite's Wand +1", sub="Tortoise Shield", ammo="Morion Tathlum", 
		neck="Willpower Torque", ear2="Phantom Earring +1", 
		body="Demon's Cloak", hands='Sly Gauntlets', ring1="Genius Ring +1", ring2="Genius Ring +1", 
		back="Red Cape +1", waist="Druid's Rope", legs="Magic Slacks", feet="Wizard's Sabots"}
	
	--Midcast occurs RIGHT/JUST/etc. before actions are sent to the server
	sets.midcast = {}
	sets.midcast.ele = {
		main="Chatoyant Staff", sub="Bugard Strap +1", 
		neck="Solon Torque", ear1="Elemental Earring", 
		body="Demon's Cloak", hands="Wizard's Gloves",
		waist="Penitent's Rope", feet="Mountain Gaiters"}
	sets.midcast.eleIce = {
		main="Aquilo's Staff",
		hands="Wizard's Gloves",}
	sets.midcast.enf = {
		main="Chatoyant Staff", sub="Bugard Strap +1", 
		head="Wizard's Petasos", neck="Enfeebling Torque", ear1="Enfeebling Earring", 
		body="Wizard's Coat", hands='Sly Gauntlets', 
		waist="Penitent's Rope", feet="Mountain Gaiters"}
	sets.midcast.drk = {
		main="Chatoyant Staff", sub="Bugard Strap +1", 
		head="Wizard's Petasos", neck="Dark Torque", ear1="Dark Earring", 
		body="Flora Cotehardie", hands='Sly Gauntlets', 
		waist="Penitent's Rope", feet="Mountain Gaiters"}
	sets.midcast.cure = {
		main="Chatoyant Staff", sub="Bugard Strap +1"}
	sets.midcast.SR = {
		ring1="Sorcerer's Ring"}
	sets.midcast.UP = {
		neck="Uggalepih Pendant"}
	
	--Aftercast occurs after actions are sent to the server
	sets.aftercast = {}
	sets.aftercast.idle = {
		main="Terra's Staff", sub = "Reaver Grip +1",
		neck="Evasion Torque", ear1="Platinum Earring +1", ear2="Platinum Earring +1",
		body="Demon's Cloak", hands="Tactician Magician's Cuffs +2", ring1="Celerity Ring +1", ring2="Celerity Ring +1",
		back="Umbra Cape", waist="Volant Belt", legs="Martial Slacks", feet="Wizard's Sabots"}
	sets.aftercast.rest = {
		main="Chatoyant Staff", sub="Bugard Strap+1", 
		body="Demon's Cloak", neck='Beak Necklace +1', ear1='Antivenom Earring', 
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
