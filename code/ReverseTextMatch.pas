{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Reverse text match object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ReverseTextMatch;

interface

uses
  SysUtils,
  Text,
  TextLocation,
  TextMatch;

type

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ITextMatch))
  Match a subtext in reverse mode
  @member(Find @seealso(ITextMatch.Find))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}
  TReverseTextMatch = class sealed(TInterfacedObject, ITextMatch)
  public
    function Find(const Text, ToFind: IText; const StartAt: Cardinal): ITextLocation;
    class function New: ITextMatch;
  end;

implementation

function TReverseTextMatch.Find(const Text, ToFind: IText; const StartAt: Cardinal): ITextLocation;
var
  FoundStart, CurPos: Cardinal;
begin
  Result := nil;
  if ToFind.IsEmpty then
    Exit;
  FoundStart := 0;
  CurPos := Text.Size;
  while (CurPos > 0) and (FoundStart = 0) do
  begin
    if Copy(Text.Value, CurPos - StartAt, ToFind.Size) = ToFind.Value then
      Exit(TTextLocation.New(CurPos - StartAt, Pred(CurPos - StartAt + ToFind.Size)));
    Dec(CurPos);
  end;
end;

class function TReverseTextMatch.New: ITextMatch;
begin
  Result := TReverseTextMatch.Create;
end;

end.
