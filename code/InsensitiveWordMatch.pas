{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Insensitive word matcher object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit InsensitiveWordMatch;

interface

uses
  SysUtils,
  Text, UpperText,
  TextLocation,
  WordSplitIdentifier,
  SensitiveWordMatch,
  TextMatch;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ITextMatch))
  Match a complete word ignoring char case mode
  @member(Find @seealso(ITextMatch.Find))
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
  TInsensitiveWordMatch = class sealed(TInterfacedObject, ITextMatch)
  strict private
    _TextMatch: ITextMatch;
  public
    function Find(const Text, ToFind: IText; const StartAt: Cardinal): ITextLocation;
    constructor Create(const WordSplitIdentifier: IWordSplitIdentifier);
    class function New(const WordSplitIdentifier: IWordSplitIdentifier): ITextMatch;
    class function NewDefault: ITextMatch;
  end;

implementation

function TInsensitiveWordMatch.Find(const Text, ToFind: IText; const StartAt: Cardinal): ITextLocation;
begin
  Result := _TextMatch.Find(TUpperText.New(Text), TUpperText.New(ToFind), StartAt);
end;

constructor TInsensitiveWordMatch.Create(const WordSplitIdentifier: IWordSplitIdentifier);
begin
  _TextMatch := TSensitiveWordMatch.New(WordSplitIdentifier);
end;

class function TInsensitiveWordMatch.New(const WordSplitIdentifier: IWordSplitIdentifier): ITextMatch;
begin
  Result := TInsensitiveWordMatch.Create(WordSplitIdentifier);
end;

class function TInsensitiveWordMatch.NewDefault: ITextMatch;
begin
  Result := TInsensitiveWordMatch.New(TWordSplitIdentifier.New);
end;

end.
