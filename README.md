# rndpp
Rndpp creates randomly constructed passphrases of 16 characters or more including spaces, one symbol and one number.

### Compiling:
The FreePascal source code compiles without any problems for Linux and Windows.<br>
Before compiling prepare the Dutch and English word lists first, see 'Word lists'.

### Random seed:
Run under Linux, rndpp uses /dev/random to create a random seed which the Mersenne Twister algorithm uses to
generate random numbers.<br>
If one has a hardware random number generator connected to /dev/ttyUSB0 one could use:<br>
`rndpp $(od -vAn -N2 -tu2 < /dev/ttyUSB0 | tr -d ' \n\r')`<br>

Such is not available under Windows, therefore Rndpp also accepts a parameter which is the random seed.
For example use the Powershell command 'rndpp %{Get-Random}' to generate a seed and feed it to rndpp as a parameter. If not using this parameter and if run under Windows the system time is used as a seed.<br>

### Output example:
Nederlands: wordlists&1 create-1 your<0 example{4 own[1 own}8<br> 
English:    is-5 your@0 own\0 is^3 wordlists<4 an^0 

### Word lists:
The wordlists that rndpp.pas uses while compiling are 'dlp.csv' for Dutch, 'blp.csv' for English in the following format:<br>
one line beginning and ending with a single quote, each word separated by a semicolon. Do not put a CR or LF after this line.<br>
See the examples.

### Sources:
https://www.freepascal.org<br>
https://github.com/Wanderingidea/ATtinyTRNG<br>
https://github.com/Wanderingidea/NanoTRNG<br>
https://github.com/Wanderingidea/ESPTRNG
