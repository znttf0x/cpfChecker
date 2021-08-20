#!/bin/bash

# Programa:            cpfChecker.sh
# Criado em:           27/07/2021
# Ultima modificacao:  19/08/2021
# Autoria:             Lucas Zanoti
# Email:               lucaszanotti1997@gmail.com
# Discord:             /zntt#7359

# Colors
reset="\033[0m"
yellow="\033[0;33m"

# Menu
if [[ -z $1 || "$1" == "-h" || "$1" == "--help"]]; then
	echo -e ""
	echo -e "${yellow}Opções:${reset}              [-h. --help] Para acessar o menu de ajuda."
	echo -e "${yellow}Uso:${reset}                 ./cpfChecker.sh 12345678900"
	exit
fi

# Program
read -a cpf <<< $(echo "$1" | sed 's/./& /g')

stSum=$(((${cpf[0]}*10)+(${cpf[1]}*9)+(${cpf[2]}*8)+(${cpf[3]}*7)+(${cpf[4]}*6)+(${cpf[5]}*5)+(${cpf[6]}*4)+(${cpf[7]}*3)+(${cpf[8]}*2)))
ndSum=$(((${cpf[0]}*11)+(${cpf[1]}*10)+(${cpf[2]}*9)+(${cpf[3]}*8)+(${cpf[4]}*7)+(${cpf[5]}*6)+(${cpf[6]}*5)+(${cpf[7]}*4)+(${cpf[8]}*3)+(${cpf[9]}*2)))
stDigit=$(((11-${stSum}%11)))
ndDigit=$(((11-${ndSum}%11)))

if [[ "$stDigit" -gt "9" ]]; then stDigit="0"; fi
if [[ "$ndDigit" -gt "9" ]]; then ndDigit="0"; fi

if [[ "$(echo $1 | cut -c10)" != "$stDigit" || "$(echo $1 | cut -c11)" != "$ndDigit" ]]; then
	status="Inválido"
else
	status="Válido"
fi

echo -e "${yellow}CPF:${reset} ${1:0:3}.${1:3:3}.${1:6:3}-${1:9:2}"
echo -e "${yellow}Status:${reset} $status"

if [[ "$status" != "Válido" ]]; then
	exit
else
	echo -e "${yellow}Emitido em:${reset}\c"
fi
state=$(echo $1 | cut -c9)
case "$state" in
	0 ) echo -e " Rio Grande do Sul"
	;;
	1 ) echo -e " Distrito Federal, Goiás, Mato Grosso do Sul ou Tocantins"
	;;
	2 ) echo -e " Pará, Amazonas, Acre, Amapá, Rondônia ou Roraima"
	;;
	3 ) echo -e " Ceará, Maranhão ou Piauí"
	;;
	4 ) echo -e " Pernambuco, Rio Grande do Norte, Paraíba ou Alagoas"
	;;
	5 ) echo -e " Bahia ou Sergipe"
	;;
	6 ) echo -e " Minas Gerais"
	;;
	7 ) echo -e " Rio de Janeiro ou Espírito Santo"
	;;
	8 ) echo -e " São Paulo"
	;;
	9 ) echo -e " Paraná ou Santa Catarina"
	;;
esac
