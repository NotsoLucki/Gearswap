--Current BLM level: 50

-------------------------------------------------------
--These functions set gearsets for specific instances--
-------------------------------------------------------
function get_sets()
	--Precast occurs before actions are sent to the server
	sets.precast = {}
	sets.precast.sid = {
		main="Eremite's Wand +1", sub="Flat Shield", ammo="Morion Tathlum",
		head="Seer's Crown +1", neck="Willpower Torque", ear2="Morion Earring",
		body="Tactician Magician's Coat", hands='Sly Gauntlets', ring1="Wisdom Ring +1", ring2="Wisdom Ring +1",
		back="Red Cape +1", waist="Druid's Rope", legs="Magic Slacks", feet="Mountain Gaiters"}
	
	--Midcast occurs RIGHT/JUST/etc. before actions are sent to the server
	sets.midcast = {}
	sets.midcast.ele = {
		main="Qi Staff +1", sub="Lizard Strap +1",
		neck="Solon Torque", ear1="Elemental Earring",
		waist="Reverend Sash"}
	sets.midcast.enf = {
		main="Rose Wand +1", sub="Flat Shield",
		neck="Solon Torque", ear1="Enfeebling Earring",
		waist="Reverend Sash"}
	sets.midcast.drk = {
		main="Rose Wand +1", sub="Flat Shield",
		neck="Solon Torque", ear1="Dark Earring",
		waist="Reverend Sash"}
	
	--Aftercast occurs after actions are sent to the server
	sets.aftercast = {}
	sets.aftercast.idle = {}
	sets.aftercast.rest = {
		main="Spiro Staff", sub="Lizard Strap+1",
		body="Salutary Robe +1", neck='Beak Necklace +1', ear1='Antivenom Earring',
		waist="Qiqirn Sash +1", legs="Baron's Slops"}
end

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
