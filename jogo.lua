
local composer = require("composer")
local scene = composer.newScene()

local physics = require( "physics" )
physics.start()
physics.setGravity(0,0)
--physics.setDrawMode("hybrid")
  
function scene:create(event)	
 

    local h=display.contentHeight
    local w=display.contentWidth 

cobra=nil
maca = nil
reposicaoComidaAtiva = false
cont=0;
Pontuacao= display.newText("Pontos: "..cont,60,-30)




 

		-- essa função faz ela se movimentar inicialmente pra direita 
		function movimentoInicial(event)

			if(cobra[1]~=nil)then

				cobra[1].x=cobra[1].x+5

			else
				timer.cancel(movimentoIn)
			end
		end



		--  essa é a cabeç da cobra 
		function criarcobra()


			cobra={}

			cobra[1] = display.newImageRect("1.png",25,25)
			cobra[1].x=80
			cobra[1].y=100

			physics.addBody(cobra[1], "dynamic")
			cobra[1]:addEventListener("collision", alimentar)
			cobra[1].name="cobra"	

		end
       function mostrarPontuacao(cont)
       
        Pontuacao.text ="Pontos: "..cont     
    

       end


		function alimentar(event)
			
				 -- a colisão tem duas fazer inicio e termino , se nao tivesse o if 
				 -- ele iriar chamar a função comer duas vezes. began e pro termino
					 if (event.other.name == "macã")then
						
							if event.phase == "began" then
								
								-- inserer outro quadrado na cobra
									
						        table.insert(cobra,display.newImageRect("13.png",20,20))
								-- enviar pontos
								cont=cont+5	 
								mostrarPontuacao(cont)

								--- o rabinho nascer atraz da cobra
								  cobra[#cobra].x = cobra[#cobra-1].x 
								  cobra[#cobra].y = cobra[#cobra-1].y   		
							  
							 	   reposicionarComida()
							 
                           end         

		            end

		 end


		function reposicionarComida()

			reposicaoComidaAtiva = true

			if(maca ~= nil)then
				
				timer.performWithDelay(0.05, function()

						maca.x = math.random(50,300)
				        maca.y = math.random(h/2)
			            reposicaoComidaAtiva = false
				end, 1)
		   end
			

		end

		    
		function criarcomida()
		  -- maca2={}

		   -- essa função e pra criar maça aleatoria 
		    maca = display.newImage("10.png",math.random(w), math.random(100),math.random(0,1))
		    physics.addBody(maca,"dynamic")
		    maca.name = "macã"
		    
		   
			 maca:addEventListener("collision", alimentar)

		end

		     
		     	
		     	-- body
		   

		 -- essa função quando chamada faz ela se mover pra cima 
		function movimentarCima(event)
			
		     if(#cobra >0)then
			-- cabeça
			
			  
			  cobra[1].y = cobra[1].y - 5
		    --  restante do corpo
		                    -- aqui contem a direção
		    movimentarCorpo(cobra[1].x, cobra[1].y)
		  
		    end
		end
		  
		   
		function movimentarBaixo(event)
			 
		   if(#cobra >0)then
			
			 
				
				cobra[1].y = cobra[1].y + 5
				 movimentarCorpo(cobra[1].x, cobra[1].y)
		     
		    end
		end

		function movimentarDireita(event)
			
			if(#cobra >0)then
			 
			 cobra[1].x = cobra[1].x +5
			 movimentarCorpo(cobra[1].x, cobra[1].y)
             

		      
		   end
		end
		function movimentarEsquerda(event)
			
		    if(#cobra >0)then

		  
			cobra[1].x = cobra[1].x -5
		    movimentarCorpo(cobra[1].x, cobra[1].y)

		     
		    end	

		end


     --Tu tem que fazer o seguinte: faz a subtração e ve qual das
   -- posicoes x ou y é 0 pra tu saber se ta mechendo na coluna ou na linha
   --Sabendo se ta na linha ou coluna faz a conta com o outro valor pra 
   --ver se ta indo pra cima ou pra baixo ou esquerda ou direita
  -- Dica: faz um if pra coluna ou linha primeiro e depois v o lado em outro if
    --Rodrigo:		 Ou seja 2 if pra cada
     --Tipo se posX - auxX == 0 ta na coluna indo pra cima ou pra baixo
		function movimentarCorpo(posX, posY)
			local auxX, auxY
			for i = 2, #cobra do
				
				auxX, auxY = cobra[i].x, cobra[i].y
               
              if(auxX-posX ==0)then
              --coluna
				   
				   if (auxY-posY < 0)then
				   --cima
				   cobra[i].y = posY+20
				 
                  end

                   if(auxY-posY>0)then
                   	-- baixo
                   	cobra[i].y = posY-20
                  
				   end
                   cobra[i].x=posX  
				  
              end

				  if(auxY-posY ==0)then
	               -- linha     
	                    if(auxX-posX > 0)then
	                    -- direita
					    cobra[i].x = posX -20
	                    
	                    end     
	                    if(auxX-posX <0)then
	                   -- esquerda
	                    cobra[i].x = posX +20
	                    
	                    end
	                
	               cobra[i].y = auxY
	               end


                   posX=auxX
	               posY=auxY

	    	end
           

		end	
			







			-- -- A cobra é um vetor
			-- if #cobra > 1 then									  
							
			-- 				if(direcao=="butesquer")then

		 --                   -- posXAnterior = cobra[1].x
			-- 		       -- posYAnterior = cobra[1].y	
			-- 				--cobra[i].x =posXAnterior+20
			-- 				--cobra[i].y =posYAnterior

		 --                   for i=2, #cobra do

		 --                   cobra[i].x = cobra[i-1].x+20  -- cabeça menos ela 
			-- 			   cobra[i].y = cobra[i-1].y   -- cabeça menos ela 							
							
		 --                  end

		 --                 end
							
		              
		 --               for i=2, #cobra do

		     
		 --                   if(direcao=="butdirei")then
		                     
		 --                         cobra[i].x = cobra[i-1].x-20     -- cabeça menos ela 
			-- 			         cobra[i].y = cobra[i-1].y    -- cabeça menos ela 
					       
			-- 		      -- posXAnterior = cobra[i-1].x
			-- 		      -- posYAnterior = cobra[i-1].y

			-- 		      -- cobra[i].x = posXAnterior-20
			-- 			  -- cobra[i].y = posYAnterior

		 --                 end     
		 --              end
		                   
		                  
		 --                 for i=2, #cobra do

		 --                    if(direcao=="butcim")then
		 --                   cobra[i].x = cobra[i-1].x    -- cabeça menos ela 
			-- 			   cobra[i].y = cobra[i-1].y+20    -- cabeça menos ela 

			-- 				-- posXAnterior = cobra[i-1].x
			-- 		         --posYAnterior = cobra[i-1].y

					     
		 --                   -- cobra[i].x = posXAnterior
			-- 			   -- cobra[i].y = posYAnterior+20
					     
					
		 --                  end

		 --             end

		 --             for i=2, #cobra do
		                   
		 --                    if(direcao=="butbai")then
		                   

		 --                    cobra[i].x = cobra[i-1].x     -- cabeça menos ela 
			-- 				cobra[i].y = cobra[i-1].y-20    -- cabeça menos ela 
					
					     
			-- 		      --  posXAnterior = cobra[i-1].x
			-- 		      --  posYAnterior = cobra[i-1].y

			-- 		       -- cobra[i].x = posXAnterior
			-- 				--cobra[i].y = posYAnterior-20
		     
		 --              end

		 --                    end



		 --             --   posXAnterior = 0   -- guardar posição
			-- 		 --  posYAnterior = 0   -- guardar posição



			-- 		--	else
			-- 		--		cobra[i].x = cobra[posXAnterior].x-20
			-- 		--		cobra[i].y = cobra[posYAnterior].y-20
							

			-- 		--	

			-- 			--end

					


			-- end

		


		function movimentarCobra(event)

			if(event.target.name=="butesquer")then

				timer.pause(movimentoIn)
				movimentoIn = timer.performWithDelay(100,movimentarEsquerda,0)
			    -- movimentoIn.param = event.target.name

				elseif(event.target.name=="butdirei")then

					timer.pause(movimentoIn)
					movimentoIn = timer.performWithDelay(100,movimentarDireita,0)
		           -- movimentoIn.param = event.target.name
					
					elseif(event.target.name=="butcim")then

						timer.pause(movimentoIn)
						movimentoIn = timer.performWithDelay(100,movimentarCima,0)
		               	-- movimentoIn.param = event.target.name

						elseif(event.target.name=="butbai")then
							timer.pause(movimentoIn)
							movimentoIn= timer.performWithDelay(100,movimentarBaixo,0)
		                 	-- movimentoIn.param = event.target.name
						
						end

		        

					end

		  function  finalizarjogo (event)
		  			         
					
						 if(event.other.name ~="maçã")then

						     display.remove(maca)
						     timer.pause(movimentoIn)
						     
						      
						      
						       for i=1 , #cobra do
						       
						         display.remove(cobra[i])
					     
					          end
		    
		         

		         composer.gotoScene("fimdejogo")
		         composer.removeScene("jogo")
		     end

		   end


		  function  criarlinhas(event)
		  	
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


		    l1:addEventListener("collision",finalizarjogo)
			l2:addEventListener("collision", finalizarjogo)
		    l3:addEventListener("collision", finalizarjogo)
		    l4:addEventListener("collision",finalizarjogo)

		   

		 

		end



		function criarbutoes(event)
			
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

			butesquerda:addEventListener("tap",movimentarCobra)
			butdireita :addEventListener("tap",movimentarCobra)
			butcima:addEventListener("tap",movimentarCobra)
			butbaixo:addEventListener("tap",movimentarCobra)

		  

		end

		criarcomida()
		criarbutoes()

		movimentoIn=  timer.performWithDelay(100,movimentoInicial,0)
		criarcobra()
		criarlinhas()

 

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
         
       

     end 

    
    scene:addEventListener("create",scene)
    scene:addEventListener("destroy",scene)	
	

return scene