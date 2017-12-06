{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Cutted_test;

interface

uses
  SysUtils,
  ooText.Cutted,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextCuttedTest = class(TTestCase)
  published
    procedure FirstPartIsText;
    procedure SecondPartIsToCut;
    procedure IsCuttedFalse;
    procedure NoneWithPositionZero;
    procedure SecondPartEmpty;
    procedure FirstPartEmpty;
  end;

implementation

procedure TTextCuttedTest.FirstPartEmpty;
var
  TextCutted: ITextCutted;
begin
  TextCutted := TTextCutted.New(EmptyStr, 1);
  CheckEquals(EmptyStr, TextCutted.FirstPart);
end;

procedure TTextCuttedTest.FirstPartIsText;
var
  TextCutted: ITextCutted;
begin
  TextCutted := TTextCutted.New('Text to cut', 5);
  CheckEquals('Text ', TextCutted.FirstPart);
end;

procedure TTextCuttedTest.SecondPartEmpty;
var
  TextCutted: ITextCutted;
begin
  TextCutted := TTextCutted.New('Text to cut', 11);
  CheckEquals(EmptyStr, TextCutted.EndPart);
end;

procedure TTextCuttedTest.SecondPartIsToCut;
var
  TextCutted: ITextCutted;
begin
  TextCutted := TTextCutted.New('Text to cut', 5);
  CheckEquals('to cut', TextCutted.EndPart);
end;

procedure TTextCuttedTest.IsCuttedFalse;
begin
  CheckFalse(TTextCutted.New('Text to cut', Length('Text to cut')).IsCutted);
end;

procedure TTextCuttedTest.NoneWithPositionZero;
var
  TextCutted: ITextCutted;
begin
  TextCutted := TTextCutted.New('Text to cut', 0);
  CheckEquals(EmptyStr, TextCutted.EndPart);
end;

initialization

RegisterTest(TTextCuttedTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
