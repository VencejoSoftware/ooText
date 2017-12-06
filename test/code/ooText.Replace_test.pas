{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Replace_test;

interface

uses
  SysUtils,
  ooText.Match.WordInsensitive, ooText.Match.WordSensitive,
  ooText.Match.Sensitive, ooText.Match.Insensitive,
  ooText.Replace,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TStringReplaceTest = class(TTestCase)
  private const
    TEXT_TEST = 'text to replace texto in Text(teXT)';
  published
    procedure ReplaceInsensitiveWholeWordOneMatch;
    procedure ReplaceInsensitiveWholeWordAll;
    procedure ReplaceInsensitiveNotMatch;
    procedure NotReplaceInsensitiveWordWithOutDelimited;
    procedure ReplaceSensitiveWholeWordAll;
    procedure ReplaceSensitiveWholeWordNotMatch;
    procedure ReplaceInsensitiveQuotedWord;
    procedure ReplaceInsensitiveGluePrev;
    procedure ReplaceInsensitiveGlueNext;
    procedure ReplaceInsensitiveOneMatch;
  end;

implementation

procedure TStringReplaceTest.ReplaceInsensitiveWholeWordOneMatch;
var
  TextReplace: ITextReplace;
begin
  TextReplace := TTextReplace.NewFromString(TEXT_TEST, TTextMatchWordInsensitive.New);
  CheckEquals('replaced to replace texto in Text(teXT)', TextReplace.OneMatch('TEXt', 'replaced'));
end;

procedure TStringReplaceTest.ReplaceSensitiveWholeWordAll;
var
  TextReplace: ITextReplace;
begin
  TextReplace := TTextReplace.NewFromString(TEXT_TEST, TTextMatchWordSensitive.New);
  CheckEquals('text to replace texto in Text(replaced)', TextReplace.AllMatches('teXT', 'replaced', 1));
end;

procedure TStringReplaceTest.ReplaceSensitiveWholeWordNotMatch;
var
  TextReplace: ITextReplace;
begin
  TextReplace := TTextReplace.NewFromString(TEXT_TEST, TTextMatchWordSensitive.New);
  CheckEquals(TEXT_TEST, TextReplace.AllMatches('nOneMatch', 'replaced', 1));
end;

procedure TStringReplaceTest.NotReplaceInsensitiveWordWithOutDelimited;
var
  TextReplace: ITextReplace;
begin
  TextReplace := TTextReplace.NewFromString('inParameter', TTextMatchWordInsensitive.New);
  CheckEquals('inParameter', TextReplace.AllMatches('in', 'not', 1));
end;

procedure TStringReplaceTest.ReplaceInsensitiveOneMatch;
begin
  CheckEquals('30{AppPath}demo_{Month}{Year}.log',
    TTextReplace.NewFromString('{WeekYear}{AppPath}demo_{Month}{Year}.log',
      TTextMatchInsensitive.New).AllMatches('{WeekYear}', '30'));
end;

procedure TStringReplaceTest.ReplaceInsensitiveGlueNext;
begin
  CheckEquals('Test :D 25 none, D@25', TTextReplace.NewFromString('Test :D D@ none, D@D@',
      TTextMatchWordInsensitive.New).AllMatches('D@', '25'));
end;

procedure TStringReplaceTest.ReplaceInsensitiveGluePrev;
begin
  CheckEquals('Test 25:D D: none, 25', TTextReplace.NewFromString('Test :D:D D: none, :D',
      TTextMatchWordInsensitive.New).AllMatches(':D', '25'));
end;

procedure TStringReplaceTest.ReplaceInsensitiveNotMatch;
var
  TextReplace: ITextReplace;
begin
  TextReplace := TTextReplace.NewFromString(TEXT_TEST, TTextMatchWordInsensitive.New);
  CheckEquals(TEXT_TEST, TextReplace.AllMatches('nOneMatch', 'replaced', 1));
end;

procedure TStringReplaceTest.ReplaceInsensitiveQuotedWord;
var
  TextReplace: ITextReplace;
begin
  TextReplace := TTextReplace.NewFromString('Text to replace "current" word, with another current word in text',
    TTextMatchWordInsensitive.New);
  CheckEquals('Text to replace "something" word, with another current word in text',
    TextReplace.OneMatch('current', 'something'));
  CheckFalse(TextReplace.IsEmpty);
  CheckEquals(65, TextReplace.Size);
end;

procedure TStringReplaceTest.ReplaceInsensitiveWholeWordAll;
var
  TextReplace: ITextReplace;
begin
  TextReplace := TTextReplace.NewFromString(TEXT_TEST, TTextMatchWordInsensitive.New);
  CheckEquals('replaced to replace texto in replaced(replaced)', TextReplace.AllMatches('TExt', 'replaced', 1));
end;

initialization

RegisterTest(TStringReplaceTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
