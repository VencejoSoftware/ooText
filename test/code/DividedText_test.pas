{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit DividedText_test;

interface

uses
  SysUtils,
  DividedText,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TDividedTextTest = class sealed(TTestCase)
  published
    procedure Position1ReturnEmptyLeftPart;
    procedure Position11ReturnEmptySecondPart;
    procedure LeftPartIsText;
    procedure SecondPartIsToCut;
    procedure IsDividedFalse;
    procedure NoneWithPositionZero;
  end;

implementation

procedure TDividedTextTest.Position1ReturnEmptyLeftPart;
var
  DividedText: IDividedText;
begin
  DividedText := TDividedText.New(EmptyStr, 1);
  CheckEquals(EmptyStr, DividedText.LeftPart);
end;

procedure TDividedTextTest.Position11ReturnEmptySecondPart;
var
  DividedText: IDividedText;
begin
  DividedText := TDividedText.New('Text to cut', 11);
  CheckEquals(EmptyStr, DividedText.RightPart);
end;

procedure TDividedTextTest.LeftPartIsText;
var
  DividedText: IDividedText;
begin
  DividedText := TDividedText.New('Text to cut', 5);
  CheckEquals('Text ', DividedText.LeftPart);
end;

procedure TDividedTextTest.SecondPartIsToCut;
var
  DividedText: IDividedText;
begin
  DividedText := TDividedText.New('Text to cut', 5);
  CheckEquals('to cut', DividedText.RightPart);
end;

procedure TDividedTextTest.IsDividedFalse;
begin
  CheckFalse(TDividedText.New('Text to cut', Length('Text to cut')).IsDivided);
end;

procedure TDividedTextTest.NoneWithPositionZero;
var
  DividedText: IDividedText;
begin
  DividedText := TDividedText.New('Text to cut', 0);
  CheckEquals(EmptyStr, DividedText.RightPart);
end;

initialization

RegisterTest(TDividedTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
