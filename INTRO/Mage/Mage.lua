--#############################
--##### INTRODUCTION MAGE #####
--#############################

local _G, setmet5atable, pairs, ipairs, select, error, math = 
_G, setmetatable, pairs, ipairs, select, error, math 

local wipe                                     = _G.wipe     
local math_max                                = math.max      

local TMW                                     = _G.TMW 
local strlowerCache                          = TMW.strlowerCache
local Action                                = _G.Action
local toNum                                 = Action.toNum
local CONST                                 = Action.Const
local Create                                 = Action.Create
local Listener                                = Action.Listener
local Print                                    = Action.Print
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local IsUnitEnemy                               = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local Totem                                    = LibStub("LibTotemInfo-1.0")
local HealComm                                 = LibStub("LibHealComm-4.0")


local SetToggle                                = Action.SetToggle
local GetToggle                                = Action.GetToggle
local GetPing                                = Action.GetPing
local GetGCD                                = Action.GetGCD
local GetCurrentGCD                            = Action.GetCurrentGCD
local GetLatency                            = Action.GetLatency
local GetSpellInfo                            = Action.GetSpellInfo
local BurstIsON                                = Action.BurstIsON
local InterruptIsValid                        = Action.InterruptIsValid
local IsUnitEnemy                            = Action.IsUnitEnemy
local DetermineUsableObject                    = Action.DetermineUsableObject
local DetermineHealObject                    = Action.DetermineHealObject 
local DetermineIsCurrentObject                = Action.DetermineIsCurrentObject 
local DetermineCountGCDs                    = Action.DetermineCountGCDs 
local DetermineCooldownAVG                    = Action.DetermineCooldownAVG 
local AuraIsValid                            = Action.AuraIsValid
local HealingEngine                             = Action.HealingEngine

local CanUseStoneformDefense                = Action.CanUseStoneformDefense
local CanUseStoneformDispel                    = Action.CanUseStoneformDispel
local CanUseHealingPotion                    = Action.CanUseHealingPotion
local CanUseLivingActionPotion                = Action.CanUseLivingActionPotion
local CanUseLimitedInvulnerabilityPotion    = Action.CanUseLimitedInvulnerabilityPotion
local CanUseRestorativePotion                = Action.CanUseRestorativePotion
local CanUseSwiftnessPotion                    = Action.CanUseSwiftnessPotion
local CanUseManaRune                    	= Action.CanUseManaRune

local TeamCacheFriendly                        = TeamCache.Friendly
local ActiveUnitPlates                        = MultiUnits:GetActiveUnitPlates()

local SPELL_FAILED_TARGET_NO_POCKETS        = _G.SPELL_FAILED_TARGET_NO_POCKETS      
local ERR_INVALID_ITEM_TARGET                = _G.ERR_INVALID_ITEM_TARGET    
local MAX_BOSS_FRAMES                        = _G.MAX_BOSS_FRAMES
local ACTION_CONST_STOPCAST                    = CONST.STOPCAST  

local CreateFrame                            = _G.CreateFrame
local UIParent                                = _G.UIParent        
local StaticPopup1                            = _G.StaticPopup1    
local StaticPopup1Button2                    -- nil because frame is not created at this moment

local GetWeaponEnchantInfo                    = _G.GetWeaponEnchantInfo    
local GetItemInfo                            = _G.GetItemInfo  
local      UnitGUID,       UnitIsUnit,      UnitCreatureType,       UnitAttackPower = 
_G.UnitGUID, _G.UnitIsUnit, _G.UnitCreatureType, _G.UnitAttackPower

--For Toaster
local Toaster									= _G.Toaster
local GetSpellTexture 							= _G.TMW.GetSpellTexture

Action[Action.PlayerClass]                     = {
	--Racial
    Shadowmeld								= Create({ Type = "Spell", ID = 20580		}),  
    Perception								= Create({ Type = "Spell", ID = 20600, FixedTexture = CONST.HUMAN	}), 
    BloodFury								= Create({ Type = "Spell", ID = 20572		}), 
    Berserking								= Create({ Type = "Spell", ID = 20554		}), 
    Stoneform								= Create({ Type = "Spell", ID = 20594		}), 
    WilloftheForsaken						= Create({ Type = "Spell", ID = 7744		}), 
    EscapeArtist							= Create({ Type = "Spell", ID = 20589		}),	
	ArcaneTorrent							= Create({ Type = "Spell", ID = 28730		}),
	GiftoftheNaaru							= Create({ Type = "Spell", ID = 28880		}),	

	--General
    Throw									= Create({ Type = "Spell", ID = 2764,     QueueForbidden = true, BlockForbidden = true	}),	

	--Arcane
	ArcaneIntellect							= Create({ Type = "Spell", ID = 1459		}),
	ConjureWater							= Create({ Type = "Spell", ID = 5504, useMaxRank = true		}),	
	ConjureFood								= Create({ Type = "Spell", ID = 587, useMaxRank = true		}),	
	Polymorph								= Create({ Type = "Spell", ID = 118			}),
	ArcaneMissles							= Create({ Type = "Spell", ID = 5143		}),	
	SlowFall								= Create({ Type = "Spell", ID = 130			}),
	DampenMagic								= Create({ Type = "Spell", ID = 604			}),
	ArcaneExplosion							= Create({ Type = "Spell", ID = 1449		}),
	RemoveLessserCurse						= Create({ Type = "Spell", ID = 475			}),	
	AmplifyMagic							= Create({ Type = "Spell", ID = 1008		}),
	ManaShield								= Create({ Type = "Spell", ID = 1463		}),	
	Evocation								= Create({ Type = "Spell", ID = 12051		}),	
	Blink									= Create({ Type = "Spell", ID = 1953		}),
	Counterspell							= Create({ Type = "Spell", ID = 2139		}),	
	ConjureManaAgate						= Create({ Type = "Spell", ID = 759			}),	
	MageArmor								= Create({ Type = "Spell", ID = 6117		}),	
	ConjureManaJade							= Create({ Type = "Spell", ID = 3552		}),
	ConjureManaCitrine						= Create({ Type = "Spell", ID = 10053		}),	
	ArcaneBrilliance						= Create({ Type = "Spell", ID = 23028		}),
	ConjureManaRuby							= Create({ Type = "Spell", ID = 10054		}),
	ArcaneBlast								= Create({ Type = "Spell", ID = 30451		}),
	Invisibility							= Create({ Type = "Spell", ID = 66			}),	
	Spellsteal								= Create({ Type = "Spell", ID = 30449		}),
	RitualofRefreshment						= Create({ Type = "Spell", ID = 43987		}),	
	SlowFall								= Create({ Type = "Spell", ID = 31589		}),
	PresenceofMind							= Create({ Type = "Spell", ID = 12043		}),	
	ArcanePower								= Create({ Type = "Spell", ID = 12042		}),

	--Fire
	Fireball								= Create({ Type = "Spell", ID = 133			}),	
	FireBlast								= Create({ Type = "Spell", ID = 2136		}),	
	Flamestrike								= Create({ Type = "Spell", ID = 2120		}),	
	FireWard								= Create({ Type = "Spell", ID = 543			}),
	Scorch									= Create({ Type = "Spell", ID = 2948		}),
	MoltenArmor								= Create({ Type = "Spell", ID = 30482		}),	
	BlastWave								= Create({ Type = "Spell", ID = 11113		}),
	DragonsBreath							= Create({ Type = "Spell", ID = 31661		}),
	Combustion								= Create({ Type = "Spell", ID = 11129		}),	

	--Frost
	FrostArmor								= Create({ Type = "Spell", ID = 168			}),
	Frostbolt								= Create({ Type = "Spell", ID = 116			}),	
	FrostNova								= Create({ Type = "Spell", ID = 122			}),
	Blizzard								= Create({ Type = "Spell", ID = 10			}),	
	FrostWard								= Create({ Type = "Spell", ID = 6143		}),	
	ConeofCold								= Create({ Type = "Spell", ID = 120			}),
	IceBlock								= Create({ Type = "Spell", ID = 45438		}),
	IceArmor								= Create({ Type = "Spell", ID = 7302		}),	
	IceLance								= Create({ Type = "Spell", ID = 30455		}),
	IceBarrier								= Create({ Type = "Spell", ID = 11426		}),	
	ColdSnap								= Create({ Type = "Spell", ID = 11958		}),	
	IcyVeins								= Create({ Type = "Spell", ID = 12472		}),	
	SummonWaterElemental					= Create({ Type = "Spell", ID = 31687		}),	
	WintersChill							= Create({ Type = "Spell", ID = 12579		}),		

}

local A                                     = setmetatable(Action[Action.PlayerClass], { __index = Action })

local player = "player"
local target = "target"
local pet = "pet"
local targettarget = "targettarget"
local focus = "focus"
local mouseover = "mouseover"

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

--Register Toaster
Toaster:Register("TripToast", function(toast, ...)
	local title, message, spellID = ...
	toast:SetTitle(title or "nil")
	toast:SetText(message or "nil")
	if spellID then 
		if type(spellID) ~= "number" then 
			error(tostring(spellID) .. " (spellID) is not a number for TripToast!")
			toast:SetIconTexture("Interface\FriendsFrame\Battlenet-WoWicon")
		else 
			toast:SetIconTexture((GetSpellTexture(spellID)))
		end 
	else 
		toast:SetIconTexture("Interface\FriendsFrame\Battlenet-WoWicon")
	end 
	toast:SetUrgencyLevel("normal") 
end)

------------------------------------------
-------------- COMMON PREAPL -------------
------------------------------------------
local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
	TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
	TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}
	

local ImmuneFire = {
	[6073] = true, -- Searing Infernal
	[2760] = true, -- Burning Exile
	[5850] = true, -- Blazing Elemental
	[16491] = true, -- Mana Feeder
	[6520] = true, -- Scorching Elemental
}

local ImmuneArcane = {
    [18864] = true,
    [18865] = true,
    [15691] = true,
    [20478] = true, -- Arcane Servant
}    

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)

    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
    local RacialAllowed = A.GetToggle(1, "Racial")
	local combatTime = Unit(player):CombatTime()
	local UseAoE = A.GetToggle(2, "AoE")

	local npcID = select(6, Unit(target):InfoGUID())

    --###############################
	--##### POTIONS/HEALTHSTONE #####
	--###############################
	
	local function RecoveryItems()
		local UsePotions = A.GetToggle(1, "Potion")		
		local PotionController = A.GetToggle(2, "PotionController")

		if not Player:IsStealthed() then  
			local Healthstone = GetToggle(2, "HSHealth") 
			if Healthstone >= 0 then 
				local HealthStoneObject = DetermineUsableObject(player, true, nil, true, nil, A.HSGreater3, A.HSGreater2, A.HSGreater1, A.HS3, A.HS2, A.HS1, A.HSLesser3, A.HSLesser2, A.HSLesser1, A.HSMajor3, A.HSMajor2, A.HSMajor1, A.HSMinor3, A.HSMinor2, A.HSMinor1)
				if HealthStoneObject then 			
					if Healthstone >= 100 then -- AUTO 
						if Unit(player):TimeToDie() <= 9 and Unit(player):HealthPercent() <= 40 then 
							return HealthStoneObject:Show(icon)	
						end 
					elseif Unit(player):HealthPercent() <= Healthstone then 
						return HealthStoneObject:Show(icon)								 
					end 
				end 
			end 		
		end 
		
		if UsePotions and combatTime > 2 then
			if PotionController == "HealingPotion" then
				if CanUseHealingPotion(icon) then 
					return true
				end 
			end	
		end	

		--[[if CanUseManaRune(icon) then
			return true
		end]]
	end

	
	--#######################
	--### DAMAGE ROTATION ###
	--#######################
	
	local function DamageRotation(unit) 	
	
	--###################
	--##### ARCANE #####
	--###################
	
		--If Arcane Power is learned then spec is likely Arcane, so continue with Arcane rotation:
		if A.ArcanePower:IsTalentLearned() then
			
			--If player doesn't have Mage Armor then use Mage Armor
			if A.MageArmor:IsReady(player) and Unit(player):HasBuffs(A.MageArmor.ID, true) == 0 then
				return A.MageArmor:Show(icon)
			end
			
			-- Use Icy Veins if we're using cooldowns.
			if A.IcyVeins:IsReady(player) and BurstIsON(unit) then
				return A.IcyVeins:Show(icon)
			end
			
			--Use trinkets if we're using cooldowns.
			if A.Trinket1:IsReady(player) and BurstIsON(unit) then
				return A.Trinket1:Show(icon)    
			end
			
			if A.Trinket2:IsReady(player) and BurstIsON(unit) then
				return A.Trinket2:Show(icon)    
			end	
		
			-- Use Arcane Power if we're using cooldowns.
			if A.ArcanePower:IsReady(player) and BurstIsON(unit) then
				return A.ArcanePower:Show(icon)
			end
			
			--Check that we can use Arcane Blast if we ignore the GCD and if we have Presence of Mind ready:
			if A.ArcaneBlast:IsReadyByPassCastGCD(unit) and A.PresenceofMind:IsReady(player) then
				-- If our Arcane Power buff is lasting less than the time it takes us to use Arcane Blast, then use Presence of Mind
				if Unit(player):HasBuffs(A.ArcanePower.ID, true) <= A.ArcaneBlast:ExecuteTime() then
					return A.PresenceofMind:Show(icon)
				end
			end
			
			-- Consume Presence of Mind buff with Arcane Blast
			if A.ArcaneBlast:IsReady(unit) and Unit(player):HasBuffs(A.PresenceofMind.ID, true) > 0 then
				return A.ArcaneBlast:Show(icon)
			end
			
			--If we're using cooldowns and we don't have Icy Veins buff and the Icy Veins cooldown is longer than 2 minutes then use Cold Snap to reset.
			if A.ColdSnap:IsReady(player) and BurstIsON(unit) and Unit(player):HasBuffs(A.IcyVeins.ID, true) == 0 and A.IcyVeins:GetCooldown() > 120 then
				return A.ColdSnap:Show(icon)
			end
			
			-- if Arcane Explosion is ready and AoE toggle is on and there are 3 or more enemies within 10 yards range then use Arcane Explosion.
			if A.ArcaneExplosion:IsReady(player) and UseAoE and MultiUnits:GetByRange(10) >= 3 then
				return A.ArcaneExplosion:Show(icon)
			end
			
			-- Use Arcane Blast if we're standing still OR if we have Presence of Mind buff.
			if A.ArcaneBlast:IsReady(unit) and (not isMoving or Unit(player):HasBuffs(A.PresenceofMind.ID, true) > 0) then
				return A.ArcaneBlast:Show(icon)
			end
		
			-- Use Evocation if we're not moving and mana is below 10%
			if A.Evocation:IsReady(player) and not isMoving and Player:ManaPercent() < 10 then
				return A.Evocation:Show(icon)
			end
			
			-- Use Frostbolt if we're not moving, our mana is below 20%, and Evocation cooldown is at least 10 seconds left. 
			if A.Frostbolt:IsReady(unit) and not isMoving and Player:ManaPercent() < 20 and A.Evocation:GetCooldown() >= 10 then
				return A.Frostbolt:Show(icon)
			end
			
			-- Use FireBlast if we're moving.
			if A.FireBlast:IsReady(unit) and isMoving then
				return A.FireBlast:Show(icon)
			end

		end
	
	--################
	--##### FIRE #####
	--################
	
		--If Combusion talent is learned then player is likely Fire Spec, so continue with Fire rotation:
		if A.Combustion:IsTalentLearned() then

			-- Use Molten Armor if Molten Armor isn't active.
			if A.MoltenArmor:IsReady(player) and Unit(player):HasBuffs(A.MoltenArmor.ID) == 0 then
				return A.MoltenArmor:Show(icon)
			end
			
			-- Use Scorch if target is a boss and has less than 5 Scorch stacks.
			if A.Scorch:IsReady(unit) and Unit(unit):IsBoss() and Unit(unit):HasDeBuffs(A.Scorch.ID) < 5 then
				return A.Scorch:Show(icon)
			end
			
			-- Use Icy Veins if we're using cooldowns and enemy health is greater than 80% or less than 20%
			if A.IcyVeins:IsReady(player) and BurstIsON(unit) and (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20) then
				return A.IcyVeins:Show(icon)
			end
			
			-- Use trinkets if we're using cooldowns.
			if A.Trinket1:IsReady(player) and BurstIsON(unit) then
				return A.Trinket1:Show(icon)    
			end
			
			if A.Trinket2:IsReady(player) and BurstIsON(unit) then
				return A.Trinket2:Show(icon)    
			end	
		
			-- Use Combustion if we're using cooldowns and enemy health is greater than 80% or less than 20%.
			if A.Combustion:IsReady(player) and BurstIsON(unit) and (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20) then
				return A.Combustion:Show(icon)
			end
			
			-- Use Dragon's Breath if AoE toggle is on and there are 3 or more enemies within 10 yards range.
			if A.DragonsBreath:IsReady(player) and UseAoE and MultiUnits:GetByRange(10) >=3 then
				return A.DragonsBreath:Show(icon)
			end
			
			-- Use Blast Wave if AoE toggle is on and there are 3 or more enemies within 10 yards range.			
			if A.BlastWave:IsReady(player) and UseAoE and MultiUnits:GetByRange(10) >=3 then
				return A.BlastWave:Show(icon)
			end		

			-- Use Flamestrike if AoE toggle is on and there are 3 or more enemies within 10 yards range and we're not moving (we keep it 10 yards since we need to move in for other AoE abilities anyway and it's too hard to check for AoE at such long range).
			if A.Flamestrike:IsReady(player) and UseAoE and not isMoving and  MultiUnits:GetByRange(10) >=3 then
				return A.Flamestrike:Show(icon)
			end
			
			-- Use Arcane Explosion if AoE toggle is on and there are 3 or more enemies within 10 yards range.
			if A.ArcaneExplosion:IsReady(player) and UseAoE and MultiUnits:GetByRange(10) >=3 then
				return A.ArcaneExplosion:Show(icon)
			end
			
			-- Use Fireball if standing still and target's time to die is less than how long it takes to cast Fireball
			if A.Fireball:IsReady(unit) and not isMoving and Unit(unit):TimeToDie() > A.Fireball:GetExecuteTime() then
				return A.Fireball:Show(icon)
			end
			
			-- Use Fire Blast if nothing else to do.
			if A.FireBlast:IsReady(unit) then
				return A.FireBlast:Show(icon)
			end
			
			-- Use Evocation if not moving and Mana is less than 10%
			if A.Evocation:IsReady(player) and not isMoving and Player:ManaPercent() < 10 then
				return A.Evocation:Show(icon)
			end			


		end
		
	--#################
	--##### FROST #####
	--#################	
		
		--If Combustion and Arcane Power are both not learned, then player is likely Frost spec or leveling spec, so continue with Frost rotation:
		if not A.Combustion:IsTalentLearned() and not A.ArcanePower:IsTalentLearned() then
			
			-- Check that the target has max Winter's Chill debuff and cooldown toggle is on:
			if Unit(unit):HasDeBuffsStacks(A.WintersChill.ID) >= 5 and BurstIsON(unit) then
				
				-- Use Icy Veins
				if A.IcyVeins:IsReady(player) then
					return A.IcyVeins:Show(icon)
				end
				
				-- Summon Water Elemental
				if A.SummonWaterElemental:IsReady(player) then
					return A.SummonWaterElemental:Show(icon)
				end

				-- Use Cold Snap if player doesn't have Icy Veins buff, Icy Veins cooldown is longer than 2 minutes, and Water Elemental has expired.
				if A.ColdSnap:IsReady(player) and BurstIsON(unit) and Unit(player):HasBuffs(A.IcyVeins.ID, true) == 0 and A.IcyVeins:GetCooldown() > 120 and A.SummonWaterElemental:GetSpellTimeSinceLastCast() > 45 then
					return A.ColdSnap:Show(icon)
				end
				
				--Use trinkets
				if A.Trinket1:IsReady(player) then
					return A.Trinket1:Show(icon)    
				end
				
				if A.Trinket2:IsReady(player) then
					return A.Trinket2:Show(icon)    
				end	
			
			end

			-- Use Cone of Cold if AoE toggle is on and 3 or more targets in 10 yards
			if A.ConeofCold:IsReady(player) and UseAoE and MultiUnits:GetByRange(10) >=3 then
				return A.ConeofCold:Show(icon)
			end
			
			-- Use Blizzard if AoE toggle is on, player is not moving, and 3 or more targets in 30 yards.
			if A.Blizzard:IsReady(player) and UseAoE and not isMoving and MultiUnits:GetActiveEnemies(30) >=3 then
				return A.Blizzard:Show(icon)
			end	

			-- Use Arcane Explosion if AoE toggle on and 3 or more targets in 10 yards.
			if A.ArcaneExplosion:IsReady(player) and UseAoE and MultiUnits:GetByRange(10) >=3 then
				return A.ArcaneExplosion:Show(icon)
			end			
			
			-- Use Ice Lance if Winter's Chill debuff is about to fall off and we don't have time to cast anything else.
			if A.IceLance:IsReady(unit) and Unit(unit):HasDeBuffs(A.WintersChill.ID) < A.GetGCD * 2 and Unit(unit):HasDeBuffs(A.WintersChill.ID) > 0 then
				return A.IceLance:Show(icon)
			end
			
			--Use Frostbolt if not moving.
			if A.Frostbolt:IsReady(unit) and not isMoving then
				return A.Frostbolt:Show(icon)
			end
			
			--Use Ice Lance if nothign else to do.
			if A.IceLance:IsReady(unit) then
				return A.IceLance:Show(icon)
			end
			
			--Use Evocation if not moving and less than 10% mana
			if A.Evocation:IsReady(player) and not isMoving and Player:ManaPercent() < 10 then
				return A.Evocation:Show(icon)
			end			

		
		end
		
		

	end


	if inCombat then 
		if RecoveryItems() then
			return true
		end
	end
    -- End on EnemyRotation()

	
    -- DPS Mouseover 
    if IsUnitEnemy(mouseover) then 
        unit = mouseover    
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
	
    -- DPS Target     
    if IsUnitEnemy(target) then 
        unit = target
        
        if DamageRotation(unit) then 
            return true 
        end 
    end

end
-- Finished

A[1] = nil

A[4] = nil

A[5] = nil

A[6] = nil

A[7] = nil

A[8] = nil
