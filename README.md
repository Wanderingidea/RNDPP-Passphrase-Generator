# rndpp
Rndpp creates randomly constructed passphrases of 16 characters or more including spaces, one symbol and one number.

### Compiling:
The FreePascal source code compiles without any problems for Linux and Windows.<br>
Before compiling prepare the Dutch and English word lists first, see 'Word lists'.

### Random seed
Run under Linux rndpp uses /dev/random to create a random seed which the Mersenne Twister algorithm uses to
generate random numbers. Such is not available under Windows, therefore Rndpp also accepts a parameter which is the random seed.
For example use the Powershell command 'rndpp %{Get-Random}' to generate a seed and feed it to rndpp as a parameter. Otherwise if run under Windows the system time is used as a seed.

Another example: if one has a hardware random number generator connected to /dev/ttyUSB0 one could use:<br>
`rndpp $(od -vAn -N2 -tu2 < /dev/ttyUSB0 | tr -d ' \n\r')`<br>

### Word lists
One could use other wordlists 'dlp.csv' for Dutch, 'blp.csv' for English in the following format:<br>
one line beginning and ending with a single quote, each word separated by a semicolon. No CR or LF after this line!