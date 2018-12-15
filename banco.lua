local bancoDeDados = {}

local  sqlite3 = require("sqlite3")
local  caminho = system.pathForFile("dados.db",system.DocumentsDirectory)
local  banco = sqlite3.open(caminho)


local tabela = [[CREATE TABLE IF NOT EXISTS tabelaPontuacao(pontuacao NOT NULL);]]
banco:exec(tabela)

--local remover = [[DELETE FROM tabelaPontuacao]]
--banco:exec(remover)

function bancoDeDados:adicionar( cont )


	if #mostrarPontos < 4 then

	local insertQuery = [[INSERT INTO tabelaPontuacao (pontuaca) VALUES (]] ..pontuacao.. [[);]]
    print(insertQuery)
	banco:exec(insertQuery)
		
end

end

mostrarPontuacao = {}


function bancoDeDados:pegarCont()


   for linha in banco:nrows("SELECT * FROM tabelaPontuacao ORDER BY pontuacao DESC") do
	

     mostrarPontuacao[#mostrarPontuacao+1] = 
   { pontuacao = linha.pontuacao }


 end

return mostrarPontuacao

end


return bancoDeDados