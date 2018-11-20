{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit PlainMoneyText_test;

interface

uses
  SysUtils,
  PlainMoneyText,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TPlainMoneyTextTest = class sealed(TTestCase)
  published
    procedure Value12345WithPad10ReturnSize10;
    procedure Value12345WithoutRoundReturn0000000123;
    procedure Value12345WidhPad10And4DigitsReturn0001234500;
    procedure Value0With0PadAndRound0ReturnEmpty;
    procedure Value12345WithPad10And4DigitsIsNotEmpty;
  end;

implementation

procedure TPlainMoneyTextTest.Value12345WithPad10ReturnSize10;
begin
  CheckEquals(10, TPlainMoneyText.New(123.45, 10, 4).Size);
end;

procedure TPlainMoneyTextTest.Value12345WithoutRoundReturn0000000123;
begin
  CheckEquals('0000000123', TPlainMoneyText.New(123.45, 10, 0).Value);
end;

procedure TPlainMoneyTextTest.Value12345WidhPad10And4DigitsReturn0001234500;
begin
  CheckEquals('0001234500', TPlainMoneyText.New(123.45, 10, 4).Value);
end;

procedure TPlainMoneyTextTest.Value0With0PadAndRound0ReturnEmpty;
begin
  CheckTrue(TPlainMoneyText.New(0, 0, 0).IsEmpty);
end;

procedure TPlainMoneyTextTest.Value12345WithPad10And4DigitsIsNotEmpty;
begin
  CheckFalse(TPlainMoneyText.New(123.45, 10, 4).IsEmpty);
end;

initialization

RegisterTest(TPlainMoneyTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
