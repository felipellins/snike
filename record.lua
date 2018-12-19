local composer = require( "composer" )
local scene = composer.newScene()

local w = display.contentWidth
local h = display.contentHeight


function scene:create( event )

    
      fundo =display.newImageRect("fundo.png",400,800)
      fundo.x=120
      fundo.y=140
  
      local li1 = display.newLine(1,0,1,265)
      local li2 = display.newLine(w-1,0,w-1,265)
      local lih1 = display.newLine(0,0,w,0)
      local lih2 = display.newLine(0,30,w,30)
      local lih3 = display.newLine(0,70,w,70)
     


        butmenu = display.newImageRect("menu.png",120,120) 
        butmenu.x = w/2
        butmenu.y = 330
        
        butmenu:addEventListener("tap",menu)

        recordText = display.newText("Melhor",display.contentCenterX*0.5,15)
        pontosText = display.newText("Pontuação",display.contentCenterX*1.5,15)

       -- local mostrarid = bd:pegarId()
       

       
        local mostrarPontos = bd:pegarPontuacao()
        print("pegou")

       local y = 50

       local  n=1

            recordValor = display.newText(n.."º",display.contentCenterX*0.5,y)
            
           
        for p,v in pairs(mostrarPontos) do
          for p1,v1 in pairs(v) do

           
            valores = display.newText(v1,display.contentCenterX*1.5,y)
            print(p1,v1)

           
          end
        
        end
  


end


function scene:destroy( event )

    
        display.remove(li1)
        display.remove(li3)
        display.remove(lih1)
        display.remove(lih2)
        display.remove(lih3)
        
         display.remove(butmenu)
           display.remove(pontosText)
           display.remove(valores)
              display.remove(recordText)
              display.remove(recordValor) 
             display.remove(v1) 
             delete()

end

function delete()
   display.remove(valores)
end

function menu()
  
  composer.removeScene("record")
  composer.gotoScene( "menu" )

end


scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )

    return scene