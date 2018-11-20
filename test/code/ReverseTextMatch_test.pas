{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ReverseTextMatch_test;

interface

uses
  SysUtils,
  Text,
  TextLocation,
  TextMatch,
  ReverseTextMatch,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TReverseTextMatchTest = class sealed(TTestCase)
  published
    procedure EmptySourceReturnNil;
    procedure EmptyToFindReturnNil;
    procedure MatchTextReturn18to21;
    procedure MatchTexTReturn1to4;
    procedure MatchTextWithOffset5Return18to21;
  end;

implementation

procedure TReverseTextMatchTest.EmptySourceReturnNil;
var
  Location: ITextLocation;
begin
  Location := TReverseTextMatch.New.Find(TText.New(EmptyStr), TText.New('text'), 0);
  CheckFalse(Assigned(Location));
end;

procedure TReverseTextMatchTest.EmptyToFindReturnNil;
var
  Location: ITextLocation;
begin
  Location := TReverseTextMatch.New.Find(TText.New('text to test the text'), TText.New(EmptyStr), 0);
  CheckFalse(Assigned(Location));
end;

procedure TReverseTextMatchTest.MatchTextReturn18to21;
var
  Location: ITextLocation;
begin
  Location := TReverseTextMatch.New.Find(TText.New('text to test the text'), TText.New('text'), 0);
  CheckTrue(Location.IsValid);
  CheckEquals(18, Location.StartAt);
  CheckEquals(21, Location.FinishAt);
end;

procedure TReverseTextMatchTest.MatchTexTReturn1to4;
var
  Location: ITextLocation;
begin
  Location := TReverseTextMatch.New.Find(TText.New('text to test the texT'), TText.New('text'), 0);
  CheckTrue(Location.IsValid);
  CheckEquals(1, Location.StartAt);
  CheckEquals(4, Location.FinishAt);
end;

procedure TReverseTextMatchTest.MatchTextWithOffset5Return18to21;
var
  Location: ITextLocation;
begin
  Location := TReverseTextMatch.New.Find(TText.New('text to test any text in the text'), TText.New('text'), 5);
  CheckTrue(Location.IsValid);
  CheckEquals(18, Location.StartAt);
  CheckEquals(21, Location.FinishAt);
end;

initialization

RegisterTest(TReverseTextMatchTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
