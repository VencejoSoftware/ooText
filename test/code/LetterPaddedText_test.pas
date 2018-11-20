{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit LetterPaddedText_test;

interface

uses
  SysUtils,
  Text,
  LetterPaddedText,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TLetterPaddedTextTest = class sealed(TTestCase)
  published
    procedure LessRepetitionReturnMinLenSize;
    procedure AAAWith10RepetitionReturn10Size;
    procedure AAAWith10SpacesLeftReturnSpacedAAA;
    procedure AAAWith10SpacesRightReturnAAASpaced;
    procedure Right5Zeros999Return99900;
    procedure Left5Zeros999Return00999;
    procedure PadLessRepetitionReturnSource;
    procedure EmptyTextWithZeroRepetitionReturnEmpty;
    procedure EmptyTextWith1RepetitionReturnLetter;
  end;

implementation

procedure TLetterPaddedTextTest.LessRepetitionReturnMinLenSize;
begin
  CheckEquals(4, TLetterPaddedText.NewFromString('1234', 3, '0', Left).Size);
end;

procedure TLetterPaddedTextTest.AAAWith10RepetitionReturn10Size;
begin
  CheckEquals(10, TLetterPaddedText.NewFromString('AAA', 10, ' ', Left).Size);
end;

procedure TLetterPaddedTextTest.AAAWith10SpacesLeftReturnSpacedAAA;
begin
  CheckEquals('       AAA', TLetterPaddedText.NewFromString('AAA', 10, ' ', Left).Value);
end;

procedure TLetterPaddedTextTest.AAAWith10SpacesRightReturnAAASpaced;
begin
  CheckEquals('AAA       ', TLetterPaddedText.NewFromString('AAA', 10, ' ', Right).Value);
end;

procedure TLetterPaddedTextTest.Left5Zeros999Return00999;
begin
  CheckEquals('00999', TLetterPaddedText.New(TText.New('999'), 5, '0', Left).Value);
end;

procedure TLetterPaddedTextTest.Right5Zeros999Return99900;
begin
  CheckEquals('99900', TLetterPaddedText.New(TText.New('999'), 5, '0', Right).Value);
end;

procedure TLetterPaddedTextTest.PadLessRepetitionReturnSource;
begin
  CheckEquals('1234', TLetterPaddedText.NewFromString('1234', 3, '0', Left).Value);
end;

procedure TLetterPaddedTextTest.EmptyTextWithZeroRepetitionReturnEmpty;
begin
  CheckTrue(TLetterPaddedText.NewFromString(EmptyStr, 0, '-', Left).IsEmpty);
end;

procedure TLetterPaddedTextTest.EmptyTextWith1RepetitionReturnLetter;
begin
  CheckFalse(TLetterPaddedText.NewFromString(EmptyStr, 1, 'A', Left).IsEmpty);
end;

initialization

RegisterTest(TLetterPaddedTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
