local class = "prop_combine_ball"
local timer_Simple = timer.Simple
local IsValid = IsValid

hook.Add("OnEntityCreated", class .. "_owner_damage", function(ent)
    if (ent:GetClass() == class) then
        timer_Simple(0, function()
            if IsValid( ent ) then
                ent:SetOwner()
            end
        end)
    end
end)