{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.MatchSensitive_test;

interface

uses
  ooText.Match.Intf, ooText.Match.Sensitive,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextMatchSensitiveTest = class(TTestCase)
  published
    procedure FoundStart;
    procedure FoundEnd;
    procedure FindSomeNotFound;
    procedure FindSome;
    procedure FindSomeFromPosNotFound;
    procedure FindSomeFromPos;
  end;

implementation

procedure TTextMatchSensitiveTest.FoundStart;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextMatchSensitive.New;
  TextMatch.Find('Something to Match text', 'to', 1);
  CheckEquals(11, TextMatch.FoundStart);
end;

procedure TTextMatchSensitiveTest.FoundEnd;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextMatchSensitive.New;
  TextMatch.Find('Something to Match text', 'ch', 1);
  CheckEquals(18, TextMatch.FoundEnd);
end;

procedure TTextMatchSensitiveTest.FindSome;
begin
  CheckTrue(TTextMatchSensitive.New.Find('Something to Match text', 'to', 1));
end;

procedure TTextMatchSensitiveTest.FindSomeNotFound;
begin
  CheckFalse(TTextMatchSensitive.New.Find('Something to Match text', 'TuO', 1));
end;

procedure TTextMatchSensitiveTest.FindSomeFromPos;
const
  TEXT_TEST = 'Something to Match text in object Match mode';
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextMatchSensitive.New;
  TextMatch.Find(TEXT_TEST, 'Match', 20);
  CheckEquals(35, TextMatch.FoundStart);
  CheckEquals(39, TextMatch.FoundEnd);
  CheckEquals('Match', Copy(TEXT_TEST, TextMatch.FoundStart, Succ(TextMatch.FoundEnd - TextMatch.FoundStart)));
end;

procedure TTextMatchSensitiveTest.FindSomeFromPosNotFound;
begin
  CheckFalse(TTextMatchSensitive.New.Find('Something to Match text', 'to', 12));
end;

initialization

RegisterTest(TTextMatchSensitiveTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
