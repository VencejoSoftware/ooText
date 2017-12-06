{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.FromArray_test;

interface

uses
  ooText.FromArray,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextFromArrayTest = class(TTestCase)
  published
    procedure TextSize;
    procedure ValueAssignedWithSepecificSeparator;
    procedure ValueAssigned;
    procedure TextIsEmpty;
    procedure TextIsNotEmpty;
  end;

implementation

procedure TTextFromArrayTest.ValueAssignedWithSepecificSeparator;
begin
  CheckEquals('1; a; b; last', TTextFromArray.New(['1', 'a', 'b', 'last'], '; ').Value);
end;

procedure TTextFromArrayTest.ValueAssigned;
begin
  CheckEquals('1,a,b,last', TTextFromArray.New(['1', 'a', 'b', 'last']).Value);
end;

procedure TTextFromArrayTest.TextIsEmpty;
begin
  CheckTrue(TTextFromArray.New([]).IsEmpty);
end;

procedure TTextFromArrayTest.TextIsNotEmpty;
begin
  CheckFalse(TTextFromArray.New(['1', 'a', 'b', 'last']).IsEmpty);
end;

procedure TTextFromArrayTest.TextSize;
begin
  CheckEquals(10, TTextFromArray.New(['1', 'a', 'b', 'last']).Size);
end;

initialization

RegisterTest(TTextFromArrayTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
