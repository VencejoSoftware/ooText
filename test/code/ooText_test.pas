{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText_test;

interface

uses
  SysUtils,
  ooText,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextTest = class(TTestCase)
  published
    procedure TextSize;
    procedure DataAssigned;
    procedure TextIsEmpty;
    procedure TextIsNotEmpty;
  end;

implementation

procedure TTextTest.DataAssigned;
begin
  CheckEquals('Something', TText.New('Something').Value);
end;

procedure TTextTest.TextIsEmpty;
begin
  CheckTrue(TText.New(EmptyStr).IsEmpty);
end;

procedure TTextTest.TextIsNotEmpty;
begin
  CheckFalse(TText.New('Something').IsEmpty);
end;

procedure TTextTest.TextSize;
begin
  CheckEquals(9, TText.New('Something').Size);
end;

initialization

RegisterTest(TTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
