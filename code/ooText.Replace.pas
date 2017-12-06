{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Replace;

interface

uses
  SysUtils,
  ooText.Match.Intf,
  ooText;

type
  ITextReplace = interface(IText)
    ['{5DCAA772-1693-4D2F-B413-5948C0A873BA}']
    function OneMatch(const ToFind, NewWord: String; const StartAt: Integer = 1): string;
    function AllMatches(const ToFind, NewWord: String; const StartAt: Integer = 1): string;
  end;

  TTextReplace = class sealed(TInterfacedObject, ITextReplace)
  strict private
    _TextMatch: ITextMatch;
    _Text: IText;
  private
    function MatchAndReplace(const Text, ToFind, NewWord: String; const StartAt: Integer;
      const AllMatches: Boolean): string;
  public
    function Size: Integer;
    function Value: String;
    function IsEmpty: Boolean;

    function OneMatch(const ToFind, NewWord: String; const StartAt: Integer = 1): string;
    function AllMatches(const ToFind, NewWord: String; const StartAt: Integer = 1): string;

    constructor Create(const Text: IText; const TextMatch: ITextMatch);

    class function New(const Text: IText; const TextMatch: ITextMatch): ITextReplace;
    class function NewFromString(const Text: String; const TextMatch: ITextMatch): ITextReplace;
  end;

implementation

function TTextReplace.Value: String;
begin
  Result := _Text.Value;
end;

function TTextReplace.IsEmpty: Boolean;
begin
  Result := Size < 1;
end;

function TTextReplace.Size: Integer;
begin
  Result := Length(Value);
end;

function TTextReplace.MatchAndReplace(const Text, ToFind, NewWord: String; const StartAt: Integer;
  const AllMatches: Boolean): string;
var
  LeftPart, RightPart: String;
begin
  Result := Text;
  if not _TextMatch.Find(Value, ToFind, StartAt) then
    Exit;
  LeftPart := Copy(Value, StartAt, _TextMatch.FoundStart - StartAt);
  RightPart := Copy(Value, Succ(_TextMatch.FoundEnd), Length(Value) - _TextMatch.FoundEnd);
  if AllMatches then
    RightPart := MatchAndReplace(RightPart, ToFind, NewWord, Succ(_TextMatch.FoundEnd), AllMatches);
  Result := LeftPart + NewWord + RightPart;
end;

function TTextReplace.AllMatches(const ToFind, NewWord: String; const StartAt: Integer): string;
begin
  Result := MatchAndReplace(Value, ToFind, NewWord, StartAt, True);
end;

function TTextReplace.OneMatch(const ToFind, NewWord: String; const StartAt: Integer): string;
begin
  Result := MatchAndReplace(Value, ToFind, NewWord, StartAt, False);
end;

constructor TTextReplace.Create(const Text: IText; const TextMatch: ITextMatch);
begin
  _TextMatch := TextMatch;
  _Text := Text;
end;

class function TTextReplace.New(const Text: IText; const TextMatch: ITextMatch): ITextReplace;
begin
  Result := TTextReplace.Create(Text, TextMatch);
end;

class function TTextReplace.NewFromString(const Text: String; const TextMatch: ITextMatch): ITextReplace;
begin
  Result := TTextReplace.New(TText.New(Text), TextMatch);
end;

end.
