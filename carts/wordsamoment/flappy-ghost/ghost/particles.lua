---- GHOST PARTICLE CALCULATIONS -----------------------
function spawnGhostParticles()
	if TIMER.ghost_particle_spawn_time == 0 then
		add(GHOST_PARTICLES, { x = GHOST.x + 1 - rnd(2), y = GHOST.y + 6 + rnd(2), speed = 0.1, life = 40 })
		TIMER.ghost_particle_spawn_time = 1
	end
end

function moveGhostParticles()
	for particle in all(GHOST_PARTICLES) do
		particle.x -= particle.speed
		particle.y = GHOST.y + 6 + flr(((time() / 0.5) % 2))
		-- this needs a line equation where ghost is 0,0
		-- f(x) = ax+b
		-- f(Ghost.x) = Ghost.y
		particle.life -= 1
		if particle.life < 0 then
			del(GHOST_PARTICLES, particle)
		end
	end
end

function drawGhostParticles()
	for particle in all(GHOST_PARTICLES) do
		pset(particle.x, particle.y, COLORS.grey)
	end
end