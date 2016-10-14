--Current BLM level: 50

-------------------------------------------------------
--These functions set gearsets for specific instances--
-------------------------------------------------------
function get_sets()
	--Precast occurs before actions are sent to the server
	sets.precast = {}
	sets.precast.sid = {
		main="Eremite's Wand +1", sub="Tortoise Shield", ammo="Morion Tathlum", 
		neck="Willpower Torque", 
		body="Royal Cloak", hands='Sly Gauntlets', 
		back="Red Cape +1", waist="Druid's Rope", legs="Magic Slacks", feet="Wizard's Sabots"}
	
	--Midcast occurs RIGHT/JUST/etc. before actions are sent to the server
	sets.midcast = {}
	sets.midcast.ele = {
		main="Chatoyant Staff", sub="Bugard Strap +1", 
		head="Wizard's Petasos", neck="Solon Torque", ear1="Elemental Earring", ear2="Phantom Earring +1", 
		body="Flora Cotehardie", hands="Wizard's Gloves", ring1="Genius Ring +1", ring2="Genius Ring +1", 
		waist="Penitent's Rope"}
	sets.midcast.eleIce = {
		main="Aquilo's Staff",
		hands="Wizard's Gloves",}
	sets.midcast.enf = {
		main="Chatoyant Staff", sub="Bugard Strap +1", 
		head="Wizard's Petasos", neck="Solon Torque", ear1="Enfeebling Earring", ear2="Phantom Earring +1", 
		body="Flora Cotehardie", hands='Sly Gauntlets', ring1="Genius Ring +1", ring2="Genius Ring +1", 
		waist="Penitent's Rope"}
	sets.midcast.drk = {
		main="Chatoyant Staff", sub="Bugard Strap +1", 
		head="Wizard's Petasos", neck="Solon Torque", ear1="Dark Earring", ear2="Phantom Earring +1", 
		body="Flora Cotehardie", hands='Sly Gauntlets', ring1="Genius Ring +1", ring2="Genius Ring +1", 
		waist="Penitent's Rope"}
	sets.midcast.cure = {
		main="Chatoyant Staff", sub="Bugard Strap +1"}
	
	--Aftercast occurs after actions are sent to the server
	sets.aftercast = {}
	sets.aftercast.idle = {
		main="Terra's Staff", sub = "Reaver Grip +1",
		neck="Spirit Torque", ear1="Platinum Earring +1", ear2="Platinum Earring +1",
		body="Royal Cloak", hands="Tactician Magician's Cuffs +2", ring1="Celerity Ring +1", ring2="Celerity Ring +1",
		back="Dodge Cape", waist="Volant Belt", legs="Martial Slacks", feet="Wizard's Sabots"}
	sets.aftercast.rest = {
		main="Chatoyant Staff", sub="Bugard Strap+1", 
		body="Royal Cloak", neck='Beak Necklace +1', ear1='Antivenom Earring', 
		waist="Qiqirn Sash +1", legs="Baron's Slops"}

-------------------------------------------------------------------------------------------------------------------------------
--These functions are used to set specific gearsets before actions are sent to the server                                    --
--eg. 'sets.precast.sid' is a gearset that equips gear that maximizes spell interruption down while in the process of casting--
-------------------------------------------------------------------------------------------------------------------------------
function precast(spell)
	if spell.type:contains('Magic') then
		equip(sets.precast.sid)
	end
end

-------------------------------------------------------------------------------------------------------------------------------------
--These functions are used after precast, but before the action is sent to the server                                              --
--This will always happen before the action takes effect, even if it has a cast-time of 0. So this can be used on JA and WS as well--
--eg. 'sets.midcast.ele' is a geaerset that equips gear that maximizes Elemental Skill for elemental spells                        --
-------------------------------------------------------------------------------------------------------------------------------------
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
end

---------------------------------------------------------------------------------
--This function performs after the action finishes or is interrupted in any way--
---------------------------------------------------------------------------------
function aftercast(spell)
	if player.status == "Engaged" then
		equip()
	elseif player.status == "Idle" then
		equip(sets.aftercast.idle)
	end
end

-----------------------------------------------------------------------------------------------
--This function is called every time a player's status changes (Engaged, Idle, Resting, Dead)--
--eg. 'sets.aftercast.rest' is a gearset that maximizes MP recovery when resting             --
-----------------------------------------------------------------------------------------------
function status_change(new,old)
	if new == 'Idle' then
		equip(sets.aftercast.idle)
	elseif new == 'Resting' then
		equip(sets.aftercast.rest)
	end
end
