local timer_Simple = timer.Simple
local math_floor = math.floor
local IsValid = IsValid

local class = "prop_combine_ball"
local hookName = class .. "_owner_damage"

hook.Add("OnEntityCreated", hookName, function( ent )
    if (ent:GetClass() == class) then
        timer_Simple(0, function()
            if IsValid( ent ) then
                local att = ent:GetOwner()
                if IsValid( att ) and att:IsPlayer() then
                    local owner = ent:GetOwner()
                    ent:SetOwner()

                    timer_Simple(0.05, function()
                        if IsValid( ent ) and IsValid( owner ) then
                            local vel = -ent:GetVelocity() / 3
                            vel[3] = math_floor( vel[3] / 2 )
                            owner:SetVelocity( vel )
                        end
                    end)
                end
            end
        end)
    end
end)
