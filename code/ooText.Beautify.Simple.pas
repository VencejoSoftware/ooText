{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Beautify.Simple;

interface

uses
  SysUtils,
  ooText.Beautify.Intf;

type
  TSimpleBeautify = class(TInterfacedObject, ITextBeautify)
  private
    _Margin: Byte;
    function ApplyMargin(const Text: String): String;
  public
    procedure ChangeMargin(const Margin: Byte);

    function Apply(const ArrayText: Array of string): String;
    function DelimitedList(const Value: String): String;

    class function New: ITextBeautify;
  end;

implementation

function TSimpleBeautify.ApplyMargin(const Text: String): String;
begin
  Result := StringOfChar(' ', _Margin) + Text;
end;

function TSimpleBeautify.Apply(const ArrayText: array of string): String;
var
  i: Integer;
begin
  Result := EmptyStr;
  for i := 0 to High(ArrayText) do
    Result := Result + TrimRight(ArrayText[i]) + ' ';
  Result := ApplyMargin(Trim(Result));
end;

procedure TSimpleBeautify.ChangeMargin(const Margin: Byte);
begin
  _Margin := Margin;
end;

function TSimpleBeautify.DelimitedList(const Value: String): String;
begin
  Result := '(' + Trim(Value) + ')';
end;

class function TSimpleBeautify.New: ITextBeautify;
begin
  Result := TSimpleBeautify.Create;
end;

end.
