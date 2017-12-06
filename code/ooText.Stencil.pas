{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Stencil;

interface

uses
  SysUtils,
  ooText.Stencil.Wildcard,
  ooText;

type
  ITextStencil = interface(IText)
    ['{7D547FB4-61B2-459B-BF89-6AE71F58FE15}']
    function IsApplicable: Boolean;
  end;

  TTextStencil = class sealed(TInterfacedObject, ITextStencil)
  strict private
    _Value, _Pattern: String;
    _MaskWildcard: ITextStencilWildcard;
  public
    function Size: Integer;
    function Value: String;
    function IsEmpty: Boolean;
    function IsApplicable: Boolean;

    constructor Create(const Text: IText; const Pattern: String; MaskWildcard: ITextStencilWildcard);

    class function New(const Text: IText; const Pattern: String): ITextStencil;
    class function NewFromString(const Text, Pattern: String): ITextStencil;
  end;

implementation

function TTextStencil.Size: Integer;
begin
  Result := Length(_Value);
end;

function TTextStencil.Value: String;
var
  Index, ValueIndex: Integer;
  TextType, LastModeType: TTextStencilWildcardType;
  Text: String;
begin
  Result := EmptyStr;
  LastModeType := swtNone;
  ValueIndex := 1;
  for Index := 1 to Length(_Pattern) do
  begin
    TextType := _MaskWildcard.WildcardType(_Pattern[Index]);
    if TextType in [swtFixedStart, swtFixedEnd, swtLowerCase, swtUpperCase] then
    begin
      LastModeType := TextType;
    end
    else
    begin
      case TextType of
        swtNone: Text := _Pattern[Index];
        swtOverwrite: Text := _Value[ValueIndex];
      end;
      case LastModeType of
        swtUpperCase: Text := UpperCase(Text);
        swtLowerCase: Text := LowerCase(Text);
      end;
      if not (LastModeType = swtFixedStart) then
        Inc(ValueIndex);
      Result := Result + Text;
    end;
  end;
end;

function TTextStencil.IsApplicable: Boolean;
var
  Index: Integer;
  TextLetter, PatternLetter: Char;
begin
  Result := False;
  for Index := 1 to Length(_Pattern) do
  begin
    TextLetter := _Value[Index];
    PatternLetter := _Pattern[Index];
    Result := _MaskWildcard.IsWildcard(PatternLetter) or (TextLetter = PatternLetter);
    if not Result then
      Break;
  end;
end;

function TTextStencil.IsEmpty: Boolean;
begin
  Result := Size < 1;
end;

constructor TTextStencil.Create(const Text: IText; const Pattern: String; MaskWildcard: ITextStencilWildcard);
begin
  _Value := Text.Value;
  _MaskWildcard := MaskWildcard;
  _Pattern := Pattern;
end;

class function TTextStencil.New(const Text: IText; const Pattern: String): ITextStencil;
begin
  Result := TTextStencil.Create(Text, Pattern, TTextStencilWildcard.New);
end;

class function TTextStencil.NewFromString(const Text, Pattern: String): ITextStencil;
begin
  Result := TTextStencil.New(TText.New(Text), Pattern);
end;

end.
