{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Word split identifier object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit WordSplitIdentifier;

interface

uses
  SysUtils;

type
{$REGION 'documentation'}
{
  @abstract(Word split identifier object)
  Identicates if a position of text is a word splitter based on a delimiter list
  @member(
    IsDelimiter Delimiter validator
    @param(Text Source text)
    @param(Position Position of letter in text)
    @return(@True if position contains a delimiter, @false if not)
  )
}
{$ENDREGION}
  IWordSplitIdentifier = interface
    ['{FBD8CE5B-D5FC-449F-851F-AAA7A0687AB8}']
    function IsDelimiter(const Text: String; const Position: Cardinal): Boolean;
  end;

{$REGION 'documentation'}
{
  @abstract(Type for delimiter list)
}
{$ENDREGION}
  TDelimiterList = TSysCharSet;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IWordSplitIdentifier))
  @member(IsDelimiter @seealso(IWordSplitIdentifier.IsDelimiter))
  @member(DEFAULT_SPACES Default list of space delimiters)
  @member(DEFAULT_DIVIDERS Default list of letter delimiters)
  @member(
    Create Object constructor
    @param(DelimiterList List of word delimiters)
  )
  @member(
    New Create a new @classname as interface
    @param(DelimiterList List of word delimiters)
  )
}
{$ENDREGION}

  TWordSplitIdentifier = class sealed(TInterfacedObject, IWordSplitIdentifier)
  const
    DEFAULT_SPACES: TDelimiterList = [#0, #9, #10, #13, #32];
    DEFAULT_DIVIDERS: TDelimiterList = //
      ['=', '<', '>', '.', ',', '?', '!', '(', ')', '[', ']', '{', '}', '"', ':', '@', '/', '\', ';', '-'];
  strict private
    _DelimiterList: TDelimiterList;
  public
    function IsDelimiter(const Text: String; const Position: Cardinal): Boolean;
    constructor Create(const DelimiterList: TDelimiterList);
    class function New(const DelimiterList: TDelimiterList = []): IWordSplitIdentifier;
  end;

implementation

function TWordSplitIdentifier.IsDelimiter(const Text: String; const Position: Cardinal): Boolean;
begin
  Result := CharInSet(Text[Position], _DelimiterList);
end;

constructor TWordSplitIdentifier.Create(const DelimiterList: TDelimiterList);
begin
  if DelimiterList = [] then
    _DelimiterList := DEFAULT_SPACES + DEFAULT_DIVIDERS
  else
    _DelimiterList := DelimiterList;
end;

class function TWordSplitIdentifier.New(const DelimiterList: TDelimiterList): IWordSplitIdentifier;
begin
  Result := TWordSplitIdentifier.Create(DelimiterList);
end;

end.
