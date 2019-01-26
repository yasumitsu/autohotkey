#Persistent
!s::myGui()
myGui() {
InputBox, cliente, Question 1, Qual o nome do cliente?
InputBox, telefone, Question 2, Insira o telefone do cliente?
SendInput 
(
    {Raw}
Aqui vai o nome do cliente: %cliente%
Aqui o telefone: %telefone%
E aqui o texto padrao ... blablabla!
)
}
Return