{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.MatchInsensitive_test;

interface

uses
  ooText.Match.Intf, ooText.Match.Insensitive,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextMatchInsensitiveTest = class(TTestCase)
  published
    procedure FoundStart;
    procedure FoundEnd;
    procedure FindSomeNotFound;
    procedure FindSome;
    procedure FindSomeFromPosNotFound;
    procedure FindSomeFromPos;
  end;

implementation

procedure TTextMatchInsensitiveTest.FoundStart;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextMatchInsensitive.New;
  TextMatch.Find('Something to Match text', 'TO', 1);
  CheckEquals(11, TextMatch.FoundStart);
end;

procedure TTextMatchInsensitiveTest.FoundEnd;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextMatchInsensitive.New;
  TextMatch.Find('Something to Match text', 'TO', 1);
  CheckEquals(12, TextMatch.FoundEnd);
end;

procedure TTextMatchInsensitiveTest.FindSome;
begin
  CheckTrue(TTextMatchInsensitive.New.Find('Something to Match text', 'TO', 1));
end;

procedure TTextMatchInsensitiveTest.FindSomeNotFound;
begin
  CheckFalse(TTextMatchInsensitive.New.Find('Something to Match text', 'eARi', 1));
end;

procedure TTextMatchInsensitiveTest.FindSomeFromPos;
const
  TEXT_TEST = 'Something to Match text in object Match mode';
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextMatchInsensitive.New;
  TextMatch.Find(TEXT_TEST, 'Match', 20);
  CheckEquals(35, TextMatch.FoundStart);
  CheckEquals(39, TextMatch.FoundEnd);
  CheckEquals('Match', Copy(TEXT_TEST, TextMatch.FoundStart, Succ(TextMatch.FoundEnd - TextMatch.FoundStart)));
end;

procedure TTextMatchInsensitiveTest.FindSomeFromPosNotFound;
begin
  CheckFalse(TTextMatchInsensitive.New.Find('Something to Match text', 'To', 12));
end;

initialization

RegisterTest(TTextMatchInsensitiveTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
