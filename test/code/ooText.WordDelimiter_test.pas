{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.WordDelimiter_test;

interface

uses
  ooText.WordDelimiter,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextWordDelimiterTest = class(TTestCase)
  const
    SOME_TEXT = 'Text to test-word delimited; or not, i dont''t kwnow' + sLineBreak + 'line 2. Not ignore';
  published
    procedure IsSpaceSeparator;
    procedure IsCRLFSeparator;
    procedure IsPointSeparator;
    procedure IsComaSeparator;
    procedure IsNotSeparator;
  end;

implementation

procedure TTextWordDelimiterTest.IsComaSeparator;
begin
  CheckTrue(TTextWordDelimiter.New.Check(SOME_TEXT, 36));
end;

procedure TTextWordDelimiterTest.IsCRLFSeparator;
begin
  CheckTrue(TTextWordDelimiter.New.Check(SOME_TEXT, 5));
end;

procedure TTextWordDelimiterTest.IsNotSeparator;
begin
  CheckFalse(TTextWordDelimiter.New.Check(SOME_TEXT, 12));
end;

procedure TTextWordDelimiterTest.IsPointSeparator;
begin
  CheckTrue(TTextWordDelimiter.New.Check(SOME_TEXT, 60));
end;

procedure TTextWordDelimiterTest.IsSpaceSeparator;
begin
  CheckTrue(TTextWordDelimiter.New.Check(SOME_TEXT, 53));
end;

initialization

RegisterTest(TTextWordDelimiterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
