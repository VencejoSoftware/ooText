{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Stencil.Wildcard;

interface

uses
  SysUtils;

type
  TTextStencilWildcardType = (swtNone, swtOverwrite, swtFixedStart, swtFixedEnd, swtLowerCase, swtUpperCase);

  ITextStencilWildcard = interface
    ['{B3B26E8A-B9BB-4607-A3C7-4B4CDE0EDAD1}']
    function IsWildcard(const Letter: Char): Boolean;
    function WildcardType(const Letter: Char): TTextStencilWildcardType;
  end;

  TTextStencilWildcard = class(TInterfacedObject, ITextStencilWildcard)
  strict private
  const
    WILDCARDS: array [TTextStencilWildcardType] of Char = (#0, '?', '(', ')', '<', '>');
  public
    function IsWildcard(const Letter: Char): Boolean;
    function WildcardType(const Letter: Char): TTextStencilWildcardType;
    class function New: ITextStencilWildcard;
  end;

implementation

function TTextStencilWildcard.WildcardType(const Letter: Char): TTextStencilWildcardType;
var
  ItemType: TTextStencilWildcardType;
begin
  Result := swtNone;
  for ItemType := low(TTextStencilWildcardType) to high(TTextStencilWildcardType) do
    if Letter = WILDCARDS[ItemType] then
    begin
      Result := ItemType;
      Break;
    end;
end;

function TTextStencilWildcard.IsWildcard(const Letter: Char): Boolean;
begin
  Result := WildcardType(Letter) <> swtNone;
end;

class function TTextStencilWildcard.New: ITextStencilWildcard;
begin
  Result := TTextStencilWildcard.Create;
end;

end.
