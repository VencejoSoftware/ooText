{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit TextSplit_test;

interface

uses
  SysUtils,
  Text,
  WordSplitIdentifier,
  TextSplit,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextSplitTest = class sealed(TTestCase)
  strict private
  const
    TEXT_TEST = 'Some text to test splitter mechanism, none more!';
  published
    procedure TextIsSplittedIn9Items;
    procedure UseComaAsOnlyDividerReturnNoneMore;
    procedure SecondWordIsText;
    procedure EmptyTextReturnIsEmptyTrue;
  end;

implementation

procedure TTextSplitTest.TextIsSplittedIn9Items;
var
  WordList: IWordList;
begin
  WordList := TTextSplit.New.Execute(TText.New(TEXT_TEST), TWordSplitIdentifier.New);
  CheckEquals(9, WordList.Count);
end;

procedure TTextSplitTest.UseComaAsOnlyDividerReturnNoneMore;
var
  WordList: IWordList;
begin
  WordList := TTextSplit.New.Execute(TText.New(TEXT_TEST), TWordSplitIdentifier.New([',']));
  CheckEquals(2, WordList.Count);
  CheckEquals(' none more!', WordList.Items[1].Value);
end;

procedure TTextSplitTest.SecondWordIsText;
var
  WordList: IWordList;
begin
  WordList := TTextSplit.New.Execute(TText.New(TEXT_TEST), TWordSplitIdentifier.New);
  CheckEquals('text', WordList.Items[1].Value);
end;

procedure TTextSplitTest.EmptyTextReturnIsEmptyTrue;
var
  WordList: IWordList;
begin
  WordList := TTextSplit.New.Execute(TText.New(EmptyStr), TWordSplitIdentifier.New);
  CheckTrue(WordList.IsEmpty);
end;

initialization

RegisterTest(TTextSplitTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
