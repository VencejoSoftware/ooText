{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Random_test;

interface

uses
  SysUtils,
  ooText.Random,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TRandomTextTest = class(TTestCase)
  published
    procedure TextSize;
    procedure ValueAssigned;
    procedure TextIsEmpty;
    procedure TextIsNotEmpty;
  end;

implementation

procedure TRandomTextTest.ValueAssigned;
begin
  CheckTrue(TRandomText.New(9).Value <> EmptyStr);
end;

procedure TRandomTextTest.TextIsEmpty;
begin
  CheckTrue(TRandomText.New(0).IsEmpty);
end;

procedure TRandomTextTest.TextIsNotEmpty;
begin
  CheckFalse(TRandomText.New(10).IsEmpty);
end;

procedure TRandomTextTest.TextSize;
begin
  CheckEquals(9, TRandomText.New(9).Size);
end;

initialization

RegisterTest(TRandomTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
