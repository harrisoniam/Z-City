include("shared.lua")

local laserMaterial = CreateMaterial("tripmine_laser", "UnlitGeneric", {
	["$basetexture"] = "sprites/laserbeam",
	["$additive"] = "1",
	["$vertexcolor"] = "1",
	["$vertexalpha"] = "1",
	["$nocull"] = "1",
	["$brightness"] = "64",
	["$textureScrollRate"] = "25.6",
})

function ENT:Draw()
	self:DrawModel()
	if not self.TraceStart or not self.TraceHitPos then return end
	if self:GetNWFloat("Safety",CurTime()) >= CurTime() then return end
	
	render.SetMaterial(laserMaterial)
	render.DrawBeam(
		self.TraceStart,
		self.TraceHitPos,
		0.35,
		0,
		1,
		Color(255, 55, 52, 64)
	)
end