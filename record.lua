local composer = require( "composer" )
local scene = composer.newScene()

local w = display.contentWidth
local h = display.contentHeight


function scene:create( event )

	
	    local li1 = display.newLine(1,0,1,265)
      local li2 = display.newLine(w-1,0,w-1,265)
      local li3 = display.newLine(w/2,0,w/2,265)
      local lih1 = display.newLine(0,0,w,0)
      local lih2 = display.newLine(0,30,w,30)
      local lih3 = display.newLine(0,70,w,70)
      local lih4 = display.newLine(0,120,w,120)
      local lih5 = display.newLine(0,170,w,170)
      local lih6 = display.newLine(0,215,w,215)
      local lih7 = display.newLine(0,265,w,265)


        butaomenu = display.newImageRect("menu.png",120,120) 
        butaomenu.x = w/2
        butaomenu.y = 330
        
        butaomenu:addEventListener("tap",menu)

        rankigText = display.newText("Ranking",display.contentCenterX*0.5,15)
        pontuacaoText = display.newText("Pontuação",display.contentCenterX*1.5,15)

       -- local mostrarId = bd:pegarId()
       

       
        local mostrarPontos = bd:pegarCont()
        print("pegou")

        local y = 50

        for n=1,5 do

            rankigValor = display.newText(n.."º",display.contentCenterX*0.5,y)
            
           
          y = y + 50
        end


        local y1 = 50

        for k,v in pairs(mostrarPontos) do
          for k1,v1 in pairs(v) do

            pontuacaoValor = display.newText(v1,display.contentCenterX*1.5,y1)
            print(k1,v1)
           
          end
          y1 = y1 + 50
        end



end


function scene:destroy( event )

	   
        display.remove(li1)
        display.remove(li2)
        display.remove(li3)
        display.remove(lih1)
        display.remove(lih2)
        display.remove(lih3)
        display.remove(lih4)
        display.remove(lih5)
        display.remove(lih6)
        display.remove(lih7)

          display.remove(butaomenu)
           display.remove(pontuacaoText)
            display.remove(pontuacaoValor)
              display.remove(rankigText)
              display.remove(rankigValor)   

end


function menu()
	composer.removeScene("record")
	composer.gotoScene( "menu" )

end


scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )

    return scene