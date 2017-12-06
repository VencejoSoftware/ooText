{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.PadZeros;

interface

uses
  SysUtils,
  ooText;

type
  TTextLeftPad = class sealed(TInterfacedObject, IText)
  strict private
    _Value: String;
  private
    function Generate(const Text: String; const Count: Integer; const PadChar: Char): string;
  public
    function Size: Integer;
    function Value: String;
    function IsEmpty: Boolean;

    constructor Create(const Text: IText; const Count: Integer; const PadChar: Char);

    class function New(const Text: IText; const Count: Integer; const PadChar: Char): IText;
    class function NewFromString(const Text: String; const Count: Integer; const PadChar: Char): IText;
  end;

implementation

function TTextLeftPad.Generate(const Text: String; const Count: Integer; const PadChar: Char): string;
var
  DiffLen: Integer;
  i: Integer;
begin
  DiffLen := Count - Length(Text);
  Result := EmptyStr;
  for i := 1 to DiffLen do
    Result := Result + PadChar;
  Result := Result + Text;
end;

function TTextLeftPad.Value: String;
begin
  Result := _Value;
end;

function TTextLeftPad.IsEmpty: Boolean;
begin
  Result := Size < 1;
end;

function TTextLeftPad.Size: Integer;
begin
  Result := Length(_Value);
end;

constructor TTextLeftPad.Create(const Text: IText; const Count: Integer; const PadChar: Char);
begin
  _Value := Generate(Text.Value, Count, PadChar);
end;

class function TTextLeftPad.New(const Text: IText; const Count: Integer; const PadChar: Char): IText;
begin
  Result := TTextLeftPad.Create(Text, Count, PadChar);
end;

class function TTextLeftPad.NewFromString(const Text: String; const Count: Integer; const PadChar: Char): IText;
begin
  Result := TTextLeftPad.New(TText.New(Text), Count, PadChar);
end;

end.
