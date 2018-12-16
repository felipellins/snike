local composer = require("composer")
local scene = composer.newScene()

  function scene:create(event)
	
  
  	
  		
    fundo =display.newImageRect("fundo.png",400,800)
    fundo.x=120
	fundo.y=140

	butstart =display.newImageRect("start.png",120,120)
	butstart.name="butrecord"
	
	butstart.x=160
	butstart.y=260

	butrecord =display.newImageRect("record.png",120,120)-- retangulo
	butrecord.name="butrecord"
	butrecord.x=250
	butrecord.y=400

	butsair =display.newImageRect("sair.png",120,120)
	butsair.name="butsair"
	butsair.x=80
	butsair.y=400
    
    slog =display.newImageRect("cobra.png",600,600)
    slog.x=120
	  slog.y=140


	butstart:addEventListener("tap",iniciar)
	butsair:addEventListener("tap",fecharjogo)
	butrecord:addEventListener("tap",record)

	

   end

   function fecharjogo()
   	os.exit()

   end

   
   function scene:destroy(event)
   	
    butstart:removeEventListener("tap",iniciar)
    butsair:removeEventListener("tap",sair)
    butrecord:removeEventListener("tap",record)
     deletartela()
   end
   
   function deletartela()
    display.remove(fundo)
   	display.remove(butstart)
    display.remove(butrecord)
    display.remove(butsair)
    display.remove(slog)
   	
   end
   function sair()
   
   	os.exit()
   end
   

   function record()
  
  composer.gotoScene( "record" )
  composer.removeScene("menu")
    
    end


	function iniciar()
		
		composer.gotoScene("jogo")
		composer.removeScene("menu")
	end
 
     

 scene:addEventListener("create",scene)
 scene:addEventListener("destroy",scene)
  

return scene