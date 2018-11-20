{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ReplaceText_test;

interface

uses
  SysUtils,
  Text,
  WordSplitIdentifier,
  InsensitiveWordMatch, SensitiveWordMatch,
  SensitiveTextMatch, InsensitiveTextMatch,
  ReplaceText,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TStringReplaceTest = class sealed(TTestCase)
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
  ReplaceText: IReplaceText;
begin
  ReplaceText := TReplaceText.New(TInsensitiveWordMatch.NewDefault);
  CheckEquals('replaced to replace texto in Text(teXT)', ReplaceText.OneMatch(TText.New(TEXT_TEST), TText.New('TEXt'),
    TText.New('replaced'), 1).Value);
end;

procedure TStringReplaceTest.ReplaceSensitiveWholeWordAll;
var
  ReplaceText: IReplaceText;
begin
  ReplaceText := TReplaceText.New(TSensitiveWordMatch.NewDefault);
  CheckEquals('text to replace texto in Text(replaced)', ReplaceText.AllMatches(TText.New(TEXT_TEST), TText.New('teXT'),
    TText.New('replaced'), 1).Value);
end;

procedure TStringReplaceTest.ReplaceSensitiveWholeWordNotMatch;
var
  ReplaceText: IReplaceText;
begin
  ReplaceText := TReplaceText.New(TSensitiveWordMatch.NewDefault);
  CheckEquals(TEXT_TEST, ReplaceText.AllMatches(TText.New(TEXT_TEST), TText.New('nOneMatch'), TText.New('replaced'),
    1).Value);
end;

procedure TStringReplaceTest.NotReplaceInsensitiveWordWithOutDelimited;
var
  ReplaceText: IReplaceText;
begin
  ReplaceText := TReplaceText.New(TInsensitiveWordMatch.NewDefault);
  CheckEquals('inParameter', ReplaceText.AllMatches(TText.New('inParameter'), TText.New('in'), TText.New('not'),
    1).Value);
end;

procedure TStringReplaceTest.ReplaceInsensitiveOneMatch;
begin
  CheckEquals('30{AppPath}demo_{Month}{Year}.log', TReplaceText.New(TInsensitiveTextMatch.New)
    .AllMatches(TText.New('{WeekYear}{AppPath}demo_{Month}{Year}.log'), TText.New('{WeekYear}'), TText.New('30'),
    1).Value);
end;

procedure TStringReplaceTest.ReplaceInsensitiveGlueNext;
begin
  CheckEquals('Test :D 25 none, D@25', TReplaceText.New(TInsensitiveWordMatch.NewDefault)
    .AllMatches(TText.New('Test :D D@ none, D@D@'), TText.New('D@'), TText.New('25'), 1).Value);
end;

procedure TStringReplaceTest.ReplaceInsensitiveGluePrev;
begin
  CheckEquals('Test :D:D D: none, 25', TReplaceText.New(TInsensitiveWordMatch.New(TWordSplitIdentifier.New([' '])))
    .AllMatches(TText.New('Test :D:D D: none, :D'), TText.New(':D'), TText.New('25'), 1).Value);
end;

procedure TStringReplaceTest.ReplaceInsensitiveNotMatch;
var
  ReplaceText: IReplaceText;
begin
  ReplaceText := TReplaceText.New(TInsensitiveWordMatch.NewDefault);
  CheckEquals(TEXT_TEST, ReplaceText.AllMatches(TText.New(TEXT_TEST), TText.New('nOneMatch'), TText.New('replaced'),
    1).Value);
end;

procedure TStringReplaceTest.ReplaceInsensitiveQuotedWord;
var
  ReplaceText: IReplaceText;
begin
  ReplaceText := TReplaceText.New(TSensitiveWordMatch.NewDefault);
  CheckEquals('Text to replace "something" word, with another current word in text',
    ReplaceText.OneMatch(TText.New('Text to replace "current" word, with another current word in text'),
    TText.New('current'), TText.New('something'), 1).Value);
// CheckFalse(ReplaceText.IsEmpty);
// CheckEquals(65, ReplaceText.Size);
end;

procedure TStringReplaceTest.ReplaceInsensitiveWholeWordAll;
var
  ReplaceText: IReplaceText;
begin
  ReplaceText := TReplaceText.New(TInsensitiveWordMatch.NewDefault);
  CheckEquals('replaced to replace texto in replaced(replaced)', ReplaceText.AllMatches(TText.New(TEXT_TEST),
    TText.New('TExt'), TText.New('replaced'), 1).Value);
end;

initialization

RegisterTest(TStringReplaceTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
