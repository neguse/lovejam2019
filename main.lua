local camera = require "camera"
local player = require "player"
local input = require "input"
local draw = require "draw"
local map = require "map"

local dr = draw.new()
local cam = camera.new()
local world = love.physics.newWorld(0, -1000, true)
local map = map.new(world)
local inp = input.new()
local pl = player.new(world, inp, dr, cam)

function beginContact(a, b, coll)
	local ao, bo = a:getUserData(), b:getUserData()
	if not ao or not bo or not ao.getType or not bo.getType then
		return
	end
	local at, bt = ao:getType(), bo:getType()
	if at == "P" then
		ao:onContact(bo)
	elseif bt == "P" then
		bo:onContact(ao)
	end
end

function endContact(a, b, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll, normalImpulse, tangentImpulse)
end

world:setCallbacks(beginContact, endContact, preSolve, postSolve)

function love.load()
	pl:setRespawnPoint(map:getStartPoint())
	pl:respawn()
end

function love.update(dt)
	world:update(dt)
	map:update(dt)
	inp:update()
	pl:update(dt)
	cam:update(dt)
end

function love.draw()
	cam:push()

	dr:grid()

	pl:render()
	map:render()
	love.graphics.print("Hello World こんにちは！！！", 400, 300)

	cam:pop()
	pl:renderui()
end
