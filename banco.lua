local bancoDados = {}

require("sqlite3")
local  caminho = system.pathForFile("dados.db",system.DocumentsDirectory)
local  banco = sqlite3.open(caminho)


local tabela = [[CREATE TABLE IF NOT EXISTS tabpontuacao(cont NOT NULL);]]
banco:exec(tabela)

--local remover = [[DELETE FROM tabelaPontuacao]]
--banco:exec(remover)

function bancoDados:adicionar( cont )


	if #mostrarPontos < 4 then

	--local insert = [[INSERT INTO tabpontuacao (cont) VALUES (]] ..cont.. [[);]]
        local  a= [[ INSERT INTO tabpontuacao VALUES (NULL, cont)]];
	
	banco:exec(a)
		    print(cont)
end

end

mostrarPontos = {}


function bancoDados:pegarCont()
  print("entrouco")

   for lin in banco:nrows("SELECT * FROM tabpontuacao ") do
	
    
     mostrarPontos[#mostrarPontos+1] = 
   { a = lin.cont }


 end

return mostrarPontos

end


return bancoDados