{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Stencil template pattern object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit StencilText;

interface

uses
  SysUtils,
  StencilTextWildcardIdentifier,
  Text;

type
{$REGION 'documentation'}
{
  @abstract(Stencil template pattern object)
  Apply a wildcard pattern over text source
  @member(
    Apply Apply stencil pattern
    @param(Text Source text)
    @param(Pattern Wildcard stencil pattern)
    @return(Text stenciled)
  )
  @member(
    IsFullApplicable Checks if pattern can be applied to the source text
    @param(Text Source text)
    @param(Pattern Wildcard stencil pattern)
    @return(@true if can apply, @false if not)
  )
}
{$ENDREGION}
  IStencilText = interface
    ['{7D547FB4-61B2-459B-BF89-6AE71F58FE15}']
    function Apply(const Text, Pattern: IText): String;
    function IsFullApplicable(const Text, Pattern: IText): Boolean;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IStencilText))
  @member(Apply @seealso(IStencilText.Apply))
  @member(IsFullApplicable @seealso(IStencilText.IsFullApplicable))
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}

  TStencilText = class sealed(TInterfacedObject, IStencilText)
  strict private
    _WildcardIdentifier: IStencilTextWildcardIdentifier;
  public
    function Apply(const Text, Pattern: IText): String;
    function IsFullApplicable(const Text, Pattern: IText): Boolean;
    constructor Create(const WildcardIdentifier: IStencilTextWildcardIdentifier);
    class function New(const WildcardIdentifier: IStencilTextWildcardIdentifier): IStencilText;
  end;

implementation

function TStencilText.Apply(const Text, Pattern: IText): String;
var
  Index, ValueIndex: Cardinal;
  TextType, LastModeType: TStencilTextWildcardKind;
  Letter: String;
begin
  Result := EmptyStr;
  if Text.Size = 0 then
    Exit;
  LastModeType := None;
  ValueIndex := 1;
  for Index := 1 to Pattern.Size do
  begin
    TextType := _WildcardIdentifier.WildcardKind(Pattern.Value[Index]);
    if TextType in [FixedStart, FixedEnd, LowerCase, UpperCase] then
    begin
      LastModeType := TextType;
    end
    else
    begin
      case TextType of
        None:
          Letter := Pattern.Value[Index];
        Overwrite:
          Letter := Text.Value[ValueIndex];
      end;
      case LastModeType of
        UpperCase:
          Letter := SysUtils.UpperCase(Letter);
        LowerCase:
          Letter := SysUtils.LowerCase(Letter);
      end;
      if not (LastModeType = FixedStart) then
        Inc(ValueIndex);
      Result := Result + Letter;
    end;
  end;
end;

function TStencilText.IsFullApplicable(const Text, Pattern: IText): Boolean;
var
  Index: Cardinal;
  TextLetter, PatternLetter: Char;
begin
  Result := False;
  if Text.Size = Pattern.Size then
    for Index := 1 to Pattern.Size do
    begin
      TextLetter := Text.Value[Index];
      PatternLetter := Pattern.Value[Index];
      Result := _WildcardIdentifier.IsWildcard(PatternLetter) or (TextLetter = PatternLetter);
      if not Result then
        Break;
    end;
end;

constructor TStencilText.Create(const WildcardIdentifier: IStencilTextWildcardIdentifier);
begin
  _WildcardIdentifier := WildcardIdentifier;
end;

class function TStencilText.New(const WildcardIdentifier: IStencilTextWildcardIdentifier): IStencilText;
begin
  Result := TStencilText.Create(WildcardIdentifier);
end;

end.
