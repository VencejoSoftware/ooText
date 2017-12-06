{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Tokenize;

interface

uses
  ooText.Match.Intf,
  ooEnumerator,
  ooText.TokenizeEnumerator;

type
  TTextTokenize = class sealed(TInterfacedObject, IStringEnumerable)
  strict private
    _Enumerator: IStringEnumerator;
  public
    function GetEnumerator: IStringEnumerator;
    constructor Create(const Text, ToFind: String; const TextMatch: ITextMatch;
      const StartAt, EndAt, TextLength: Integer);
    class function New(const Text, ToFind: String; const TextMatch: ITextMatch; const StartAt: Integer = 0;
      const EndAt: Integer = 0): IStringEnumerable;
  end;

implementation

function TTextTokenize.GetEnumerator: IStringEnumerator;
begin
  Result := _Enumerator;
end;

constructor TTextTokenize.Create(const Text, ToFind: String; const TextMatch: ITextMatch;
  const StartAt, EndAt, TextLength: Integer);
begin
  _Enumerator := TTextTokenizeEnumerator.New(Text, ToFind, TextMatch, StartAt, EndAt, TextLength);
end;

class function TTextTokenize.New(const Text, ToFind: String; const TextMatch: ITextMatch; const StartAt: Integer = 0;
  const EndAt: Integer = 0): IStringEnumerable;
begin
  Result := TTextTokenize.Create(Text, ToFind, TextMatch, StartAt, EndAt, Length(Text));
end;

end.
