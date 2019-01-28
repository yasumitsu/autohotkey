#Persistent
FileRead, OutputVar, C:\Users\fernando.yasumitsu\Documents\scripts\autohotkey\My File.txt
;aqui declara a hotkey
!s::
;aqui come�a a tela
Gui, abertura:New
;aqui come�a campo
Gui, abertura:Add, Text,, Cliente:
Gui, abertura:Add, Edit, vcliente  ; The ym option starts a new column of controls.
Gui, abertura:Add, Text,, Telefone:
Gui, abertura:Add, Edit, vtelefone
Gui, abertura:Add, Text,, Incidente:
Gui, abertura:Add, Edit, vIncidente
Gui, abertura:Add, Text,, Solucao:
Gui, abertura:Add, Edit, vSolucao
Gui, abertura:Add, Button, default, OK  ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, abertura:Show,, Simple Input Example
return  ; End of auto-execute section. The script is idle until the user does something.

abertura:GuiClose:
abertura:ButtonOK:
Gui, abertura:Submit  ; Save the input from the user to each control's associated variable.
;aqui vai o template
SendInput 
(
    {Raw}
INCIDENTE: %Incidente%

SOLUCAO: %solucao%

CLIENTE: %cliente%

TELEFONE: %telefone%
%OutputVar%
)
Gui, abertura:Destroy

return


!d::
Gui, fechamento:New
;aqui come�a campo
Gui, fechamento:Add, Text,, Cliente:
Gui, fechamento:Add, Edit, vcliente  ; The ym option starts a new column of controls.
Gui, fechamento:Add, Text,, Telefone:
Gui, fechamento:Add, Edit, vtelefone
Gui, fechamento:Add, Text,, Incidente:
Gui, fechamento:Add, Edit, vIncidente
Gui, fechamento:Add, Text,, Solucao:
Gui, fechamento:Add, Edit, vSolucao
Gui, fechamento:Add, Button, default, OK  ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, fechamento:Show,, Simple Input Example
return  ; End of auto-execute section. The script is idle until the user does something.

fechamento:GuiClose:
fechamento:ButtonOK:
Gui, fechamento:Submit  ; Save the input from the user to each control's associated variable.
;aqui vai o template
SendInput 
(
    {Raw}
INCIDENTE: %Incidente%

SOLUCAO: %solucao%

CLIENTE: %cliente%

TELEFONE: %telefone%
%OutputVar%
)
Gui, fechamento:Destroy

return


!a::
Gui, New
;aqui come�a campo
Gui, Add, Text,, Cliente:
Gui, Add, Edit, vcliente  ; The ym option starts a new column of controls.
Gui, Add, Text,, Telefone:
Gui, Add, Edit, vtelefone
Gui, Add, Text,, Incidente:
Gui, Add, Edit, vIncidente
Gui, Add, Text,, Solucao:
Gui, Add, Edit, vSolucao
Gui, Add, Button, default, OK  ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Show,, Simple Input Example
return  ; End of auto-execute section. The script is idle until the user does something.

GuiClose:
ButtonOK:
Gui, Submit  ; Save the input from the user to each control's associated variable.
;aqui vai o template
SendInput 
(
    {Raw}
INCIDENTE: %Incidente%

SOLUCAO: %solucao%

CLIENTE: %cliente%

TELEFONE: %telefone%
%OutputVar%
)
Gui, Destroy

return
