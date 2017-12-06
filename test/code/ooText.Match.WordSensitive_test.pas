{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Match.WordSensitive_test;

interface

uses
  ooText.Match.Intf, ooText.Match.WordSensitive,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextMatchWordSensitiveTest = class(TTestCase)
  private const
    TEXT_TEST = 'Some text to test splitter mechanism, none more! Or repeat any texttext (text)?';
  published
    procedure FoundStart;
    procedure FoundEnd;
    procedure FindSomeNotFound;
    procedure FindSome;
    procedure FindSomeFromPosNotFound;
    procedure FindSomeFromPos;
  end;

implementation

procedure TTextMatchWordSensitiveTest.FoundStart;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextMatchWordSensitive.New;
  TextMatch.Find(TEXT_TEST, 'mechanism', 1);
  CheckEquals(28, TextMatch.FoundStart);
end;

procedure TTextMatchWordSensitiveTest.FoundEnd;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextMatchWordSensitive.New;
  TextMatch.Find(TEXT_TEST, 'mechanism', 1);
  CheckEquals(36, TextMatch.FoundEnd);
end;

procedure TTextMatchWordSensitiveTest.FindSome;
begin
  CheckTrue(TTextMatchWordSensitive.New.Find(TEXT_TEST, 'mechanism', 1));
end;

procedure TTextMatchWordSensitiveTest.FindSomeNotFound;
begin
  CheckFalse(TTextMatchWordSensitive.New.Find(TEXT_TEST, 'Mechanism', 1));
end;

procedure TTextMatchWordSensitiveTest.FindSomeFromPos;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextMatchWordSensitive.New;
  TextMatch.Find(TEXT_TEST, 'text', 10);
  CheckEquals(74, TextMatch.FoundStart);
  CheckEquals(77, TextMatch.FoundEnd);
  CheckEquals('text', Copy(TEXT_TEST, TextMatch.FoundStart, Succ(TextMatch.FoundEnd - TextMatch.FoundStart)));
end;

procedure TTextMatchWordSensitiveTest.FindSomeFromPosNotFound;
begin
  CheckFalse(TTextMatchWordSensitive.New.Find(TEXT_TEST, 'mechanism', 40));
end;

initialization

RegisterTest(TTextMatchWordSensitiveTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
