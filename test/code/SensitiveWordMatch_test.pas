{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SensitiveWordMatch_test;

interface

uses
  Text,
  TextMatch,
  TextLocation,
  SensitiveWordMatch,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSensitiveWordMatchTest = class sealed(TTestCase)
  private const
    TEXT_TEST = 'Some text to test splitter mechanism, none more! Or repeat any texttext (text)?';
  published
    procedure FindMechanismStartAt28;
    procedure FindMechanismFinishAt36;
    procedure FindMechanismWithCaseReturnNil;
    procedure FindTextWithOffset10Return74to77;
    procedure FindMechanisWithOffset40ReturnNil;
  end;

implementation

procedure TSensitiveWordMatchTest.FindMechanismStartAt28;
var
  Location: ITextLocation;
begin
  Location := TSensitiveWordMatch.NewDefault.Find(TText.New(TEXT_TEST), TText.New('mechanism'), 1);
  CheckEquals(28, Location.StartAt);
end;

procedure TSensitiveWordMatchTest.FindMechanismFinishAt36;
var
  Location: ITextLocation;
begin
  Location := TSensitiveWordMatch.NewDefault.Find(TText.New(TEXT_TEST), TText.New('mechanism'), 1);
  CheckEquals(36, Location.FinishAt);
end;

procedure TSensitiveWordMatchTest.FindMechanismWithCaseReturnNil;
begin
  CheckFalse(Assigned(TSensitiveWordMatch.NewDefault.Find(TText.New(TEXT_TEST), TText.New('Mechanism'), 1)));
end;

procedure TSensitiveWordMatchTest.FindTextWithOffset10Return74to77;
var
  Location: ITextLocation;
begin
  Location := TSensitiveWordMatch.NewDefault.Find(TText.New(TEXT_TEST), TText.New('text'), 10);
  CheckEquals(74, Location.StartAt);
  CheckEquals(77, Location.FinishAt);
  CheckEquals('text', Copy(TEXT_TEST, Location.StartAt, Succ(Location.FinishAt - Location.StartAt)));
end;

procedure TSensitiveWordMatchTest.FindMechanisWithOffset40ReturnNil;
begin
  CheckFalse(Assigned(TSensitiveWordMatch.NewDefault.Find(TText.New(TEXT_TEST), TText.New('mechanism'), 40)));
end;

initialization

RegisterTest(TSensitiveWordMatchTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
