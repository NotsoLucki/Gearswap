function get_sets()
--This function prepares your equipment sets.
	sets.precast = {}
	sets.precast.sid = {main="Eremite's Wand +1", sub="Flat Shield", ammo="Morion Tathlum", head="Seer's Crown +1", neck="Willpower Torque", ear2="Morion Earring", body="Tactician Magician's Coat", hands='Sly Gauntlets', ring1="Wisdom Ring +1", ring2="Wisdom Ring +1", back="Red Cape +1", waist="Druid's Rope", legs="Magic Slacks", feet="Mountain Gaiters"}
	
	sets.midcast = {}
	sets.midcast.ele = {main="Qi Staff +1", sub="Lizard Strap +1", neck="Solon Torque", ear1="Elemental Earring", waist="Reverend Sash"}
	sets.midcast.enf = {main="Rose Wand +1", sub="Flat Shield", neck="Solon Torque", ear1="Enfeebling Earring", waist="Reverend Sash"}
	sets.midcast.drk = {main="Rose Wand +1", sub="Flat Shield", neck="Solon Torque", ear1="Dark Earring", waist="Reverend Sash"}
	
	sets.aftercast = {}
	sets.aftercast.idle = {}
	sets.aftercast.rest = {main="Spiro Staff", sub="Lizard Strap+1", body="Salutary Robe +1", neck='Beak Necklace +1', ear1='Antivenom Earring', waist="Qiqirn Sash +1", legs="Baron's Slops"}
end

--

function precast(spell)
--This function performs right before the action is sent to the server.
	if spell.type:contains('Magic') then
		equip(sets.precast.sid)
	end
end

--

function midcast(spell)
--This function performs after precast but before the action is sent to the server. This will always happen before the action takes effect, even if it has a cast-time of 0. So this can be used on JA and WS as well.
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

--

function aftercast(spell)
--This function performs after the action finishes or is interrupted in any way.
end

--

function status_change(new,old)
--This function is called every time a player's status changes (Engaged, Idle, Resting, Dead).
	if new == 'Idle' then
		equip(sets.aftercast.idle)
	elseif new == 'Resting' then
		equip(sets.aftercast.rest)
	end
end
