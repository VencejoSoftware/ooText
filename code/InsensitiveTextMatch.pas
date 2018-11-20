{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Insensitive text matcher object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit InsensitiveTextMatch;

interface

uses
  Text, UpperText,
  TextLocation,
  TextMatch,
  SensitiveTextMatch;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ITextMatch))
  Match a subtext ignoring char case mode
  @member(Find @seealso(ITextMatch.Find))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}
  TInsensitiveTextMatch = class sealed(TInterfacedObject, ITextMatch)
  public
    function Find(const Text, ToFind: IText; const StartAt: Cardinal): ITextLocation;
    class function New: ITextMatch;
  end;

implementation

function TInsensitiveTextMatch.Find(const Text, ToFind: IText; const StartAt: Cardinal): ITextLocation;
begin
  Result := TSensitiveTextMatch.New.Find(TUpperText.New(Text), TUpperText.New(ToFind), StartAt);
end;

class function TInsensitiveTextMatch.New: ITextMatch;
begin
  Result := TInsensitiveTextMatch.Create;
end;

end.
