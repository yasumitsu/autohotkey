#Persistent
!s::
Gui, New
Gui, Add, Text,, First name:
Gui, Add, Edit, vcliente  ; The ym option starts a new column of controls.
Gui, Add, Text,, Last name:
Gui, Add, Edit, vtelefone
Gui, Add, Button, default, OK  ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Show,, Simple Input Example
return  ; End of auto-execute section. The script is idle until the user does something.

GuiClose:
ButtonOK:
Gui, Submit  ; Save the input from the user to each control's associated variable.
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