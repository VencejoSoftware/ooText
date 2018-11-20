{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Text splitter object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit TextSplit;

interface

uses
  SysUtils,
  IterableList,
  WordSplitIdentifier,
  Text;

type
{$REGION 'documentation'}
{
  @abstract(Word list interfcase)
}
{$ENDREGION}
  IWordList = interface(IIterableList<IText>)
    ['{EC3DEF33-2DFA-46A4-9269-FD0DC4A470B2}']
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IWordList))
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}

  TWordList = class sealed(TIterableList<IText>, IWordList)
  public
    class function New: IWordList;
  end;

{$REGION 'documentation'}
{
  @abstract(Text object)
  Split a text in a list of words based on a delimiter identifier
  @member(
    Execute Inspects each letter in the text identifying word delimiters and divide it into elements
    @param(Text Source text)
    @param(WordSplitIdentifier @link(IWordSplitIdentifier Word delimiter identificator))
    @return(@link(IWordList A list of words))
  )
}
{$ENDREGION}

  ITextSplit = interface
    ['{FB727433-D2FF-422C-B6FA-4B9221D778A8}']
    function Execute(const Text: IText; const WordSplitIdentifier: IWordSplitIdentifier): IWordList;
  end;
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ITextSplit))
  @member(Execute @seealso(ITextSplit.Execute))
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}

  TTextSplit = class sealed(TInterfacedObject, ITextSplit)
  public
    function Execute(const Text: IText; const WordSplitIdentifier: IWordSplitIdentifier): IWordList;
    class function New: ITextSplit;
  end;

implementation

function TTextSplit.Execute(const Text: IText; const WordSplitIdentifier: IWordSplitIdentifier): IWordList;
var
  i: Integer;
  Word: String;
begin
  Word := EmptyStr;
  Result := TWordList.New;
  for i := 1 to Text.Size do
  begin
    if WordSplitIdentifier.IsDelimiter(Text.Value, i) then
    begin
      Result.Add(TText.New(Word));
      Word := EmptyStr;
    end
    else
      Word := Word + Text.Value[i];
  end;
  if Length(Word) > 0 then
    Result.Add(TText.New(Word));
end;

class function TTextSplit.New: ITextSplit;
begin
  Result := TTextSplit.Create;
end;

{ TWordList }

class function TWordList.New: IWordList;
begin
  Result := TWordList.Create;
end;

end.
