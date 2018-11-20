{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit WordSplitIdentifier_test;

interface

uses
  WordSplitIdentifier,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TWordSplitIdentifierTest = class sealed(TTestCase)
  strict private
  const
    SOME_TEXT = 'Text to test-word delimited; or not, i dont''t kwnow' + sLineBreak + 'line 2. Not ignore';
  published
    procedure Position5IsSpaceDelimiter;
    procedure Position53IsCRLFDelimiter;
    procedure Position60IsPointDelimiter;
    procedure Position36IsComaDelimiter;
    procedure Position12IsNotADelimiter;
  end;

implementation

procedure TWordSplitIdentifierTest.Position5IsSpaceDelimiter;
begin
  CheckTrue(TWordSplitIdentifier.New.IsDelimiter(SOME_TEXT, 5));
end;

procedure TWordSplitIdentifierTest.Position53IsCRLFDelimiter;
begin
  CheckTrue(TWordSplitIdentifier.New.IsDelimiter(SOME_TEXT, 53));
end;

procedure TWordSplitIdentifierTest.Position60IsPointDelimiter;
begin
  CheckTrue(TWordSplitIdentifier.New.IsDelimiter(SOME_TEXT, 60));
end;

procedure TWordSplitIdentifierTest.Position36IsComaDelimiter;
begin
  CheckTrue(TWordSplitIdentifier.New.IsDelimiter(SOME_TEXT, 36));
end;

procedure TWordSplitIdentifierTest.Position12IsNotADelimiter;
begin
  CheckFalse(TWordSplitIdentifier.New.IsDelimiter(SOME_TEXT, 12));
end;

initialization

RegisterTest(TWordSplitIdentifierTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
