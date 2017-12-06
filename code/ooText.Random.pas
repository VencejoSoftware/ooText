{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Random;

interface

uses
  ooText;

type
  TRandomText = class sealed(TInterfacedObject, IText)
  strict private
  const
    CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopkrsyuvwxyz1234567890_-.,:;*+=!¡¿?\[]{}()#$%&/@';
  strict private
    _Size: Integer;
    _Value: String;
  private
    function Generate(const CharMap: String; const Count: Integer): String;
  public
    function Size: Integer;
    function Value: String;
    function IsEmpty: Boolean;
    constructor Create(const CharMap: String; const Count: Integer);
    class function New(const Count: Integer): IText;
    class function NewWithCharMap(const CharMap: String; const Count: Integer): IText;
  end;

implementation

function TRandomText.Generate(const CharMap: String; const Count: Integer): String;
var
  i, ValidLen: Integer;
begin
  Randomize;
  ValidLen := Length(CharMap);
  SetLength(Result, Count);
  for i := 1 to Count do
    Result[i] := CharMap[Succ(Random(ValidLen))];
end;

function TRandomText.Value: String;
begin
  Result := _Value;
end;

function TRandomText.IsEmpty: Boolean;
begin
  Result := Size < 1;
end;

function TRandomText.Size: Integer;
begin
  Result := _Size;
end;

constructor TRandomText.Create(const CharMap: String; const Count: Integer);
begin
  _Size := Count;
  _Value := Generate(CharMap, Count);
end;

class function TRandomText.New(const Count: Integer): IText;
begin
  Result := TRandomText.Create(TRandomText.CHARS, Count);
end;

class function TRandomText.NewWithCharMap(const CharMap: String; const Count: Integer): IText;
begin
  Result := TRandomText.Create(CharMap, Count);
end;

end.
