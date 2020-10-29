--funktioita kutsutaan kerran pelin alussa
--ğŸ¤£
function love.load ()
	leveys = 40
	korkeus = 21
	love.window.setMode(leveys*40,korkeus*40)
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
	pisteet=0
	ruoki()
	
end

--funktio ruoan spawnaamiseen
function ruoki()

	ruoka={}
	
	ruokaX=love.math.random(1,leveys)
	ruokaY=love.math.random(1,korkeus)
	
	local voiRuokkia=true
	
	for indeksi,matopala in ipairs(mato)do
		if ruokaX==matopala.x and ruokaY==matopala.y then
			voiRuokkia=false
		end
	end
	
	if voiRuokkia then
		ruoka.x=ruokaX
		ruoka.y=ruokaY
	else
		ruoki()
	end
	
end

--funktio peliframien piirtämiseen
function love.draw ()

	local ruutu = 40
	
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
	
	love.graphics.print(pisteet,(leveys-1)*ruutu,0)
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
		
		for indeksi,matopala in ipairs (mato) do
			if indeksi~= #mato and seuraavaX==matopala.x and seuraavaY==matopala.y then
				pelijatkuu=false
			end
		end
		--tämä suoritetaan niin kauan kuin ei ole osuttu reunaan tai itseen
		if pelijatkuu then
			table.insert(mato,1,{x=seuraavaX,y=seuraavaY})
			if mato [1].x==ruoka.x and mato [1].y==ruoka.y then
				pisteet=pisteet+1
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
--funktio liikkumiseen
function love.keypressed(key)
	if key=='right'and pelijatkuu and suunta~='left'then
		suunta='right'
	elseif key=='left'and pelijatkuu and suunta ~='right'then
		suunta='left'
	elseif key=='down'and pelijatkuu and suunta ~='up'then
		suunta='down'
	elseif key=='up'and pelijatkuu and suunta~='down'then
		suunta='up'
	elseif key=='return'then
		reset()
	end
end





