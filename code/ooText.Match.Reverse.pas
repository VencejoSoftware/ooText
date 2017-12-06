{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Match.Reverse;

interface

uses
  SysUtils,
  ooText.Match.Intf;

type
  TTextFindReverse = class sealed(TInterfacedObject, ITextMatch)
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

function TTextFindReverse.FoundEnd: Integer;
begin
  Result := _FoundEnd;
end;

function TTextFindReverse.FoundStart: Integer;
begin
  Result := _FoundStart;
end;

function TTextFindReverse.Found: Boolean;
begin
  Result := FoundStart > 0;
end;

function TTextFindReverse.Find(const Text, ToFind: String; const StartAt: Integer): Boolean;
var
  LenSubText, CurPos: Integer;
begin
  Result := False;
  _FoundStart := 0;
  if Trim(ToFind) = EmptyStr then
    Exit;
  LenSubText := Length(ToFind);
  CurPos := Length(Text);
  while (CurPos > 0) and (_FoundStart = 0) do
  begin
    if Copy(Text, CurPos - StartAt, LenSubText) = ToFind then
    begin
      _FoundStart := CurPos - StartAt;
      _FoundEnd := Pred(_FoundStart + Length(ToFind));
    end;
    Dec(CurPos);
  end;
  Result := Found;
end;

class function TTextFindReverse.New: ITextMatch;
begin
  Result := TTextFindReverse.Create;
end;

end.
