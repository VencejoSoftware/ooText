{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.RandomFixed;

interface

uses
  Math,
  ooText;

type
  TRandomTextFixed = class sealed(TInterfacedObject, IText)
  strict private
  const
    CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopkrsyuvwxyz1234567890_-.,:;*+=!¡¿?\[]{}()#$%&/@';
  strict private
    _Value: String;
  private
    function Generate(const CharMap: String): String;
  public
    function Size: Integer;
    function Value: String;
    function IsEmpty: Boolean;
    constructor Create(const CharMap: String);
    class function New: IText;
    class function NewWithCharMap(const CharMap: String): IText;
  end;

implementation

function TRandomTextFixed.Generate(const CharMap: String): String;
var
  i: Integer;
  Buffer: Char;
begin
  Randomize;
  Result := CHARS;
  i := Length(Result);
  while i > 0 do
  begin
    Buffer := Result[i];
    Result[i] := Result[RandomRange(1, i)];
    Result[RandomRange(1, i)] := Buffer;
    Dec(i);
  end;
end;

function TRandomTextFixed.Value: String;
begin
  Result := _Value;
end;

function TRandomTextFixed.IsEmpty: Boolean;
begin
  Result := False;
end;

function TRandomTextFixed.Size: Integer;
begin
  Result := Length(_Value);
end;

constructor TRandomTextFixed.Create(const CharMap: String);
begin
  _Value := Generate(CharMap);
end;

class function TRandomTextFixed.New: IText;
begin
  Result := TRandomTextFixed.Create(TRandomTextFixed.CHARS);
end;

class function TRandomTextFixed.NewWithCharMap(const CharMap: String): IText;
begin
  Result := TRandomTextFixed.Create(CharMap);
end;

end.
