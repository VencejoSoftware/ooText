{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit RandomText_test;

interface

uses
  SysUtils,
  RandomText,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TRandomTextTest = class sealed(TTestCase)
  published
    procedure RandomTextWithSize9ReturnSize9;
    procedure RandomTextWithSize9IsNotEmptyText;
    procedure RandomTextWithSize0ReturnIsEmptyTrue;
    procedure RandomTextWithSize10ReturnIsEmptyFalse;
    procedure NewWithCharMapWithSize1ReturnA;
  end;

implementation

procedure TRandomTextTest.RandomTextWithSize9ReturnSize9;
begin
  CheckEquals(9, TRandomText.New(9).Size);
end;

procedure TRandomTextTest.RandomTextWithSize9IsNotEmptyText;
begin
  CheckTrue(TRandomText.New(9).Value <> EmptyStr);
end;

procedure TRandomTextTest.RandomTextWithSize0ReturnIsEmptyTrue;
begin
  CheckTrue(TRandomText.New(0).IsEmpty);
end;

procedure TRandomTextTest.RandomTextWithSize10ReturnIsEmptyFalse;
begin
  CheckFalse(TRandomText.New(10).IsEmpty);
end;

procedure TRandomTextTest.NewWithCharMapWithSize1ReturnA;
begin
  CheckEquals('A', TRandomText.NewWithCharMap('A', 1).Value);
end;

initialization

RegisterTest(TRandomTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
