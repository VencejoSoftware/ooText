{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.ToWords_test;

interface

uses
  SysUtils,
  ooText.ToWords,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextToWordsTest = class(TTestCase)
  private const
    TEXT_TEST = 'Some text to test splitter mechanism, none more!';
  published
    procedure WordCount;
    procedure SecondWordIsText;
    procedure ValueAssigned;
    procedure TextIsEmpty;
    procedure TextIsNotEmpty;
    procedure ComaAsWordSeparator;
  end;

implementation

procedure TTextToWordsTest.ComaAsWordSeparator;
var
  TextToWords: ITextToWords;
begin
  TextToWords := TTextToWords.NewFromString(TEXT_TEST, [',']);
  CheckEquals(2, TextToWords.Size);
  CheckEquals(' none more!', TextToWords.WordList.Items[1].Value);
end;

procedure TTextToWordsTest.ValueAssigned;
var
  TextToWords: ITextToWords;
begin
  TextToWords := TTextToWords.NewFromString(TEXT_TEST);
  CheckEquals(TEXT_TEST, TextToWords.Value);
end;

procedure TTextToWordsTest.SecondWordIsText;
var
  TextToWords: ITextToWords;
begin
  TextToWords := TTextToWords.NewFromString(TEXT_TEST);
  CheckEquals('text', TextToWords.WordList.Items[1].Value);
end;

procedure TTextToWordsTest.TextIsEmpty;
begin
  CheckTrue(TTextToWords.NewFromString(EmptyStr).IsEmpty);
end;

procedure TTextToWordsTest.TextIsNotEmpty;
begin
  CheckFalse(TTextToWords.NewFromString(TEXT_TEST).IsEmpty);
end;

procedure TTextToWordsTest.WordCount;
var
  TextToWords: ITextToWords;
begin
  TextToWords := TTextToWords.NewFromString(TEXT_TEST);
  CheckEquals(9, TextToWords.Size);
end;

initialization

RegisterTest(TTextToWordsTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
