{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Stencil text wildcard identifier object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit StencilTextWildcardIdentifier;

interface

uses
  SysUtils;

type
  TStencilTextWildcardKind = (None, Overwrite, FixedStart, FixedEnd, LowerCase, UpperCase);

{$REGION 'documentation'}
{
  @abstract(Stencil text wildcard identifier object)
  Based in a letter determines if is a wildcard symbol
  @member(
    IsWildcard Checks if a letter is a wildcard symbol
    @param(Letter Letter to check)
    @return(@true if letter is a wildcard symbol, @false if not)
  )
  @member(
    WildcardKind Identificates the wildcard symbol kind based on a letter
    @param(Letter Letter to check)
    @return(Symbol kind)
  )
}
{$ENDREGION}

  IStencilTextWildcardIdentifier = interface
    ['{B3B26E8A-B9BB-4607-A3C7-4B4CDE0EDAD1}']
    function IsWildcard(const Letter: Char): Boolean;
    function WildcardKind(const Letter: Char): TStencilTextWildcardKind;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IStencilTextWildcardIdentifier))
  @member(IsWildcard @seealso(IStencilTextWildcardIdentifier.IsWildcard))
  @member(WildcardKind @seealso(IStencilTextWildcardIdentifier.WildcardKind))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}

  TStencilTextWildcardIdentifier = class(TInterfacedObject, IStencilTextWildcardIdentifier)
  strict private
  const
    WILDCARDS: array [TStencilTextWildcardKind] of Char = (#0, '?', '(', ')', '<', '>');
  public
    function IsWildcard(const Letter: Char): Boolean;
    function WildcardKind(const Letter: Char): TStencilTextWildcardKind;
    class function New: IStencilTextWildcardIdentifier;
  end;

implementation

function TStencilTextWildcardIdentifier.WildcardKind(const Letter: Char): TStencilTextWildcardKind;
var
  ItemType: TStencilTextWildcardKind;
begin
  Result := None;
  for ItemType := low(TStencilTextWildcardKind) to high(TStencilTextWildcardKind) do
    if Letter = WILDCARDS[ItemType] then
      Exit(ItemType);
end;

function TStencilTextWildcardIdentifier.IsWildcard(const Letter: Char): Boolean;
begin
  Result := WildcardKind(Letter) <> None;
end;

class function TStencilTextWildcardIdentifier.New: IStencilTextWildcardIdentifier;
begin
  Result := TStencilTextWildcardIdentifier.Create;
end;

end.
