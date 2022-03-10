local class = "prop_combine_ball"
local timer_Simple = timer.Simple
local IsValid = IsValid

local hookName = class .. "_owner_damage"
hook.Add("OnEntityCreated", hookName, function( ent )
    if (ent:GetClass() == class) then
        timer_Simple(0, function()
            if IsValid( ent ) then
                ent.Attacker = ent:GetOwner()
                ent:SetOwner()
            end
        end)
    end
end)

hook.Add("EntityTakeDamage", hookName, function( ent, dmg )
    if (ent:GetClass() == class) and IsValid( ent.Attacker ) then
        dmg:SetAttacker( ent.Attacker )
    end
end)