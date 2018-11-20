{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit InsensitiveWordMatch_test;

interface

uses
  Text,
  TextLocation,
  TextMatch,
  InsensitiveWordMatch,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TInsensitiveWordMatchTest = class sealed(TTestCase)
  private const
    TEXT_TEST = 'Some text to test splitter mechanism, none more! Or repeat any texttext (text)?';
  published
    procedure FoundStart;
    procedure FoundEnd;
    procedure FindSomeNotFound;
    procedure FindSomeFromPosNotFound;
    procedure FindSomeFromPos;
  end;

implementation

procedure TInsensitiveWordMatchTest.FoundStart;
var
  TextLocation: ITextLocation;
begin
  TextLocation := TInsensitiveWordMatch.NewDefault.Find(TText.New(TEXT_TEST), TText.New('MECHANISM'), 1);
  CheckEquals(28, TextLocation.StartAt);
end;

procedure TInsensitiveWordMatchTest.FoundEnd;
var
  TextLocation: ITextLocation;
begin
  TextLocation := TInsensitiveWordMatch.NewDefault.Find(TText.New(TEXT_TEST), TText.New('mechaniSM'), 1);
  CheckEquals(36, TextLocation.FinishAt);
end;

procedure TInsensitiveWordMatchTest.FindSomeNotFound;
begin
  CheckFalse(Assigned(TInsensitiveWordMatch.NewDefault.Find(TText.New(TEXT_TEST), TText.New('Mechanism-'), 1)));
end;

procedure TInsensitiveWordMatchTest.FindSomeFromPos;
var
  TextLocation: ITextLocation;
begin
  TextLocation := TInsensitiveWordMatch.NewDefault.Find(TText.New(TEXT_TEST), TText.New('text'), 10);
  CheckEquals(74, TextLocation.StartAt);
  CheckEquals(77, TextLocation.FinishAt);
  CheckEquals('text', Copy(TEXT_TEST, TextLocation.StartAt, Succ(TextLocation.FinishAt - TextLocation.StartAt)));
end;

procedure TInsensitiveWordMatchTest.FindSomeFromPosNotFound;
begin
  CheckFalse(Assigned(TInsensitiveWordMatch.NewDefault.Find(TText.New(TEXT_TEST), TText.New('mechanism'), 40)));
end;

initialization

RegisterTest(TInsensitiveWordMatchTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
