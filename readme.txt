class fornecedor
string nome fornecedor
int nota fiscal
data do pedido

class produto
string imagem
int código
double quantidade
-------------------------------------------------------------------------------------------------------------------------------------
tela recebimentos
appbar: drawer - titulo "RECEBIMENTOS" - lupa pesquisar - 3 pontinhos
body:
"HOJE"
LISTVIEW - TILELIST => fornecedor (titulo), id do fornecedor e nota fiscal (subtítulos)
-------------------------------------------------------------------------------------------------------------------------------------
tela do pedido
appbar: botão retornar - id do pedido - lupa pesquisar - 3 pontinhos
body: 
fornecedor - nota fiscal do pedido - data do pedido
listView - tileList nome do produto (negrito), cód do produto e quantidade (kg, p e. subtítulo), botão entrar no produto
-------------------------------------------------------------------------------------------------------------------------------------
tela do produto
appbar: botão retornar - cód do produto - 3 pontinhos
body:
listView
tileList (como a anterior)
divider (mais grosso)
cx 
un
divider (mais grosso)
botão "parcial+" (acho q daria um ElevatedButton roxo)
parciais
ícone de código de barras - botão que vai abrir o leitor de código de barras ?
botão elevatedbutton CONCLUIR (azul claro. Apertando, retorna pra pedidos) e ETIQUETAS (roxo)
-------------------------------------------------------------------------------------------------------------------------------------

https://reqres.in/

https://app.uizard.io/p/8a335400

parei em "id" de produto
depois preciso fazer a classe de fornecedor e colocar produto dentro

to no widget recebimento_list tentando criar uma lista lá dentro p passar pra o widget de searcheble