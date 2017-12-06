{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.FromArray;

interface

uses
  SysUtils,
  ooText;

type
  TTextFromArray = class sealed(TInterfacedObject, IText)
  strict private
    _Value: String;
  private
    function Generate(const StringArray: array of string; const Separator: string): string;
  public
    function Size: Integer;
    function Value: String;
    function IsEmpty: Boolean;

    constructor Create(const StringArray: array of string; const Separator: string = ',');

    class function New(const StringArray: array of string; const Separator: string = ','): IText;
  end;

implementation

function TTextFromArray.Generate(const StringArray: array of string; const Separator: string): string;
var
  i: Integer;
begin
  for i := 0 to high(StringArray) do
  begin
    if i = 0 then
      Result := StringArray[i]
    else
      Result := Result + Separator + StringArray[i];
  end;
end;

function TTextFromArray.Value: String;
begin
  Result := _Value;
end;

function TTextFromArray.IsEmpty: Boolean;
begin
  Result := Size < 1;
end;

function TTextFromArray.Size: Integer;
begin
  Result := Length(_Value);
end;

constructor TTextFromArray.Create(const StringArray: array of string; const Separator: string);
begin
  _Value := Generate(StringArray, Separator);
end;

class function TTextFromArray.New(const StringArray: array of string; const Separator: string): IText;
begin
  Result := TTextFromArray.Create(StringArray, Separator);
end;

end.
