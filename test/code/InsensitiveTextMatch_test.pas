{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit InsensitiveTextMatch_test;

interface

uses
  Text,
  TextLocation,
  TextMatch,
  InsensitiveTextMatch,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TInsensitiveTextMatchTest = class sealed(TTestCase)
  strict private
  const
    TEST_TEXT = 'Something to Match text';
  published
    procedure FindTOStartAt11;
    procedure FindTOFinistAt12;
    procedure FindeARiReturnNil;
    procedure FindMaTcHWithOffest20Return35to39;
    procedure FindTOWithOffset12ReturnNil;
  end;

implementation

procedure TInsensitiveTextMatchTest.FindTOStartAt11;
var
  Location: ITextLocation;
begin
  Location := TInsensitiveTextMatch.New.Find(TText.New(TEST_TEXT), TText.New('TO'), 1);
  CheckEquals(11, Location.StartAt);
end;

procedure TInsensitiveTextMatchTest.FindTOFinistAt12;
var
  Location: ITextLocation;
begin
  Location := TInsensitiveTextMatch.New.Find(TText.New(TEST_TEXT), TText.New('TO'), 1);
  CheckEquals(12, Location.FinishAt);
end;

procedure TInsensitiveTextMatchTest.FindeARiReturnNil;
begin
  CheckFalse(Assigned(TInsensitiveTextMatch.New.Find(TText.New(TEST_TEXT), TText.New('eARi'), 1)));
end;

procedure TInsensitiveTextMatchTest.FindMaTcHWithOffest20Return35to39;
const
  TEXT_TEST = 'Something to Match text in object Match mode';
var
  Location: ITextLocation;
begin
  Location := TInsensitiveTextMatch.New.Find(TText.New(TEXT_TEST), TText.New('MaTcH'), 20);
  CheckEquals(35, Location.StartAt);
  CheckEquals(39, Location.FinishAt);
  CheckEquals('Match', Copy(TEXT_TEST, Location.StartAt, Succ(Location.FinishAt - Location.StartAt)));
end;

procedure TInsensitiveTextMatchTest.FindTOWithOffset12ReturnNil;
begin
  CheckFalse(Assigned(TInsensitiveTextMatch.New.Find(TText.New(TEST_TEXT), TText.New('To'), 12)));
end;

initialization

RegisterTest(TInsensitiveTextMatchTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
