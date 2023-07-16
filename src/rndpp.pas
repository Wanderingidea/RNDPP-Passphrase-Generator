program rndpp;

{$MODE DELPHI}
{$RANGECHECKS ON}
{$OPTIMIZATION ON}
{$DEBUGINFO OFF}

(*
* Cor van Wandelen v.3-2023
* Rndpp creates randomly constructed passphrases of 16 characters or more including spaces, one symbol and one number.
*
* License:
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <https://www.gnu.org/licenses/>.
*)

uses Classes, Crt, SysUtils;

var duwords : TStringList;
	engwords : TStringList;
	symbols : string;
	nr : integer;
	output : string;
	word : string;

{$IFDEF UNIX}
(**
	initializes PRNG with data read from /dev/random

	Randomize initializes the pseudo-random number generator
	by storing a value read from /dev/random to system.randSeed.
	If reading fails, system.randomize will be used instead.
*)
procedure randomize;
const
	/// file name for random(4) device
	randomDeviceName = '/dev/random';
var
	/// reading buffer
	// same type as system.randSeed
	randomNumber: cardinal;
	/// file handle
	randomReader: file of cardinal;
begin
	assign(randomReader, randomDeviceName);
	{$push}
	// turn off run-time error generation
	{$IOChecks off}
	reset(randomReader);

	if IOResult() = 0 then
	begin
		// will possibly cause the error
		//   EInOutError: Read past end of file
		// if /dev/random is depleted
		read(randomReader, randomNumber);

		if IOResult() = 0 then
		begin
			system.randSeed := randomNumber;
		end
		else
		begin
			// do not call oneself => fully qualified identifier
			system.randomize;
		end;

		close(randomReader);
	end
	{$pop}
	else
	begin
		// do not call oneself => fully qualified identifier
		system.randomize;
	end;
end;
{$ENDIF}

function Rnd(a,b : integer) : integer; // a to b but not included b
begin
	Rnd := a + Random(b - 1);
end;

function IsNumber(const S: string): Boolean;
begin
	Result := True;
	try
		StrToInt(S);
	except
		Result := False;
	end;
end;

begin
	Randomize;

	if IsNumber(ParamStr(1)) = True then
	begin
		try
			RandSeed := StrToInt(ParamStr(1));
			if RandSeed <= 0 then
			begin
				writeln('Random seed is zero');
				halt(1);
			end;
		except
			writeln('Parameter not correct');
			halt(1);
		end;
	end;

	duwords := TStringList.Create;
	engwords := TStringList.Create;

	try
		symbols := '!"#$%&()*+-./&<=>?@\]^_`:}[{~;' + Chr(39);

		duwords.Delimiter := ';';
		duwords.DelimitedText := {$I 'dlp.csv'};

		engwords.Delimiter := ';';
		engwords.DelimitedText := {$I 'blp.csv'};

		repeat
			output := '';
			for nr := 1 to 6 do
			begin
				Delay(10);
				word := duwords.Strings[Rnd(1, duwords.count)];
				word := word + symbols[Rnd(1, Length(symbols)+1)];
				word := word + IntToStr(Rnd(0,10));
				output := output + word + ' ';
			end;
		until Length(output) >= 16;

		writeln('Nederlands: ' + output);

		repeat
			output := '';
			for nr := 1 to 6 do
			begin
				Delay(10);
				word := engwords.Strings[Rnd(1, engwords.count)];
				word := word + symbols[Rnd(1, Length(symbols)+1)];
				word := word + IntToStr(Rnd(0,10));
				output := output + word + ' ';
			end;
		until Length(output) >= 16;

		writeln('English:    ' + output);

	finally
		duwords.Free();
		engwords.Free();

		halt(0);
	end;

	halt(1);
end.
