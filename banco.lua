local bancoDados = {}

local  sqlite3 = require("sqlite3")
local  estrada = system.pathForFile("dados.db",system.DocumentsDirectory)
local  banco = sqlite3.open(estrada)


local tabela = [[CREATE TABLE IF NOT EXISTS tabelaPontuac(pontuacao NOT NULL);]]
banco:exec(tabela)

--local remover = [[DELETE FROM tabelaPontuac]]
--banco:exec(remover)

function bancoDados:inserir( pontuacao )


	if #mostrarPontuacao < 5 then



	local consulta = [[INSERT INTO tabelaPontuac(pontuacao) VALUES (]] ..pontuacao.. [[);]]
   
	banco:exec(consulta)
		
end

end

mostrarPontuacao = {}


function bancoDados:pegarPontuacao()


   for linha in banco:nrows("SELECT pontuacao, MAX(pontuacao) AS 'max_pontuacao' FROM tabelaPontuac ;") do
	

     mostrarPontuacao[#mostrarPontuacao+1] =  { pontuacao = linha.pontuacao }

  

 end

return mostrarPontuacao

end


return bancoDados