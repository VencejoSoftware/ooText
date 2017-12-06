{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Match.WordInsensitive;

interface

uses
  SysUtils,
  ooText.Match.WordSensitive,
  ooText.Match.Intf;

type
  TTextMatchWordInsensitive = class sealed(TInterfacedObject, ITextMatch)
  strict private
    _TextMatch: ITextMatch;
  public
    function FoundStart: Integer;
    function FoundEnd: Integer;
    function Find(const Text, ToFind: String; const StartAt: Integer): Boolean;

    constructor Create(const WordDelimiters: TSysCharSet = []);

    class function New(const WordDelimiters: TSysCharSet = []): ITextMatch;
  end;

implementation

function TTextMatchWordInsensitive.FoundStart: Integer;
begin
  Result := _TextMatch.FoundStart;
end;

function TTextMatchWordInsensitive.FoundEnd: Integer;
begin
  Result := _TextMatch.FoundEnd;
end;

function TTextMatchWordInsensitive.Find(const Text, ToFind: String; const StartAt: Integer): Boolean;
begin
  Result := _TextMatch.Find(LowerCase(Text), LowerCase(ToFind), StartAt);
end;

constructor TTextMatchWordInsensitive.Create(const WordDelimiters: TSysCharSet = []);
begin
  _TextMatch := TTextMatchWordSensitive.New(WordDelimiters);
end;

class function TTextMatchWordInsensitive.New(const WordDelimiters: TSysCharSet = []): ITextMatch;
begin
  Result := TTextMatchWordInsensitive.Create(WordDelimiters);
end;

end.
