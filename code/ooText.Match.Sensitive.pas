{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Match.Sensitive;

interface

uses
  StrUtils,
  ooText.Match.Intf;

type
  TTextMatchSensitive = class sealed(TInterfacedObject, ITextMatch)
  strict private
    _FoundEnd, _FoundStart: Integer;
  private
    function Found: Boolean;
  public
    function FoundStart: Integer;
    function FoundEnd: Integer;
    function Find(const Text, ToFind: String; const StartAt: Integer): Boolean;

    class function New: ITextMatch;
  end;

implementation

function TTextMatchSensitive.FoundStart: Integer;
begin
  Result := _FoundStart;
end;

function TTextMatchSensitive.FoundEnd: Integer;
begin
  Result := _FoundEnd;
end;

function TTextMatchSensitive.Found: Boolean;
begin
  Result := FoundStart > 0;
end;

function TTextMatchSensitive.Find(const Text, ToFind: String; const StartAt: Integer): Boolean;
begin
  _FoundStart := PosEx(ToFind, Text, StartAt);
  Result := Found;
  if Result then
    _FoundEnd := Pred(_FoundStart + Length(ToFind))
  else
    _FoundEnd := - 1;
end;

class function TTextMatchSensitive.New: ITextMatch;
begin
  Result := TTextMatchSensitive.Create;
end;

end.
