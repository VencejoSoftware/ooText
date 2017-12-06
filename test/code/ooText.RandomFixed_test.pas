{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.RandomFixed_test;

interface

uses
  SysUtils,
  ooText.RandomFixed,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TRandomTextFixedTest = class(TTestCase)
  published
    procedure TextSize;
    procedure ValueAssigned;
    procedure TextIsEmpty;
  end;

implementation

procedure TRandomTextFixedTest.ValueAssigned;
begin
  CheckTrue(TRandomTextFixed.New.Value <> EmptyStr);
end;

procedure TRandomTextFixedTest.TextIsEmpty;
begin
  CheckFalse(TRandomTextFixed.New.IsEmpty);
end;

procedure TRandomTextFixedTest.TextSize;
begin
  CheckEquals(88, TRandomTextFixed.New.Size);
end;

initialization

RegisterTest(TRandomTextFixedTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
