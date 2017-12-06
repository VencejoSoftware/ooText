{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.PlainMoney;

interface

uses
  SysUtils, Math,
  ooText.PadZeros,
  ooText;

type
  TTextPlainMoney = class sealed(TInterfacedObject, IText)
  strict private
    _Value: String;
  private
    function Generate(const CurrencyValue: Currency; const PadCount, Digits: Byte): string;
  public
    function Size: Integer;
    function Value: String;
    function IsEmpty: Boolean;

    constructor Create(const CurrencyValue: Currency; const PadCount, Digits: Byte);

    class function New(const CurrencyValue: Currency; const PadCount, Digits: Byte): IText;
  end;

implementation

function TTextPlainMoney.Generate(const CurrencyValue: Currency; const PadCount, Digits: Byte): string;
var
  dValue: Currency;
  Convert: ShortString;
begin
  if PadCount > 0 then
  begin
    dValue := Abs(CurrencyValue * power(10, Digits));
    Str(dValue: PadCount: 0, Convert);
    Result := TTextLeftPad.NewFromString(Trim(String(Convert)), PadCount, '0').Value;
  end
  else
  begin
    Result := EmptyStr;
  end;
end;

function TTextPlainMoney.Value: String;
begin
  Result := _Value;
end;

function TTextPlainMoney.IsEmpty: Boolean;
begin
  Result := Size < 1;
end;

function TTextPlainMoney.Size: Integer;
begin
  Result := Length(_Value);
end;

constructor TTextPlainMoney.Create(const CurrencyValue: Currency; const PadCount, Digits: Byte);
begin
  _Value := Generate(CurrencyValue, PadCount, Digits);
end;

class function TTextPlainMoney.New(const CurrencyValue: Currency; const PadCount, Digits: Byte): IText;
begin
  Result := TTextPlainMoney.Create(CurrencyValue, PadCount, Digits);
end;

end.
