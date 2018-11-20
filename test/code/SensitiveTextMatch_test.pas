{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SensitiveTextMatch_test;

interface

uses
  Text,
  TextLocation,
  TextMatch,
  SensitiveTextMatch,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSensitiveTextMatchTest = class sealed(TTestCase)
  strict private
  const
    TEST_TEXT = 'Something to Match text';
  published
    procedure FindTOStartAt11;
    procedure FindCHFinistAt18;
    procedure FindTuOReturnNil;
    procedure FindMatchWithOffest20Return35to39;
    procedure FindTOWithOffset12ReturnNil;
  end;

implementation

procedure TSensitiveTextMatchTest.FindTOStartAt11;
var
  Location: ITextLocation;
begin
  Location := TSensitiveTextMatch.New.Find(TText.New(TEST_TEXT), TText.New('to'), 1);
  CheckEquals(11, Location.StartAt);
end;

procedure TSensitiveTextMatchTest.FindCHFinistAt18;
var
  Location: ITextLocation;
begin
  Location := TSensitiveTextMatch.New.Find(TText.New(TEST_TEXT), TText.New('ch'), 1);
  CheckEquals(18, Location.FinishAt);
end;

procedure TSensitiveTextMatchTest.FindTuOReturnNil;
begin
  CheckFalse(Assigned(TSensitiveTextMatch.New.Find(TText.New(TEST_TEXT), TText.New('TuO'), 1)));
end;

procedure TSensitiveTextMatchTest.FindMatchWithOffest20Return35to39;
const
  TEXT_TEST = 'Something to Match text in object Match mode';
var
  Location: ITextLocation;
begin
  Location := TSensitiveTextMatch.New.Find(TText.New(TEXT_TEST), TText.New('Match'), 20);
  CheckEquals(35, Location.StartAt);
  CheckEquals(39, Location.FinishAt);
  CheckEquals('Match', Copy(TEXT_TEST, Location.StartAt, Succ(Location.FinishAt - Location.StartAt)));
end;

procedure TSensitiveTextMatchTest.FindTOWithOffset12ReturnNil;
begin
  CheckFalse(Assigned(TSensitiveTextMatch.New.Find(TText.New(TEST_TEXT), TText.New('to'), 12)));
end;

initialization

RegisterTest(TSensitiveTextMatchTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
