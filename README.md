# gmod_combine_ball_damage
Removes the protection of shooter, which makes pulse rifle more realistic.

## Minified Lua Code
```lua
local a,i,b=timer.Simple,IsValid,"prop_combine_ball" local c=b.."_owner_damage"hook.Add("OnEntityCreated",c,function(d)if d:GetClass()==b then local e=nil;a(0,function()if i(d)then e=d:GetOwner()d:SetOwner()end end)a(0.05,function()if i(d)and i(e)then e:SetVelocity(-d:GetVelocity())end end)end end)
```
