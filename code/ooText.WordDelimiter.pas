{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.WordDelimiter;

interface

uses
  SysUtils;

type
  ITextWordDelimiter = interface
    ['{FBD8CE5B-D5FC-449F-851F-AAA7A0687AB8}']
    function Check(const Text: String; const Position: Integer): Boolean;
  end;

  TTextWordDelimiter = class sealed(TInterfacedObject, ITextWordDelimiter)
  strict private
  const
    WORD_SPACES: TSysCharSet = [#0, #9, #10, #13, #32];
    WORD_SEPARATOR: TSysCharSet = ['=', '<', '>', '.', ',', '?', '!', '(', ')', '[', ']', '{', '}', '"', ':', '@', '/',
      '\', ';', '-'];
  strict private
    _WordDelimiters: TSysCharSet;
  public
    function Check(const Text: String; const Position: Integer): Boolean;
    constructor Create(const WordDelimiters: TSysCharSet);
    class function New(const WordDelimiters: TSysCharSet = []): ITextWordDelimiter;
  end;

implementation

function TTextWordDelimiter.Check(const Text: String; const Position: Integer): Boolean;
begin
  Result := CharInSet(Text[Position], _WordDelimiters);
end;

constructor TTextWordDelimiter.Create(const WordDelimiters: TSysCharSet);
begin
  if (WordDelimiters = []) then
    _WordDelimiters := WORD_SPACES + WORD_SEPARATOR
  else
    _WordDelimiters := WordDelimiters;
end;

class function TTextWordDelimiter.New(const WordDelimiters: TSysCharSet): ITextWordDelimiter;
begin
  Result := TTextWordDelimiter.Create(WordDelimiters);
end;

end.
