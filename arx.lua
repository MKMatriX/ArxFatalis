function centerMouse () 
	x_from = 32767
	y_from = 32767

	local rel_x = 10
	local rel_y = 10

	-- we cant just instantly go to center sorry
	for i = 0, 30 do 
		local x, y = GetMousePosition();
		if (x > x_from) then
			rel_x = -25
		else
			rel_x = 25
		end
		
		if (y > y_from) then
			rel_y = -25
		else
			rel_y = 25
		end

		MoveMouseRelative(rel_x, rel_y)
		Sleep(1)
	end
end

function moveMouse(x,y) -- draw stroke
	local points = 10 -- how many times move mouse
	local timeToCast = 120 -- total time of stroke
	local strokeLength = 500

	local length = math.sqrt(x*x + y*y)

	local n = timeToCast / points
	local step_coef = strokeLength / points

	local x_step = x * step_coef
	local y_step = y * step_coef

	for i=0, points do
		MoveMouseRelative(x_step, y_step)
		Sleep(n)
	end
end

function castRune(points)
	centerMouse()
	
	PressMouseButton(1)
	for i , point in ipairs(points) do
		x_from, y_from = moveMouse(point[1], point[2])
	end
	ReleaseMouseButton(1)
end

function castSpell(runes)
	centerMouse()
	centerMouse()
	centerMouse()
	PressKey(0x1d)
	centerMouse()
	for i , rune in ipairs(runes) do
		--OutputLogMessage(point[1] .. " " .. point[2] .. " - ")
		castRune(rune)
		Sleep(50)
		ReleaseMouseButton(1)
		Sleep(50)
	end
	ReleaseKey(0x1d)
end


function OnEvent(event, arg)
	-- directiond
	local D = {0,1}
	local U = {0,-1}
	local R = {1,0}
	local L = {-1,0}

	-- corners
	local RD = {1,1}
	local RU = {1,-1}
	local LD = {-1,1}
	local LU = {-1,-1}

	-- halfs
	local HL = {-0.5,0}
	local HR = {0.5,0}
	local HD = {0,0.5}
	local HU = {0,-0.5}

	-- runes
	local Aam = { R } -- Create
	local Cetrius = { RD, U, HL} -- Poison
	local Comunicatum = { R, HD, L, HD, R} -- Communication
	local Cosum = { R, HD, HL, U } -- Object
	local Folgora = { RU, RD } -- Storm
	local Fridd = { U, R, D } -- Freeze
	local Kaom = { {-0.3,0.3}, {-0.1,0.3}, {0.3,0.3} } -- Protection
	local Mega = { U } -- Improve
	local Morte = { R, HD } -- Death
	local Movis = { R, LD, R } -- Move
	local Nhi = { L } -- Negate
	local Rhaa = { D } -- Weakness
	local Spacium = { L, D, R, HU } -- Space
	local Stregum = { U, RD, U } -- Magic
	local Taar = { R, HD, R } -- Missile
	local Tempus = { HU, HR, HD, HR, HU, HR } -- Time
	local Tera = { RU, D, HR } -- Earth
	local Vista = { RD, LD } -- Vision
	local Vitae = { R, HU } -- Life
	local Yok = { D, R, HU } -- Fire

	-- spells
-- 1
	local MegaCheat = {Mega, Mega, Mega, Aam, Vitae, Tera} -- H
	local NightVision = {Mega, Vista}
	local MagicMissile = {Aam, Taar}
	local Ignite = {Aam, Yok}
	local Douse = {Nhi, Yok}
	local ActivatePortal = {Mega, Spacium} -- H
-- 2
	local Heal = {Mega, Vitae}
	local DetectTrap = {Morte, Cosum, Vista}
	local Armor = {Mega, Kaom}
	local LowerArmor = {Rhaa, Kaom}
	local Harm = {Rhaa, Vitae} -- H
-- 3
	local Speed = {Mega, Movis}
	local Reveal = {Nhi, Stregum, Vista}
	local Fireball = {Aam, Yok, Taar}
	local Feed = {Aam, Vitae, Cosum}
	local IceProjection = {Aam, Fridd, Taar} -- H
-- 4
	local Bless = {Mega, Stregum, Vitae}
	local DispelField = {Nhi, Spacium}
	local ProtectionFromFire = {Yok, Kaom}
	local Telekinesis = {Spacium, Comunicatum}
	local Curse = {Rhaa, Stregum, Vitae} -- H
	local ProtectionFromCold = {Fridd, Kaom} -- H
-- 5
	local Trap = {Aam, Morte, Cosum}
	local Levitate = {Mega, Spacium, Movis}
	local CurePoison = {Nhi, Cetrius}
	local RepelUndead = {Morte, Kaom}
	local PoisonProjection = {Aam, Cetrius, Taar} -- H
-- 6
	local RaiseUndead = {Aam, Morte, Vitae}
	local Paralyze = {Nhi, Movis}
	local CreateField = {Aam, Kaom, Spacium}
	local DisableTrap = {Nhi, Morte, Cosum}
	local SlowDown = {Rhaa, Movis} -- H
-- 7
	local FlyingEye = {Vista, Movis}
	local FireField = {Aam, Yok, Spacium}
	local LightningProjection = {Aam, Folgora, Taar}
	local Confuse = {Rhaa, Vista}
	local IceField = {Aam, Fridd, Spacium} -- H
-- 8
	local Invisibility = {Nhi, Vista}
	local ManaDrain = {Stregum, Movis}
	local Chaos = {Aam, Mega, Morte}
	local EnchantObject = {Mega, Stregum, Cosum}
	local LifeDrain = {Vitae, Movis} -- H
-- 9
	local Summon = {Aam, Vitae, Tera}
	local NegateMagic = {Nhi, Spacium}
	local Incinerate = {Aam, Mega, Yok}
	local MassParalyze = {Mega, Nhi, Movis}
-- 10
	local MassLightningProjection = {Aam, Folgora, Spacium}
	local ControlDemon = {Movis, Comunicatum}
	local SlowTime = {Rhaa, Tempus}
	local MassIncinerate = {Mega, Aam, Mega, Yok}


	if event == "G_PRESSED" then
		if arg == 1 then
			castSpell(LifeDrain)
		end
		if arg == 2 then
			castSpell(ManaDrain)
		end
		if arg == 3 then
			castSpell(NightVision)
		end
		if arg == 4 then
			castSpell(Heal)
			--castSpell(CurePoison)
		end
		-- 5 is for longJump makes with duck-duck-jump macro with 0.03 sec (depends on CPU)
		if arg == 6 then
			castSpell(Bless)
		end
		if arg == 7 then
			castSpell(Invisibility)
		end
		if arg == 8 then
			castSpell(Levitate)
		end
		if arg == 9 then
			castSpell(Speed)
		end
	end

	if event == "M_RELEASED" then 
		if arg == 1 then
			castSpell(ActivatePortal)
		end
	end 

	if event == "MOUSE_BUTTON_RELEASED" then 
		if arg == 3 then
			castSpell(MagicMissile)
		end
		if arg == 4 then
			castSpell(Fireball)
		end
		if arg == 5 then
			castSpell(FireField)
		end
	end 
end
