-- Class may not be needed
local CLASS = player.RegClass("hostage")

--local tauntTime = CurTime() + math.random(40,140)

function CLASS.Off(self)
    if CLIENT then return end
    --hook.Remove("hs_taunt")
end

function CLASS.On(self)
    if CLIENT then return end

    local owner = hg.GetCurrentCharacter(self) -- huh?

    --[[
    hook.Add("Player Think","hs_taunt",function(ply)
        --print(self:Alive())
        if not IsValid(owner) or not self:Alive() then hook.Remove("Player Think","hs_taunt") return end
        
        
        local taunts = {
        --    "zcitysnd/male/cough_"..math.random(1,2)..".mp3",
        --    "snd_jack_hmcd_fart.wav",
        --    "snd_jack_hmcd_burp.wav"
        --}

        local event = taunts[math.random(#taunts)]

        if CurTime() >= tauntTime then
            owner:EmitSound(event)
            tauntTime = CurTime() + math.random(40,140)
            --print("Farted, new time is "..tauntTime)
        end
    end)]]

    self:SetPlayerColor(Color(45,200,45):ToVector())
    ApplyAppearance(self)
end

CLASS.CanUseDefaultPhrase = true
CLASS.CanEmitRNDSound = true
CLASS.CanUseGestures = true

function CLASS.Guilt(self, Victim)
    if CLIENT then return end
end

