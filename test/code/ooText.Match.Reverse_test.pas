{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Match.Reverse_test;

interface

uses
  SysUtils,
  ooText.Match.Intf,
  ooText.Match.Reverse,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextFindReverseTest = class(TTestCase)
  published
    procedure FindReverseNoneSubText;
    procedure FindReverseNoneSource;
    procedure FindReverseTextLast;
    procedure FindReverseTextFirst;
    procedure FindReverseTextMiddleWithOffset;
  end;

implementation

procedure TTextFindReverseTest.FindReverseNoneSource;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextFindReverse.New;
  TextMatch.Find(EmptyStr, 'text', 0);
  CheckEquals(0, TextMatch.FoundStart);
end;

procedure TTextFindReverseTest.FindReverseNoneSubText;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextFindReverse.New;
  TextMatch.Find('text to test the text', EmptyStr, 0);
  CheckEquals(0, TextMatch.FoundStart);
end;

procedure TTextFindReverseTest.FindReverseTextFirst;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextFindReverse.New;
  TextMatch.Find('text to test the texT', 'text', 0);
  CheckEquals(1, TextMatch.FoundStart);
  CheckEquals(4, TextMatch.FoundEnd);
end;

procedure TTextFindReverseTest.FindReverseTextMiddleWithOffset;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextFindReverse.New;
  TextMatch.Find('text to test any text in the text', 'text', 5);
  CheckEquals(18, TextMatch.FoundStart);
  CheckEquals(21, TextMatch.FoundEnd);
end;

procedure TTextFindReverseTest.FindReverseTextLast;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextFindReverse.New;
  TextMatch.Find('text to test the text', 'text', 0);
  CheckEquals(18, TextMatch.FoundStart);
  CheckEquals(21, TextMatch.FoundEnd);
end;

initialization

RegisterTest(TTextFindReverseTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
