--funktioita kutsutaan kerran pelin alussa
--🤣
function love.load ()
	leveys = 20
	korkeus = 15
	reset()
end
 
function reset ()

	mato = {
	{x = 3, y= 1},
	{x = 2, y= 1},
	{x = 1, y= 1},
	}
	
	suunta = 'right'
	ajastin = 0
	aikaraja = 0.15
	ruoki()
	
end

--funktio ruoan spawnaamiseen
function ruoki()

	ruoka={}
	
	ruokaX=love.math.random(1,leveys)
	ruokaY=love.math.random(1,korkeus)
	
	ruoka.x=ruokaX
	ruoka.y=ruokaY
	--pisteen lis�ys
	
end

--funktio peliframien piirt�miseen
function love.draw ()

	local ruutu = 15
	
	love.graphics.setColor(.28,.28,.28)
	
	love.graphics.rectangle('fill',0,0,leveys*ruutu,korkeus*ruutu)
	
	local function piirraRuutu(x,y)
		love.graphics.rectangle('fill',(x-1)*ruutu,(y-1)*ruutu,ruutu-1,ruutu-1)
	end
	
	love.graphics.setColor(1,.3,.3)
	piirraRuutu(ruoka.x,ruoka.y)
	
	for indekksi,matopala in ipairs(mato) do
		love.graphics.setColor(0.6,0.9,0.32)
		piirraRuutu(matopala.x,matopala.y)
	end
end

function love.update(dt)

	ajastin=ajastin+dt

	if ajastin>=aikaraja then
		
		ajastin=ajastin-aikaraja
	
		local seuraavaX = mato[1].x
		local seuraavaY = mato[1].y
		
		pelijatkuu=true
	
		if suunta == 'right' then
			seuraavaX=seuraavaX+1
			if seuraavaX > leveys then
				--gameover
				pelijatkuu=false
			end
		
		elseif suunta == 'left' then
			seuraavaX=seuraavaX-1
			if seuraavaX < 1 then
				--gameover
				pelijatkuu=false
			end
		
		elseif suunta == 'down' then
			seuraavaY=seuraavaY+1
			if seuraavaY > korkeus then
				--gameover
				pelijatkuu=false
			end
		
		elseif suunta == 'up' then
			seuraavaY=seuraavaY-1
			if seuraavaY < 1 then
				--gameover
				pelijatkuu=false
			end
		end
		
		if pelijatkuu then
			table.insert(mato,1,{x=seuraavaX,y=seuraavaY})
			if mato [1].x==ruoka.x and mato [1].y==ruoka.y then
				ruoki ()
				if aikaraja>0.2 then
					aikaraja=aikaraja-0.1
				end
			else
			table.remove(mato)
			end
		end
	end
end

function love.keypressed(key)
	if key=='right'and pelijatkuu and suunta~='left'then
		suunta='right'
	elseif key=='left'and pelijatkuu and suunta ~='right'then
		suunta='left'
	elseif key=='down'and pelijatkuu and suunta ~='up'then
		suunta='down'
	elseif key=='up'and pelijatkuu and suunta~='down'then
		suunta='up'
	end
end










