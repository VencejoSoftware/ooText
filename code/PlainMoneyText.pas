{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Money plain padded text object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit PlainMoneyText;

interface

uses
  SysUtils, Math,
  LetterPaddedText,
  Text;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IText))
  Creates a plain text from currency padded to left
  @member(Size @seealso(IText.Size))
  @member(Value @seealso(IText.Value))
  @member(IsEmpty @seealso(IText.IsEmpty))
  @member(
    RoundValue Round extended value
    @param(Value Curreyncy value)
    @param(Digits Maximun of digits when round)
    @return(Integer value)
  )
  @member(
    Build Construct money string
    @param(Value Curreyncy value)
    @param(PadAmount Pad repetitions)
    @param(Digits Maximun of digits when round)
    @return(Formatted string)
   )
  @member(
    Create Object constructor
    @param(Value Curreyncy value)
    @param(PadAmount Pad repetitions)
    @param(Digits Maximun of digits when round)
  )
  @member(
    New Create a new @classname as interface
    @param(Value Curreyncy value)
    @param(PadAmount Pad repetitions)
    @param(Digits Maximun of digits when round)
  )
}
{$ENDREGION}
  TPlainMoneyText = class sealed(TInterfacedObject, IText)
  strict private
    _Text: IText;
  private
    function RoundValue(const Value: Extended; const Digits: Byte): Cardinal;
    function Build(const Value: Extended; const PadAmount, Digits: Byte): string;
  public
    function Size: Cardinal;
    function Value: String;
    function IsEmpty: Boolean;
    constructor Create(const Value: Extended; const PadAmount, Digits: Byte);
    class function New(const Value: Extended; const PadAmount, Digits: Byte): IText;
  end;

implementation

function TPlainMoneyText.Size: Cardinal;
begin
  Result := _Text.Size;
end;

function TPlainMoneyText.Value: String;
begin
  Result := _Text.Value;
end;

function TPlainMoneyText.IsEmpty: Boolean;
begin
  Result := _Text.IsEmpty;
end;

function TPlainMoneyText.RoundValue(const Value: Extended; const Digits: Byte): Cardinal;
begin
  if Digits = 0 then
    Result := Trunc(Value)
  else
    Result := Trunc(Value * power(10, Digits));
end;

function TPlainMoneyText.Build(const Value: Extended; const PadAmount, Digits: Byte): string;
var
  Rounded: Cardinal;
begin
  if PadAmount > 0 then
  begin
    Rounded := RoundValue(Value, Digits);
    Result := TLetterPaddedText.NewFromString(FloatToStr(Rounded), PadAmount, '0', Left).Value;
  end
  else
    Result := EmptyStr;
end;

constructor TPlainMoneyText.Create(const Value: Extended; const PadAmount, Digits: Byte);
begin
  _Text := TText.New(Build(Value, PadAmount, Digits));
end;

class function TPlainMoneyText.New(const Value: Extended; const PadAmount, Digits: Byte): IText;
begin
  Result := TPlainMoneyText.Create(Value, PadAmount, Digits);
end;

end.
