
local timer_Simple = timer.Simple
local IsValid = IsValid

local addonName = "Combine Ball Damage"
local combineBallClass = "prop_combine_ball"

hook.Add( "OnEntityCreated", addonName, function( entity )
    if entity:GetClass() ~= combineBallClass then return end

    timer_Simple( 0, function()
        if not IsValid( entity ) then return end
        local ply = entity:GetOwner()
        if IsValid( ply ) and ply:IsPlayer() then
            entity[ addonName ] = ply
            entity:SetOwner()
        end
    end )
end )

local ballDamage = CreateConVar( "mp_combine_ball_damage", "10000", FCVAR_ARCHIVE, "Sets the amount of damage caused by '" .. combineBallClass .. "'.", 15, 1000000 )
local DMG_DISSOLVE = DMG_DISSOLVE
local bit_band = bit.band

hook.Add( "EntityTakeDamage", addonName, function( _, damageInfo )
    if bit_band( damageInfo:GetDamageType(), DMG_DISSOLVE ) ~= DMG_DISSOLVE then return end

    local entity = damageInfo:GetInflictor()
    if IsValid( entity ) and entity:GetClass() == combineBallClass then
        local ply = entity[ addonName ]
        if IsValid( ply ) then
            timer_Simple( 0, function()
                if not IsValid( entity ) then return end
                entity:SetOwner()
            end )

            damageInfo:SetAttacker( ply )
            entity:SetOwner( ply )
        end

        damageInfo:SetDamage( ballDamage:GetInt() )
    end
end )
