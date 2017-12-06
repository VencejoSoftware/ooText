{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Cutted;

interface

uses
  SysUtils;

type
  ITextCutted = interface
    ['{5535503F-B7CD-4C6A-BDB5-27A28C2331D3}']
    function IsCutted: Boolean;
    function FirstPart: String;
    function EndPart: String;
  end;

  TTextCutted = class sealed(TInterfacedObject, ITextCutted)
  strict private
    _FirstPart, _EndPart: String;
  public
    function IsCutted: Boolean;
    function FirstPart: String;
    function EndPart: String;

    constructor Create(const Text: String; const Position: Integer);

    class function New(const Text: String; const Position: Integer): ITextCutted;
  end;

implementation

function TTextCutted.EndPart: String;
begin
  Result := _EndPart;
end;

function TTextCutted.FirstPart: String;
begin
  Result := _FirstPart;
end;

function TTextCutted.IsCutted: Boolean;
begin
  Result := (_FirstPart <> EmptyStr);
  Result := Result and (_EndPart <> EmptyStr);
end;

constructor TTextCutted.Create(const Text: String; const Position: Integer);
begin
  if Position > 0 then
  begin
    _FirstPart := Copy(Text, 1, Position);
    _EndPart := Copy(Text, Succ(Position));
  end
  else
  begin
    _FirstPart := EmptyStr;
    _EndPart := EmptyStr;
  end;
end;

class function TTextCutted.New(const Text: String; const Position: Integer): ITextCutted;
begin
  Result := TTextCutted.Create(Text, Position);
end;

end.
