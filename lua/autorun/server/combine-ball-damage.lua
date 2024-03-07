local addonName = "Combine Ball Damage"
local className = "prop_combine_ball"
local DMG_DISSOLVE = DMG_DISSOLVE
local band, bor
do
	local _obj_0 = bit
	band, bor = _obj_0.band, _obj_0.bor
end
local Simple = timer.Simple
local FCVAR_FLAGS = bor(FCVAR_ARCHIVE, FCVAR_NOTIFY)
local mp_combine_ball_damage = CreateConVar("mp_combine_ball_damage", "10000", FCVAR_FLAGS, "Sets the amount of damage caused by '" .. tostring(className) .. "'.", 15, 1000000)
local mp_combine_ball_player_protection = CreateConVar("mp_combine_ball_player_protection", "0", FCVAR_FLAGS, "Protects players against damage from his own '" .. tostring(className) .. "'.", 0, 1)
local mp_combine_ball_npc_protection = CreateConVar("mp_combine_ball_npc_protection", "0", FCVAR_FLAGS, "Protects NPCs against damage from his own '" .. tostring(className) .. "'.", 0, 1)
hook.Add("OnEntityCreated", addonName, function(self)
	if self:GetClass() ~= className then
		return
	end
	return Simple(0, function()
		if not self:IsValid() then
			return
		end
		local owner = self:GetOwner()
		if not owner:IsValid() or (mp_combine_ball_player_protection:GetBool() and owner:IsPlayer()) or (mp_combine_ball_npc_protection:GetBool() and owner:IsNPC()) then
			return
		end
		self[addonName] = owner
		return self:SetOwner()
	end)
end)
return hook.Add("EntityTakeDamage", addonName, function(self, damageInfo)
	local entity = damageInfo:GetInflictor()
	if not (entity:IsValid() and entity:GetClass() == className) then
		return
	end
	local owner = entity[addonName]
	if owner and owner:IsValid() then
		damageInfo:SetAttacker(owner)
		entity:SetOwner(owner)
		Simple(0, function()
			if entity:IsValid() then
				return entity:SetOwner()
			end
		end)
	end
	if band(damageInfo:GetDamageType(), DMG_DISSOLVE) == 0 then
		damageInfo:SetDamageType(bor(damageInfo:GetDamageType(), DMG_DISSOLVE))
	end
	return damageInfo:SetDamage(mp_combine_ball_damage:GetInt())
end)
