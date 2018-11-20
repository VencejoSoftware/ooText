{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Sensitive text matcher object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SensitiveTextMatch;

interface

uses
  StrUtils,
  Text,
  TextLocation,
  TextMatch;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ITextMatch))
  Match a subtext in sensitive char case mode
  @member(Find @seealso(ITextMatch.Find))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}
  TSensitiveTextMatch = class sealed(TInterfacedObject, ITextMatch)
  public
    function Find(const Text, ToFind: Itext; const StartAt: Cardinal): ITextLocation;
    class function New: ITextMatch;
  end;

implementation

function TSensitiveTextMatch.Find(const Text, ToFind: Itext; const StartAt: Cardinal): ITextLocation;
var
  FoundStart: Cardinal;
begin
  Result := nil;
  FoundStart := PosEx(ToFind.Value, Text.Value, StartAt);
  if FoundStart > 0 then
    Result := TTextLocation.New(FoundStart, Pred(FoundStart + ToFind.Size));
end;

class function TSensitiveTextMatch.New: ITextMatch;
begin
  Result := TSensitiveTextMatch.Create;
end;

end.
