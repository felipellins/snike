
local composer = require("composer")
local scene = composer.newScene()
bd=require("banco")

local physics = require( "physics" )
physics.start()
physics.setGravity(0,0)
--physics.setDrawMode("hybrid")
  -- o nome do evento coloca na função
function scene:create(event)	
 

    local h=display.contentHeight
    local w=display.contentWidth 

cobra=nil
maca = nil
reposicaoComidaAtiva = false
pontuacao=0;
Pontos = display.newText("Pontos: "..pontuacao,60,-30)


  Cobra={}
  Maca={}
  Jogo={}

		-- essa função faz ela se movimentar inicialmente pra direita 
		function Cobra:movimentoInicial(event)

			if(cobra[1]~=nil)then

				cobra[1].x=cobra[1].x+10

			else
				timer.cancel(movimentoIn)
			end
		end



		--  essa é a cabeç da cobra 
		function Cobra:criarcobra()


			cobra={}

			cobra[1] = display.newImageRect("13.png",25,25)
			cobra[1].x=80
			cobra[1].y=100

			physics.addBody(cobra[1], "dynamic")
			cobra[1]:addEventListener("collision",Cobra)
			cobra[1].name="cobra"	

		end
       function mostrarPontos(pontuacao)
       
        Pontos.text ="Pontos: "..pontuacao 
    

       end


		function Cobra:collision(event)
			
				 -- a colisão tem duas fazer inicio e termino , se nao tivesse o if 
				 -- ele iriar chamar a função comer duas vezes. began e pro termino
					 if (event.other.name ~= "macã")then
					

							 finalizarjogo()
								
							
								
					  elseif(event.other.name=="macã")then


									if event.phase == "began" then

										

										rabo=display.newImageRect("13.png",20,20)	
								       
								        physics.addBody(rabo,"dynamic")
								      
								       -- inserer outro quadrado na cobra
								        rabo.name="rabo"
								        table.insert(cobra,rabo)
								        
                                  
										-- enviar pontos
										pontuacao=pontuacao+5	 
										mostrarPontos(pontuacao)

										--- o rabinho nascer atraz da cobra
										  cobra[#cobra].x = cobra[#cobra-1].x
										  cobra[#cobra].y = cobra[#cobra-1].y   		
									  
									 	   Maca.reposicionarComida()
									 




                                   end         

		                end

		 end


		function Maca:reposicionarComida()

			reposicaoComidaAtiva = true

			if(maca ~= nil)then
				
				timer.performWithDelay(0.05, function()

						maca.x = math.random(50,300)
				        maca.y = math.random(h/2)
			            reposicaoComidaAtiva = false
				end, 1)
		   end
			

		end

		    
		function Maca:criarcomida()
		  -- maca2={}

		   -- essa função e pra criar maça aleatoria 
		    maca = display.newImage("10.png",math.random(w), math.random(100),math.random(0,1))
		    physics.addBody(maca,"dynamic")
		    maca.name = "macã"
		    
		   

		end

		 -- essa função quando chamada faz ela se mover pra cima 
		function Cobra:movimentarCima(event)
			
		     if(#cobra >0 )then
			-- cabeça
			
			  
			  cobra[1].y = cobra[1].y - 10
		    --  restante do corpo
		                    -- aqui contem a direção
		    Cobra:movimentarCorpo(cobra[1].x, cobra[1].y)
		  
		    end
		end
		  
		   
		function Cobra:movimentarBaixo(event)
			 
		   if(#cobra >0)then
			
			 
				
				 cobra[1].y = cobra[1].y + 10
				 Cobra:movimentarCorpo(cobra[1].x, cobra[1].y)
		     
		    end
		end

		function Cobra:movimentarDireita(event)
			
			if(#cobra >0)then
			 
			 cobra[1].x = cobra[1].x +10
			 Cobra:movimentarCorpo(cobra[1].x, cobra[1].y)
             

		      
		   end
		end
		function Cobra:movimentarEsquerda(event)
			
		    if(#cobra >0)then

		  
			cobra[1].x = cobra[1].x -10
		    Cobra:movimentarCorpo(cobra[1].x, cobra[1].y)

		     
		    end	

		end

    -- essa função faz o copo se movimentar atras da cabeça
		function Cobra:movimentarCorpo(posX, posY)
			local auxX, auxY
			for i = 2, #cobra do
				
				auxX, auxY = cobra[i].x, cobra[i].y
               
                 cobra[i].x = posX
                 cobra[i].y = posY


                 posX=auxX
	             posY=auxY

	    	end
           

		end				


              -- essa função é para definir a direção de acordo com o butão a ser apertado
		function Cobra:tap(event)

			if(event.target.name=="butesquer")then

				timer.pause(movimentoIn)
				movimentoIn = timer.performWithDelay(100,Cobra.movimentarEsquerda,0)
			    -- movimentoIn.param = event.target.name

				elseif(event.target.name=="butdirei")then

					timer.pause(movimentoIn)
					movimentoIn = timer.performWithDelay(100,Cobra.movimentarDireita,0)
		           -- movimentoIn.param = event.target.name
					
					elseif(event.target.name=="butcim")then

						timer.pause(movimentoIn)
						movimentoIn = timer.performWithDelay(100,Cobra.movimentarCima,0)
		               	-- movimentoIn.param = event.target.name

						elseif(event.target.name=="butbai")then
							timer.pause(movimentoIn)
							movimentoIn= timer.performWithDelay(100,Cobra.movimentarBaixo,0)
		                 	-- movimentoIn.param = event.target.name
						
						end

		        

					end

		  function  finalizarjogo (event)
		  			         
					
					

						     display.remove(maca)
						     timer.pause(movimentoIn)
						     
						      
						      
						       for i=1 , #cobra do
						       
						         display.remove(cobra[i])
					     
					          end
		    
		         -- inserir´pontuação no banco
                 bd:inserir(pontuacao)
                 print(pontuacao)

                 --chamar  a tela fim de jogo em seguida remover a tela jogo
		         composer.gotoScene("fimdejogo")
		         composer.removeScene("jogo")
		  

		   end


		  function  Jogo:criarlinhas(event)
		  	
		  	  -- linhas horizontais
		  	  l1= display.newLine(0,-40,2*w,-40)    
		  	  --l1:setStrokeColor(0.2,0.2,0.80)
		  	  --l1.strokeWidth = 2
		  	  physics.addBody(l1,"static")
		      l1.name="linha"      


		  	  l2= display.newLine(0,310,2*w,310)
		  	 -- l2:setStrokeColor(0.2,0.2,0.80)
		  	 -- l2.strokeWidth = 2
		      physics.addBody(l2,"static")
		      l2.name="linha"  
		  

		    -- linhas verticais      
		    l3=display.newLine(0,0,0,2*h)
		    --l3:setStrokeColor(0.2,0.2,0.80)
		    --l3.strokeWidth = 2
		    physics.addBody(l3,"static")
		     l3.name="linha"  

		    l4=display.newLine(w,0,w,2*h)
		    --l4:setStrokeColor(0.2,0.2,0.80)
		    --l4.strokeWidth = 2
		    physics.addBody(l4,"static")
		    l4.name="linha"  
		   
		 

		end



		function Jogo:criarbutoes(event)
			
		    fundo =display.newImageRect("fundo.png",400,800)
            fundo.x=120
	        fundo.y=140

			butesquerda =display.newImageRect("20.png",80,80)
			butesquerda.name="butesquer"
			
			butesquerda.x=60
			butesquerda.y=400

			butdireita =display.newImageRect("21.png",80,80)-- retangulo
			butdireita.name="butdirei"
			butdireita.x=240
			butdireita.y=400

			butcima =display.newImageRect("22.png",80,80)
			butcima.name="butcim"
			butcima.x=150
			butcima.y=350

			butbaixo =display.newImageRect("23.png",80,80)
			butbaixo.name="butbai"
			butbaixo.x=150
			butbaixo.y=450

			butesquerda:addEventListener("tap",Cobra)
			butdireita :addEventListener("tap",Cobra)
			butcima:addEventListener("tap",Cobra)
			butbaixo:addEventListener("tap",Cobra)

		  

		end

		 Maca.criarcomida()
		 Jogo.criarbutoes()

		movimentoIn=  timer.performWithDelay(100,Cobra.movimentoInicial,0)
		Cobra.criarcobra()
		Jogo.criarlinhas()

 

end
 

function scene:destroy(event)
   

     	 display.remove(butesquerda)
         display.remove(butdireita)
         display.remove(butcima)
         display.remove(butbaixo)
         display.remove(l1)
         display.remove(l2)
         display.remove(l3)
         display.remove(l4)
         display.remove(Pontos)         
       

     end 

    
    scene:addEventListener("create",scene)
    scene:addEventListener("destroy",scene)	
	

return scene