function get_sets()
--This function prepares your equipment sets.
	sets.precast = {}
	sets.precast.sid = {
		main="Eremite's Wand +1", sub="Tortoise Shield", ammo="Morion Tathlum", 
		neck="Willpower Torque", ear2="Phantom Earring +1", 
		body="Royal Cloak", hands="Scholar's Bracers", ring1="Genius Ring +1", ring2="Genius Ring +1", 
		back="Red Cape +1", waist="Druid's Rope", legs="Magic Slacks", feet="Mountain Gaiters"}
	
	sets.midcast = {}
	sets.midcast.ele = {
		main="Chatoyant Staff", sub="Bugard Strap +1", 
		head="Seer's Crown +1", neck="Solon Torque", ear1="Elemental Earring", 
		body="Flora Cotehardie", hands="Seer's Mitts +1", 
		waist="Penitent's Rope"}
	sets.midcast.eleIce = {
		main="Aquilo's Staff",
		hands="Seer's Mitts +1"}
	sets.midcast.enf = {
		main="Chatoyant Staff", sub="Bugard Strap +1", 
		head="Seer's Crown +1", neck="Enfeebling Torque", ear1="Enfeebling Earring", 
		body="Flora Cotehardie", hands="Seer's Mitts +1", 
		waist="Penitent's Rope"}
	sets.midcast.drk = {
		main="Chatoyant Staff", sub="Bugard Strap +1", 
		head="Seer's Crown +1", neck="Dark Torque", ear1="Dark Earring", 
		body="Flora Cotehardie", hands="Seer's Mitts +1", 
		waist="Penitent's Rope"}
	sets.midcast.cure = {
		main="Chatoyant Staff", sub="Bugard Strap +1", 
		hands="Seer's Mitts +1"}
	sets.midcast.DA = {
		body="Scholar's Gown"}
	sets.midcast.LA = {
		legs="Scholar's Pants"}
	
	sets.aftercast = {}
	sets.aftercast.idle = {
		main="Terra's Staff", sub = "Reaver Grip +1",
		neck="Spirit Torque", ear1="Platinum Earring +1", ear2="Platinum Earring +1",
		body="Royal Cloak", hands="Tactician Magician's Cuffs +2", ring1="Celerity Ring +1", ring2="Celerity Ring +1",
		back="Dodge Cape", waist="Volant Belt", legs="Martial Slacks", feet="Desert Boots +1"}
	sets.aftercast.rest = {
		main="Chatoyant Staff", sub="Bugard Strap+1", 
		body="Royal Cloak", neck='Beak Necklace +1', ear1='Antivenom Earring', 
		back="Invigorating Cape", waist="Qiqirn Sash +1", legs="Baron's Slops"}
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

--

function aftercast(spell)
--This function performs after the action finishes or is interrupted in any way.
	if player.status == "Engaged" then
		equip()
	elseif player.status == "Idle" then
		equip(sets.aftercast.idle)
	end
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