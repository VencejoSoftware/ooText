{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit TextLocation_test;

interface

uses
  SysUtils,
  TextLocation,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextLocationTest = class sealed(TTestCase)
  published
    procedure LocationStartIs10;
    procedure LocationFinishIs50;
    procedure Location10to40IsValid;
    procedure Location0to40IsInValid;
    procedure Location10to0IsInValid;
  end;

implementation

procedure TTextLocationTest.LocationStartIs10;
begin
  CheckEquals(10, TTextLocation.New(10, 0).StartAt);
end;

procedure TTextLocationTest.LocationFinishIs50;
begin
  CheckEquals(50, TTextLocation.New(0, 50).FinishAt);
end;

procedure TTextLocationTest.Location10to40IsValid;
begin
  CheckTrue(TTextLocation.New(10, 40).IsValid);
end;

procedure TTextLocationTest.Location0to40IsInValid;
begin
  CheckFalse(TTextLocation.New(0, 40).IsValid);
end;

procedure TTextLocationTest.Location10to0IsInValid;
begin
  CheckFalse(TTextLocation.New(10, 0).IsValid);
end;

initialization

RegisterTest(TTextLocationTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
