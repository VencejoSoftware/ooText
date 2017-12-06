{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.TokenizeEnumerator;

interface

uses
  SysUtils,
  ooText.Match.Intf,
  ooEnumerator;

type
  TTextTokenizeEnumerator = class sealed(TInterfacedObject, IStringEnumerator)
  strict private
    _Text, _ToFind: String;
    _TextMatch: ITextMatch;
    _StartAt, _EndAt, _TextSize, _SeparatorLen: Integer;
  private
    function HasNext: Boolean;
    procedure NextPosition;
  public
    function GetCurrent: string;
    function MoveNext: Boolean;

    procedure Reset;

    constructor Create(const Text, ToFind: String; const TextMatch: ITextMatch;
      const StartAt, EndAt, TextSize: Integer);

    class function New(const Text, ToFind: String; const TextMatch: ITextMatch;
      const StartAt, EndAt, TextSize: Integer): IStringEnumerator;
  end;

implementation

function TTextTokenizeEnumerator.GetCurrent: string;
begin
  Result := Copy(_Text, _StartAt, _EndAt - _StartAt);
end;

function TTextTokenizeEnumerator.HasNext: Boolean;
begin
  Result := _TextMatch.Find(_Text, _ToFind, _StartAt);
end;

procedure TTextTokenizeEnumerator.NextPosition;
begin
  if _EndAt > _StartAt then
    _StartAt := _EndAt + _SeparatorLen
  else
    Inc(_StartAt);
end;

function TTextTokenizeEnumerator.MoveNext: Boolean;
begin
  NextPosition;
  Result := HasNext;
  if Result then
    _EndAt := _TextMatch.FoundStart;
  if _EndAt <= 0 then
    _EndAt := Succ(_TextSize);
end;

procedure TTextTokenizeEnumerator.Reset;
begin
  _StartAt := 0;
  _EndAt := 0;
end;

constructor TTextTokenizeEnumerator.Create(const Text, ToFind: String; const TextMatch: ITextMatch;
  const StartAt, EndAt, TextSize: Integer);
begin
  _Text := Text;
  _ToFind := ToFind;
  _TextMatch := TextMatch;
  _StartAt := StartAt;
  _EndAt := EndAt;
  _TextSize := TextSize;
  _SeparatorLen := Length(ToFind);
end;

class function TTextTokenizeEnumerator.New(const Text, ToFind: String; const TextMatch: ITextMatch;
  const StartAt, EndAt, TextSize: Integer): IStringEnumerator;
begin
  Result := TTextTokenizeEnumerator.Create(Text, ToFind, TextMatch, StartAt, EndAt, TextSize);
end;

end.
