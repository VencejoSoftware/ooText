{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit Text_test;

interface

uses
  SysUtils,
  Text,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextTest = class sealed(TTestCase)
  published
    procedure SizeIs9;
    procedure ValueIsSomething;
    procedure IsEmptyIsTrue;
    procedure IsEmptyIsFalse;
  end;

implementation

procedure TTextTest.SizeIs9;
begin
  CheckEquals(9, TText.New('Something').Size);
end;

procedure TTextTest.ValueIsSomething;
begin
  CheckEquals('Something', TText.New('Something').Value);
end;

procedure TTextTest.IsEmptyIsTrue;
begin
  CheckTrue(TText.New(EmptyStr).IsEmpty);
end;

procedure TTextTest.IsEmptyIsFalse;
begin
  CheckFalse(TText.New('Something').IsEmpty);
end;

initialization

RegisterTest(TTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
