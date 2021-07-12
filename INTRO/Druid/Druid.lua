--############################
--#### INTRODUCTION DRUID ####
--############################

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

	Lacerate								= Create({ Type = "Spell", ID = 33745		}),	
	Lifebloom								= Create({ Type = "Spell", ID = 33763		}),
	Maim									= Create({ Type = "Spell", ID = 22570		}),	
	GiftoftheWild							= Create({ Type = "Spell", ID = 21849		}),
	MangleBear								= Create({ Type = "Spell", ID = 33878		}),
	MangleCat								= Create({ Type = "Spell", ID = 33876		}),
	Hurricane								= Create({ Type = "Spell", ID = 16914		}),	
	FrenziedRegeneration					= Create({ Type = "Spell", ID = 22842		}),	
	Pounce									= Create({ Type = "Spell", ID = 9005		}),
	FerociousBite							= Create({ Type = "Spell", ID = 22568		}),	
	Ravage									= Create({ Type = "Spell", ID = 6785		}),
	Tranquility								= Create({ Type = "Spell", ID = 740			}),	
	Cower									= Create({ Type = "Spell", ID = 8998		}),	
	Dash									= Create({ Type = "Spell", ID = 1850		}),	
	Rake									= Create({ Type = "Spell", ID = 1822		}),	
	TigersFury								= Create({ Type = "Spell", ID = 5217		}),		
	Shred									= Create({ Type = "Spell", ID = 5221		}),	
	SootheAnimal							= Create({ Type = "Spell", ID = 2908		}),
	Claw									= Create({ Type = "Spell", ID = 1082		}),	
	Prowl									= Create({ Type = "Spell", ID = 5215		}),
	Rebirth									= Create({ Type = "Spell", ID = 20484		}),	
	Rip										= Create({ Type = "Spell", ID = 1079		}),
	Starfire								= Create({ Type = "Spell", ID = 2912		}),
	FaerieFire								= Create({ Type = "Spell", ID = 770			}),		
	Hibernate								= Create({ Type = "Spell", ID = 2637		}),
	Swipe									= Create({ Type = "Spell", ID = 779			}),		
	Bash									= Create({ Type = "Spell", ID = 5211		}),	
	Regrowth1								= Create({ Type = "Spell", ID = 8936, isRank = 1	}),
	Regrowth2								= Create({ Type = "Spell", ID = 8938, isRank = 2	}),	
	Regrowth3								= Create({ Type = "Spell", ID = 8939, isRank = 3	}),	
	Regrowth4								= Create({ Type = "Spell", ID = 8940, isRank = 4	}),	
	Regrowth5								= Create({ Type = "Spell", ID = 8941, isRank = 5	}),	
	Regrowth6								= Create({ Type = "Spell", ID = 9750, isRank = 6	}),	
	Regrowth7								= Create({ Type = "Spell", ID = 9856, isRank = 7	}),	
	Regrowth8								= Create({ Type = "Spell", ID = 9857, isRank = 8	}),	
	Regrowth9								= Create({ Type = "Spell", ID = 9858, isRank = 9	}),	
	Regrowth								= Create({ Type = "Spell", ID = 26980, useMaxRank = true	}),	
	DemoralizingRoar						= Create({ Type = "Spell", ID = 99			}),
	Maul									= Create({ Type = "Spell", ID = 6807		}),
	EntanglingRoots							= Create({ Type = "Spell", ID = 339			}),	
	Thorns									= Create({ Type = "Spell", ID = 467			}),
	Moonfire								= Create({ Type = "Spell", ID = 8921		}),	
	Rejuvenation1							= Create({ Type = "Spell", ID = 774, isRank = 1		}),	
	Rejuvenation2							= Create({ Type = "Spell", ID = 1058, isRank = 2		}),
	Rejuvenation3							= Create({ Type = "Spell", ID = 1430, isRank = 3		}),
	Rejuvenation4							= Create({ Type = "Spell", ID = 2090, isRank = 4		}),
	Rejuvenation5							= Create({ Type = "Spell", ID = 2091, isRank = 5		}),
	Rejuvenation6							= Create({ Type = "Spell", ID = 3627, isRank = 6		}),
	Rejuvenation7							= Create({ Type = "Spell", ID = 8910, isRank = 7		}),
	Rejuvenation8							= Create({ Type = "Spell", ID = 9839, isRank = 8		}),
	Rejuvenation9							= Create({ Type = "Spell", ID = 9840, isRank = 9		}),
	Rejuvenation10							= Create({ Type = "Spell", ID = 9841, isRank = 10	}),
	Rejuvenation11							= Create({ Type = "Spell", ID = 25299, isRank = 11	}),
	Rejuvenation12							= Create({ Type = "Spell", ID = 26981, isRank = 12	}),
	Rejuvenation							= Create({ Type = "Spell", ID = 26982, useMaxRank = true		}),	
	HealingTouch1							= Create({ Type = "Spell", ID = 5185, isRank = 1	}),
	HealingTouch2							= Create({ Type = "Spell", ID = 5186, isRank = 2	}),
	HealingTouch3							= Create({ Type = "Spell", ID = 5187, isRank = 3	}),
	HealingTouch4							= Create({ Type = "Spell", ID = 5188, isRank = 4	}),
	HealingTouch5							= Create({ Type = "Spell", ID = 5189, isRank = 5	}),
	HealingTouch6							= Create({ Type = "Spell", ID = 6778, isRank = 6	}),
	HealingTouch7							= Create({ Type = "Spell", ID = 8903, isRank = 7	}),
	HealingTouch8							= Create({ Type = "Spell", ID = 9758, isRank = 8	}),
	HealingTouch9							= Create({ Type = "Spell", ID = 9888, isRank = 9	}),
	HealingTouch10							= Create({ Type = "Spell", ID = 9889, isRank = 10	}),
	HealingTouch11							= Create({ Type = "Spell", ID = 25297, isRank = 11	}),
	HealingTouch12							= Create({ Type = "Spell", ID = 26978, isRank = 12	}),
	HealingTouch							= Create({ Type = "Spell", ID = 26979, useMaxRank = true 	}),	
	MarkoftheWild							= Create({ Type = "Spell", ID = 1126		}),
	Wrath									= Create({ Type = "Spell", ID = 5176		}),
	Cyclone									= Create({ Type = "Spell", ID = 33786		}),	
	SwiftFlightForm							= Create({ Type = "Spell", ID = 40120		}),
	FlightForm								= Create({ Type = "Spell", ID = 33943		}),
	DireBearForm							= Create({ Type = "Spell", ID = 9634	}),
	Innervate								= Create({ Type = "Spell", ID = 29166	}),	
	TravelForm								= Create({ Type = "Spell", ID = 783		}),	
	AbolishPoison							= Create({ Type = "Spell", ID = 2893	}),	
	RemoveCurse								= Create({ Type = "Spell", ID = 2782	}),	
	CatForm									= Create({ Type = "Spell", ID = 768		}),
	AquaticForm								= Create({ Type = "Spell", ID = 1066	}),	
	Cyclone									= Create({ Type = "Spell", ID = 5185	}),	
	CurePoison								= Create({ Type = "Spell", ID = 8946	}),
	Enrage									= Create({ Type = "Spell", ID = 5229	}),
	Growl									= Create({ Type = "Spell", ID = 6795	}),	

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


local ImmuneNature = {
[2762] = true, -- Thundering Exile
[2592] = true, -- Rumbling Exile
[2735] = true, -- Lesser Rock Elemental
[92] = true, -- Rock Elemental
[2736] = true, -- Greater Rock Elemental
[2752] = true, -- Rumbler (Greater Rock Elemental rarespawn)
[2919] = true, -- Fam'retor Guardian (Badlands quest enemy)
[9396] = true, -- Ground Pounder
[5855] = true, -- Magma Elemental
[8278] = true, -- Smoulder (Rarespawn)
[16491] = true, -- Mana Feeder
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

	
	--########################
	--### HEALING ROTATION ###
	--########################
	
	local function HealingRotation(unit)

		local isManaSave = HealingEngine.IsManaSave(unit)
		local isEmergency = Unit(unit):HealthPercent() > 0 and Unit(unit):HealthPercent() <= 30	and A.HealingWave:IsInRange(unit) 
		local unitGUID                                     = UnitGUID(unit)

		local HoTRolling = Unit(unit):HasBuffs({A.Rejuvenation.ID, A.Regrowth1.ID, A.Regrowth2.ID, A.Regrowth3.ID, A.Regrowth4.ID, A.Regrowth5.ID, A.Regrowth6.ID, A.Regrowth7.ID, A.Regrowth8.ID, A.Regrowth9.ID, A.Regrowth10.ID}, true) > 0

		local Trinket1Choice = A.GetToggle(2, "Trinket1Choice")
		local Trinket2Choice = A.GetToggle(2, "Trinket2Choice")
		local Trinket1Value = A.GetToggle(2, "Trinket1Value")
		local Trinket2Value = A.GetToggle(2, "Trinket2Value")
		
		
		--Emergency
		-- Nature's Swiftness + Healing Wave R12 for burst

		if A.Trinket1:IsReady(player) and inCombat then 
			if Trinket1Choice == "Health" and Unit(unit):HealthPercent() <= Trinket1Value then 
				return A.Trinket1:Show(icon)
			elseif Trinket1Choice == "Mana" and Player:ManaPercentage() <= Trinket1Value then 
				return A.Trinket1:Show(icon)
			end
		end

		if A.Trinket2:IsReady(player) and inCombat then 
			if Trinket2Choice == "Health" and Unit(unit):HealthPercent() <= Trinket2Value then 
				return A.Trinket2:Show(icon)
			elseif Trinket2Choice == "Mana" and Player:ManaPercentage() <= Trinket2Value then 
				return A.Trinket2:Show(icon)
			end
		end			

		if isEmergency and inCombat then

			-- Nature's Swiftness 
			if A.NaturesSwiftness:IsReady(player) then 
				return A.NaturesSwiftness:Show(icon)
			end 

			if A.HealingTouch:IsReady(unit) and Unit(player):HasBuffs(A.NaturesSwiftness.ID, true) > 0 then
				return A.HealingTouch:Show(icon)
			end

			if A.SwiftMend:IsReady(unit) and Unit(player):HasBuffs(A.NaturesSwiftness.ID, true) == 0 then 
				if HoTRolling then
					return A.SwiftMend:Show(icon)
				end
			end

		end  
		
		if A.TreeofLife:IsReady(player) and Unit(player):HasBuffs(A.TreeofLife.ID, true) == 0 then
			return A.TreeofLife:Show(icon)
		end

		--Just consume Nature's Swiftness buff if someone else snipes heal first.
		if Unit(player):HasBuffs(A.NaturesSwiftness.ID, true) > 0 and Unit(unit):HealthPercent() <= 60 then
			return A.HealingTouch:Show(icon)
		end

		--Cleanse
		local getmembersAll = HealingEngine.Data.SortedUnitIDs			
		if A.AbolishPoison:IsReady(unit) then
			for i = 1, #getmembersAll do 
				if Unit(getmembersAll[i].Unit):GetRange() <= 40 and AuraIsValid(getmembersAll[i].Unit, "UseDispel", "Dispel poisons") then  
					if UnitGUID(getmembersAll[i].Unit) ~= currGUID then
					  HealingEngine.SetTarget(getmembersAll[i].Unit) 
					  break
					end 					                									
				end				
			end
		end
		
		if A.RemoveCurse:IsReady(unit) then
			for i = 1, #getmembersAll do 
				if Unit(getmembersAll[i].Unit):GetRange() <= 40 and AuraIsValid(getmembersAll[i].Unit, "UseDispel", "Dispel curses") then  
					if UnitGUID(getmembersAll[i].Unit) ~= currGUID then
					  HealingEngine.SetTarget(getmembersAll[i].Unit) 
					  break
					end 					                									
				end				
			end
		end			

		if A.AbolishPoison:IsReady(unit) and AuraIsValid(unit, "UseDispel", "Dispel poisons") then
			return A.AbolishPoison:Show(icon)
		end

		if A.RemoveCurse:IsReady(unit) and AuraIsValid(unit, "UseDispel", "Dispel curses") then
			return A.RemoveCurse:Show(icon)
		end
		
		--Lifebloom
		if A.Lifebloom:IsReady(unit) and Unit(unit):IsTank() and Unit(unit):HasBuffsStacks(A.Lifebloom.ID) < 3 then
			return A.Lifebloom:Show(icon)
		end
		
		--Rejuventation
		local RejuvenationHP = A.GetToggle(2, "RejuvenationHP")
		if A.Rejuvenation:IsReady(unit) and Unit(unit):HasBuffs(A.Rejuvenation.ID, true) <= A.GetGCD() and Unit(unit):HealthPercent() <= RejuvenationHP then
			return A.Rejuvenation:Show(icon)
		end

		-- Regrowth
		local RegrowthMax = A.GetToggle(2, "RegrowthMax")
		local Regrowth9 = A.GetToggle(2, "Regrowth9")
		local Regrowth7 = A.GetToggle(2, "Regrowth7")
		local Regrowth4 = A.GetToggle(2, "Regrowth4")		
		if A.Regrowth:IsReady(unit) and not isMoving then 
			if Unit(unit):HealthPercent() <= RegrowthMax and not isManaSave then
				return A.Regrowth:Show(icon)
			elseif Unit(unit):HealthPercent() <= Regrowth9 and not isManaSave then 
				return A.Regrowth9:Show(icon)
			elseif Unit(unit):HealthPercent() <= Regrowth7 then 
				return A.Regrowth7:Show(icon)
			elseif Unit(unit):HealthPercent() <= Regrowth4 then 
				return A.Regrowth4:Show(icon)
			end
		end	
		
	end
	
	--#######################
	--### DAMAGE ROTATION ###
	--#######################
	
	local function DamageRotation(unit) 	
	
	--###################
	--##### BALANCE #####
	--###################
	
		if A.MoonkinForm:IsReady(player) and Unit(player):HasBuffs(A.MoonkinForm.ID) == 0 then
			return A.MoonkinForm:Show(icon)
		end
		
		--Check if Moonkin
		if Unit(player):HasBuffs(A.MoonkinForm.ID) > 0 then
		
			--Faeire Fire
			if A.FaerieFire:IsReady(unit) and Unit(unit):HasDeBuffs(A.FaerieFire.ID) == 0 and (Unit(unit):TimeToDie() >= 10 or Unit(unit):IsBoss()) then
				return A.FaerieFire:Show(icon)
			end

			--Insect Swarm
			if A.InsectSwarm:IsReady(unit) and Unit(unit):HasDeBuffs(A.InsectSwarm.ID, true) <= A.GetGCD() * 2 then
				return A.InsectSwarm:Show(icon)
			end
			
			--Moonfire
			if A.Moonfire:IsReady(unit) and Unit(unit):HasDeBuffs(A.Moonfire.ID, true) <= A.GetGCD() * 2 and (Unit(unit):TimeToDie() >= 10 or Unit(unit):IsBoss()) and Player:GetDeBuffsUnitCount(A.Moonfire.ID) < 3 then
				return A.MoonFire:Show(icon)
			end

			if A.Trinket1:IsReady(player) and BurstIsON(unit) then
				return A.Trinket1:Show(icon)    
			end
			
			if A.Trinket2:IsReady(player) and BurstIsON(unit) then
				return A.Trinket2:Show(icon)    
			end			
			
			if A.Hurricane:IsReady(unit) and UseAoE and MultiUnits:GetActiveUnitPlates(30) >= 5 and Player:AreaTTD(30) > 10 then 
				if A.Barkskin:IsReady(player) then
					return A.Barkskin:Show(icon)
				end
				
				return A.Hurricane:Show(icon)
			end	
			
			if A.Starfire:IsReady(unit) then
				return A.Starfire:Show(icon)
			end
		end
	
	--################
	--##### BEAR #####
	--################
	
		if Unit(player):HasBuffs(A.DireBearForm.ID) > 0 then
			--Faerie Fire
			if A.FaerieFire:IsReady(unit) and Unit(unit):HasDeBuffs(A.FaerieFire.ID) == 0 and (Unit(unit):TimeToDie() >= 10 or Unit(unit):IsBoss()) then
				return A.FaerieFire:Show(icon)
			end
			
			--DemoralizingRoar
			if A.DemoralizingRoar:IsReady(player) and A.Mangle:IsInRange() and Unit(unit):HasDeBuffs(A.DemoralizingRoar.ID) == 0 then
				return A.DemoralizingRoar:Show(icon)
			end
			
			--Enrage
			if A.Enrage:IsReady(player) and A.Mangle:IsInRange() then
				return A.Enrage:Show(icon)
			end

			if A.Trinket1:IsReady(player) and BurstIsON(unit) then
				return A.Trinket1:Show(icon)    
			end
			
			if A.Trinket2:IsReady(player) and BurstIsON(unit) then
				return A.Trinket2:Show(icon)    
			end	
			
			--Lacerate
			if A.Lacerate:IsReady(player) and Unit(unit):HasBuffsStacks(A.Lacerate.ID, true) < 5 and (MultiUnits:GetByRange(8) <= 2 or not UseAoE) then
				return A.Lacerate:Show(icon)
			end
			
			--Mangle
			if A.MangleBear:IsReady(unit) then
				return A.MangleBear:Show(icon)
			end
			
			--Swipe
			if A.Swipe:IsReady(player) and A.Mangle:IsInRange() and UseAoE then
				return A.Swipe:Show(icon)
			end
			
			--Maul
			if A.Maul:IsReady(unit) then
				return A.Maul:Show(icon)
			end
		end
		
	--###############
	--##### CAT #####
	--###############	
		
		if Unit(player):HasBuffs(A.CatForm.ID) > 0 then
			
			--Faerie Fire
			if A.FaerieFire:IsReady(unit) and Unit(unit):HasDeBuffs(A.FaerieFire.ID) == 0 and (Unit(unit):TimeToDie() >= 10 or Unit(unit):IsBoss()) then
				return A.FaerieFire:Show(icon)
			end

			if A.Trinket1:IsReady(player) and BurstIsON(unit) then
				return A.Trinket1:Show(icon)    
			end
			
			if A.Trinket2:IsReady(player) and BurstIsON(unit) then
				return A.Trinket2:Show(icon)    
			end	
			
			if A.MangleCat:IsReady(unit) then
				return A.MangleCat:Show(icon)
			end
			
			if A.Shred:IsReady(unit) and Unit(player):HasBuffs(A.OmenofClarity.ID) > 0 then
				return A.Shred:Show(icon)
			end
			
			if A.Rip:IsReady(unit) and Player:ComboPoints() >= 5 and Player:Energy() >= 80 then
				return A.Rip:Show(icon)
			end
			
			if A.Rip:IsReady(unit) and Player:ComboPoints() >= 4 and Player:Energy() >= 80 and Unit(unit):HasDeBuffs(A.MangleCat.ID) == 0 and Unit(unit):HasDeBuffs(A.MangleBear.ID) == 0 then
				return A.Rip:Show(icon)
			end
			
			if A.Shred:IsReady(unit) then
				return A.Shred:Show(icon)
			end
		
		end
		
		

	end


	if inCombat then 
		if RecoveryItems() then
			return true
		end
	end


    -- End on EnemyRotation()
    -- Heal Target 
    if IsUnitFriendly(target) then 
        unit = target 
        
        if HealingRotation(unit) then 
            return true 
        end 
    end  
	    
    -- Heal Mouseover
    if IsUnitFriendly(mouseover) then 
        unit = mouseover  
        
        if HealingRotation(unit) then 
            return true 
        end             
    end 
	
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
