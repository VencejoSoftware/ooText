{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.MoneyPlain_test;

interface

uses
  SysUtils,
  ooText.PlainMoney,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextPlainMoneyTest = class(TTestCase)
  published
    procedure TextSize;
    procedure ValueNonDigits;
    procedure ValueDigits;
    procedure TextIsEmpty;
    procedure TextIsNotEmpty;
  end;

implementation

procedure TTextPlainMoneyTest.ValueDigits;
begin
  CheckEquals('0001234500', TTextPlainMoney.New(123.45, 10, 4).Value);
end;

procedure TTextPlainMoneyTest.ValueNonDigits;
begin
  CheckEquals('0000000123', TTextPlainMoney.New(123.45, 10, 0).Value);
end;

procedure TTextPlainMoneyTest.TextIsEmpty;
begin
  CheckTrue(TTextPlainMoney.New(0, 0, 0).IsEmpty);
end;

procedure TTextPlainMoneyTest.TextIsNotEmpty;
begin
  CheckFalse(TTextPlainMoney.New(123.45, 10, 4).IsEmpty);
end;

procedure TTextPlainMoneyTest.TextSize;
begin
  CheckEquals(10, TTextPlainMoney.New(123.45, 10, 4).Size);
end;

initialization

RegisterTest(TTextPlainMoneyTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
