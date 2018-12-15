local composer = require("composer")
local scene = composer.newScene()


  function iniciarmenu( )
    
       composer.removeScene("fimdejogo")
       composer.gotoScene("menu")


  end

  function reiniciar()
   composer.gotoScene("jogo")
   composer.removeScene("fimdejogo")
  	
  end
  function sair()
  	os.exit()
  	
  end


  function scene:create(event)


  fundo =display.newImageRect("fundo.png",400,800)
  fundo.x=120
	fundo.y=140

	butjogar =display.newImageRect("jogar.png",160,100)
	butjogar.x=160
	butjogar.y=260

	butmenu =display.newImageRect("menu.png",120,120)-- retangulo
	butmenu.x=250
	butmenu.y=400

	butsai =display.newImageRect("sair.png",120,120)
	butsai.x=80
	butsai.y=400
    
    slog =display.newImageRect("cobra.png",600,600)
    slog.x=120
	  slog.y=140


	  butjogar:addEventListener("tap",reiniciar)
    butmenu:addEventListener("tap",iniciarmenu)
    butsai:addEventListener("tap",sair)

  end
   
  
  
  function scene:destroy(event)
   	
    butjogar:removeEventListener("tap",reiniciar)
    butmenu:removeEventListener("tap",iniciarmenu)
    butsai:removeEventListener("tap",sair)

     deletartela()
   end


  function deletartela()
   	display.remove(butsai)
    display.remove(butmenu)
    display.remove(butjogar)
    display.remove(slog)
    display.remove(fundo)
   	
   end

  scene:addEventListener("create",scene)
  scene:addEventListener("destroy",scene)




return scene