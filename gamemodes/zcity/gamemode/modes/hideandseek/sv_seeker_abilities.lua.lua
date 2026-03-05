local MODE = MODE
MODE.SendFootStepEvery = 3
-- MODE.SendFootStepEvery = 1

util.AddNetworkString("HS_Professions_Abilities_AddFootstep")
util.AddNetworkString("HS_Professions_Abilities_DisplayOrganismInfo")

function MODE.DisplayOrganismInfo(organism, ply)
	local text_info = ""
	text_info = text_info .. " Saturation" .. organism.o2 .. "\n"
	
	net.Start("HS_Professions_Abilities_DisplayOrganismInfo")
		net.WriteString(text_info)
	net.Send(ply)
end

--\\
hook.Add("HG_PlayerFootstep_Notify", "HS_Professions_Abilities", function(ply, pos, foot, snd, volume, filter)
	ply.ProfessionAbility_FootstepsAmt = ply.ProfessionAbility_FootstepsAmt or 0
	ply.ProfessionAbility_FootstepsAmt = ply.ProfessionAbility_FootstepsAmt + 1
	
	if(ply.ProfessionAbility_FootstepsAmt >= MODE.SendFootStepEvery)then
		ply.ProfessionAbility_FootstepsAmt = 0
		
		net.Start("HS_Professions_Abilities_AddFootstep")
			net.WriteVector(pos)
			net.WriteFloat(ply:EyeAngles().y)
			net.WriteBool(foot == 0)
			
			local character_color = ply:GetNWVector("PlayerColor")
			
			if(!IsColor(character_color))then
				character_color = Color(character_color[1] * 255, character_color[2] * 255, character_color[3] * 255)
			end
			
			net.WriteColor(character_color, false)
			
			local recepients = {}
			
			for _, recepient_ply in player.Iterator() do
				if(recepient_ply:Team() == 0 and recepient_ply != ply or recepient_ply.role == "seeker")then
					recepients[#recepients+1] = recepient_ply
				end
			end
		net.Send(recepients)
	end
end)