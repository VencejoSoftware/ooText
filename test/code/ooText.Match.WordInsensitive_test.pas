{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Match.WordInsensitive_test;

interface

uses
  ooText.Match.Intf, ooText.Match.WordInsensitive,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextMatchWordInsensitiveTest = class(TTestCase)
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

procedure TTextMatchWordInsensitiveTest.FoundStart;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextMatchWordInsensitive.New;
  TextMatch.Find(TEXT_TEST, 'MECHANISM', 1);
  CheckEquals(28, TextMatch.FoundStart);
end;

procedure TTextMatchWordInsensitiveTest.FoundEnd;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextMatchWordInsensitive.New;
  TextMatch.Find(TEXT_TEST, 'mechaniSM', 1);
  CheckEquals(36, TextMatch.FoundEnd);
end;

procedure TTextMatchWordInsensitiveTest.FindSome;
begin
  CheckTrue(TTextMatchWordInsensitive.New.Find(TEXT_TEST, 'meCHanism', 1));
end;

procedure TTextMatchWordInsensitiveTest.FindSomeNotFound;
begin
  CheckFalse(TTextMatchWordInsensitive.New.Find(TEXT_TEST, 'Mechanism-', 1));
end;

procedure TTextMatchWordInsensitiveTest.FindSomeFromPos;
var
  TextMatch: ITextMatch;
begin
  TextMatch := TTextMatchWordInsensitive.New;
  TextMatch.Find(TEXT_TEST, 'text', 10);
  CheckEquals(74, TextMatch.FoundStart);
  CheckEquals(77, TextMatch.FoundEnd);
  CheckEquals('text', Copy(TEXT_TEST, TextMatch.FoundStart, Succ(TextMatch.FoundEnd - TextMatch.FoundStart)));
end;

procedure TTextMatchWordInsensitiveTest.FindSomeFromPosNotFound;
begin
  CheckFalse(TTextMatchWordInsensitive.New.Find(TEXT_TEST, 'mechanism', 40));
end;

initialization

RegisterTest(TTextMatchWordInsensitiveTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
