{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Sensitive word matcher object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SensitiveWordMatch;

interface

uses
  StrUtils,
  WordSplitIdentifier,
  TextLocation,
  Text,
  TextMatch;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ITextMatch))
  Match a complete word in sensitive char case mode
  @member(Find @seealso(ITextMatch.Find))
  @member(
    IsFounded Uses word split delimiter to determine if founded position is a word
    @param(Text Text to validate)
    @param(Start Founded position start)
    @param(Finish Founded position end)
  )
  @member(
    Create Object constructor
    @param(WordSplitIdentifier Word split identifier object)
  )
  @member(
    New Create a new @classname as interface
    @param(WordSplitIdentifier word split identifier object)
  )
  @member(
    NewDefault Create a new @classname as interface with default word split identifier object
  )
}
{$ENDREGION}
  TSensitiveWordMatch = class sealed(TInterfacedObject, ITextMatch)
  strict private
    _WordSplitIdentifier: IWordSplitIdentifier;
  private
    function IsFounded(const Text: IText; const Start, Finish: Cardinal): Boolean;
  public
    function Find(const Text, ToFind: IText; const StartAt: Cardinal): ITextLocation;
    constructor Create(const WordSplitIdentifier: IWordSplitIdentifier);
    class function New(const WordSplitIdentifier: IWordSplitIdentifier): ITextMatch;
    class function NewDefault: ITextMatch;
  end;

implementation

function TSensitiveWordMatch.IsFounded(const Text: IText; const Start, Finish: Cardinal): Boolean;
var
  IsDelimitedBefore, IsDelimitedAfter: Boolean;
begin
  IsDelimitedBefore := (Start = 1) or _WordSplitIdentifier.IsDelimiter(Text.Value, Pred(Start));
  IsDelimitedAfter := (Finish = Text.Size) or _WordSplitIdentifier.IsDelimiter(Text.Value, Succ(Finish));
  Result := IsDelimitedBefore and IsDelimitedAfter;
end;

function TSensitiveWordMatch.Find(const Text, ToFind: IText; const StartAt: Cardinal): ITextLocation;
var
  FoundStart, FoundEnd: Cardinal;
begin
  Result := nil;
  FoundStart := PosEx(ToFind.Value, Text.Value, StartAt);
  if FoundStart > 0 then
  begin
    FoundEnd := Pred(FoundStart + ToFind.Size);
    if IsFounded(Text, FoundStart, FoundEnd) then
      Result := TTextLocation.New(FoundStart, FoundEnd)
    else
      Result := Find(Text, ToFind, FoundEnd);
  end;
end;

constructor TSensitiveWordMatch.Create(const WordSplitIdentifier: IWordSplitIdentifier);
begin
  _WordSplitIdentifier := WordSplitIdentifier;
end;

class function TSensitiveWordMatch.New(const WordSplitIdentifier: IWordSplitIdentifier): ITextMatch;
begin
  Result := TSensitiveWordMatch.Create(WordSplitIdentifier);
end;

class function TSensitiveWordMatch.NewDefault: ITextMatch;
begin
  Result := TSensitiveWordMatch.New(TWordSplitIdentifier.New);
end;

end.
