#!/bin/bash
grep "Excited State" *.log > 1Ex.txt | 		#Collects Excited State information from the Gaussian TDDFT output files and saves as 1Ex.txt
sleep 5 ; cut -d'|' -f 1-10 1Ex.txt > 2Ex.txt | #Extracts columns (from 1 to 10)such as File Name, Exicted State, Singlet/Triplet, transition energies in eV and wavelength (nm), oscillator strength (OS) and spin and saves it as 2Ex.txt
sleep 5 ; sed -e "s/f=//g" -i.backup 2Ex.txt | 	#Deletes the string f= from the OS column on the file 2Ex.txt after taking its back up as 2Ex.txt.backup, this enables the next arithmetic command to execute successfully
awk 'm<$10{m=$10;n=$6" "$7" "$8" "$9} !((NR+2)%10){print $1,n,m;m=n=""}' 2Ex.txt > Lmax.txt | # Finds the highest OS every 10 rows and prints the highest OS and its corresponding File Name and transition energies in eV and wavelength (nm) and saves as Final.txt
exit 0 # exits the code

# Note
# If the script returned any warning or error (like $'\r' - command not found) try running dos2unix 'scriptfile.sh' then chmod 777 'scriptfile.sh' and then execute the script
