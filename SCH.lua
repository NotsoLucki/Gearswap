function get_sets()
--This function prepares your equipment sets.
	sets.precast = {}
	sets.precast.sid = {
		main="Eremite's Wand +1", 
		sub="Tortoise Shield", 
		ammo="Phantom Tathlum", 
		neck="Willpower Torque", 
		ear2="Phantom Earring +1", 
		body="Ixion Cloak", 
		hands="Scholar's Bracers", 
		ring1="Omniscient Ring +1", 
		ring2="Omniscient Ring +1", 
		waist="Druid's Rope", 
		legs="Mahatma slops", 
		feet="Scholar's Loafers"}
	
	sets.midcast = {}
	sets.midcast.ele = {
		main="Chatoyant Staff", 
		sub="Vivid Strap +1", 
		ammo="Phantom Tathlum",
		head="Scholar's Mortarboard", 
		neck="Lemegeton Medallion +1", 
		ear1="Moldavite Earring", 
		ear2="Crapaud earring", 
		body="Mahatma houppelande", 
		hands="Mahatma cuffs", 
		ring1="Omniscient Ring +1",
		ring2="Omniscient Ring +1",
		back="Hecate's cape", 
		waist="Penitent's Rope", 
		legs="Mahatma slops",
		feet="Mountain Gaiters"}
	sets.midcast.eleIce = {
		main="Aquilo's Staff"}
	sets.midcast.enf = {
		main="Chatoyant Staff", 
		sub="Vivid Strap +1", 
		head="Scholar's Mortarboard", 
		neck="Enfeebling Torque", 
		ear1="Enfeebling Earring", 
		body="Mahatma houppelande", 
		hands="Mahatma cuffs",
		waist="Penitent's Rope"}
	sets.midcast.drk = {
		main="Chatoyant Staff", 
		sub="Vivid Strap +1", 
		head="Scholar's Mortarboard", 
		neck="Dark Torque", 
		ear1="Dark Earring", 
		body="Mahatma houppelande", 
		hands="Mahatma cuffs",
		waist="Penitent's Rope", 
		legs="Argute Pants"}
	sets.midcast.cure = {
		main="Chatoyant Staff", 
		sub="Bugard Strap +1",
		head="Walahra Turban", 
		neck="Fylgja Torque +1", 
		ear1="Roundel Earring",
		body="Mahatma houppelande", 
		ring1="Celestial Ring", 
		ring2="Celestial Ring",
		back="Red Cape +1",
		feet="Argute Loafers"}
	sets.midcast.enh = {
		main="Chatoyant Staff", 
		sub="Bugard Strap +1",
		head="Walahra Turban",
		body="Goliard Saio"}
	sets.midcast.UP = {
		neck="Uggalepih Pendant"}
	
	sets.aftercast = {}
	sets.aftercast.idle = {
		main="Terra's Staff", 
		sub = "Reaver Grip +1",
		neck="Orochi nodowa +1", 
		ear1="Harmonius Earring", 
		ear2="Harmonius Earring",
		body="Ixion Cloak", 
		hands="Creek M mitts", 
		ring1="Bloodbead ring", 
		ring2="Jelly Ring",
		back="Umbra Cape", 
		waist="Steppe sash", 
		legs="Combat Caster's Slacks", 
		feet="Herald's Gaiters"}
	sets.aftercast.rest = {
		main="Chatoyant Staff", 
		sub="Bugard Strap+1", 
		head="Scholar's Mortarboard", 
		neck='Beak Necklace +1', 
		ear1='Antivenom Earring', 
		ear2="Rapture Earring",
		body="Mahatma houppelande", 
		hands="Genie gages", 
		ring1="Celestial ring", 
		ring2="Celestial ring",
		back="Invigorating Cape", 
		waist="Qiqirn Sash +1", 
		legs="Baron's Slops"}
	sets.aftercast.sublimation = {
		main="Terra's Staff", 
		sub = "Reaver Grip +1",
		neck="Orochi nodowa +1", 
		ear1="Harmonius Earring", 
		ear2="Harmonius Earring",
		head="Scholar's Mortarboard",
		body="Goliard Saio", 
		hands="Creek M mitts", 
		ring1="Bloodbead ring", 
		ring2="Jelly Ring",
		back="Umbra Cape", 
		waist="Steppe sash", 
		legs="Combat Caster's Slacks", 
		feet="Herald's Gaiters"}
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
	if spell.skill == 'Elemental Magic' then
		equip(sets.midcast.ele)
	end
	if spell.element == "Ice" then
		equip(sets.midcast.eleIce)
	end
	if spell.skill == 'Healing Magic' then
		equip(sets.midcast.cure)
	end
	if spell.skill == 'Enfeebling Magic' then
		equip(sets.midcast.enf)
	end
	if spell.skill == 'Dark Magic' then
		equip(sets.midcast.drk)
	end
	if spell.skill == 'Enhancing Magic' then
		equip(sets.midcast.enh)
	end
	if player.mpp < 51 then
		equip(sets.midcast.UP)
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

---------------------------------------------------------------------
--This function is called everytime a status effect lands on a player
---------------------------------------------------------------------
function buff_change(name,gain) 
	if buffactive.silence then
		send_command('@input /item "Echo Drops" <me>')
	end
	if buffactive['Light Arts'] then
        	send_command('input /ja "Addendum: White" <me>')
    	end
    	if buffactive['Dark Arts'] then
        	send_command('input /ja "Addendum: Black" <me>')
    	end
	if buffactive['Sublimation: Activated'] then
        	equip(sets.aftercast.sublimation) 
    	elseif buffactive['Sublimation: Complete'] then
        	equip(sets.aftercast.idle)
    	end
end 

