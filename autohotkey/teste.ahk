#Persistent
;define o atalho
!s::

;GUI graphical user interface, aqui ele cria a tela para entrada dos dados
Gui, New
;adiciona um novo label para a tela
Gui, Add, Text,, First name:
;aqui ele adiciona o input e registra na variável
Gui, Add, Edit, vcliente  ; The ym option starts a new column of controls.
Gui, Add, Text,, Last name:
Gui, Add, Edit, vtelefone
;cria um botão pra submeter a tela
Gui, Add, Button, default, OK  ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Show,, Simple Input Example
return  ; End of auto-execute section. The script is idle until the user does something.

GuiClose:
ButtonOK:
Gui, Submit  ; Save the input from the user to each control's associated variable.
;dentro do () vai o texto, o {Raw} define que o texto dentro do parentes será interpretado como texto puro, o texto entre %% será lido como variável
SendInput 
(
    {Raw}
Aqui vai o nome do cliente: %cliente%
Aqui o telefone: %telefone%
E aqui o texto padrao ... blablabla!
)
Gui, Destroy
;(
;Any text between%vari% the top and bottom parentheses is treated literally, including commas and percent signs.
;By default, the hard carriage return (Enter) between the previous line and this one is also preserved.
 ;   By default, the indentation (tab) to the left of this line is preserved.
;
;See continuation section for how to change these default behaviors.
;)
return

;para criar mais campos na tela insira como o padrão, abaixo do "new": 
;Gui, Add, Text,, aqui o texto do label
;Gui, Add, Edit, aqui o nome da variável pra ser chamada depois, coloque sempre "v" antes da variável, exemplo: vnomedavariavel
