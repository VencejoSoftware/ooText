{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Match.WordSensitive;

interface

uses
  SysUtils, StrUtils,
  ooText.WordDelimiter,
  ooText.Match.Intf;

type
  TTextMatchWordSensitive = class sealed(TInterfacedObject, ITextMatch)
  strict private
    _TextWordDelimiter: ITextWordDelimiter;
    _FoundEnd, _FoundStart: Integer;
    _Text: String;
  private
    function Found: Boolean;
  public
    function FoundStart: Integer;
    function FoundEnd: Integer;
    function Find(const Text, ToFind: String; const StartAt: Integer): Boolean;

    constructor Create(const WordDelimiters: TSysCharSet = []);

    class function New(const WordDelimiters: TSysCharSet = []): ITextMatch;
  end;

implementation

function TTextMatchWordSensitive.FoundStart: Integer;
begin
  Result := _FoundStart;
end;

function TTextMatchWordSensitive.FoundEnd: Integer;
begin
  Result := _FoundEnd;
end;

function TTextMatchWordSensitive.Found: Boolean;
var
  IsDelimitedBefore, IsDelimitedAfter: Boolean;
begin
  IsDelimitedBefore := (_FoundStart = 1) or _TextWordDelimiter.Check(_Text, Pred(_FoundStart));
  IsDelimitedAfter := (_FoundEnd = Length(_Text)) or _TextWordDelimiter.Check(_Text, Succ(_FoundEnd));
  Result := IsDelimitedBefore and IsDelimitedAfter;
end;

function TTextMatchWordSensitive.Find(const Text, ToFind: String; const StartAt: Integer): Boolean;
begin
  _Text := Text;
  _FoundStart := PosEx(ToFind, Text, StartAt);
  if _FoundStart > 0 then
  begin
    _FoundEnd := Pred(_FoundStart + Length(ToFind));
    Result := Found;
    if not Result then
      Result := Find(Text, ToFind, _FoundEnd);
  end
  else
  begin
    _FoundEnd := - 1;
    Result := False;
  end;
end;

constructor TTextMatchWordSensitive.Create(const WordDelimiters: TSysCharSet = []);
begin
  _TextWordDelimiter := TTextWordDelimiter.New(WordDelimiters);
end;

class function TTextMatchWordSensitive.New(const WordDelimiters: TSysCharSet = []): ITextMatch;
begin
  Result := TTextMatchWordSensitive.Create(WordDelimiters);
end;

end.
