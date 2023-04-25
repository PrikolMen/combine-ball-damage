local timer_Simple = timer.Simple
local IsValid = IsValid

local addonName = 'Combine Ball Damage'
local combineBallClass = 'prop_combine_ball'

hook.Add( 'OnEntityCreated', addonName, function( ent )
    if ent:GetClass() ~= combineBallClass then return end

    timer_Simple( 0, function()
        if not IsValid( ent ) then return end

        local owner = ent:GetOwner()
        if IsValid( owner ) and owner:IsPlayer() then
            ent:SetOwner()
        end
    end )
end )

local ballDamage = CreateConVar( 'sv_combine_ball_damage', '10000', FCVAR_ARCHIVE, ' - Sets the damage value for ' .. combineBallClass .. '.', 15, 1000000 )
local DMG_DISSOLVE = DMG_DISSOLVE
local bit_band = bit.band

hook.Add( 'EntityTakeDamage', addonName, function( ent, dmg )
    if not IsValid( ent ) then return end
    if bit_band( dmg:GetDamageType(), DMG_DISSOLVE ) ~= DMG_DISSOLVE then return end

    local infl = dmg:GetInflictor()
    if IsValid( infl ) and infl:GetClass() == combineBallClass then
        dmg:SetDamage( ballDamage:GetInt() )
    end
end )