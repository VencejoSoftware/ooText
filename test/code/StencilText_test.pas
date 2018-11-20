{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit StencilText_test;

interface

uses
  SysUtils,
  Text,
  StencilTextWildcardIdentifier,
  StencilText,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TStencilTextTest = class sealed(TTestCase)
  published
    procedure IsFullApplicableWithMask;
    procedure TextNotMatchWithMask;
    procedure OverWriteTextWithPattern;
    procedure TextIsEmpty;
    procedure TextSize;
    procedure FixedTextInPattern;
    procedure FixedTextInPatternComplex;
    procedure UpperTextInFirstPlace;
    procedure UpperTextInLastPlace;
    procedure UpperTextInAnyPlace;
    procedure LowerTextInFirstPlace;
    procedure LowerTextInLastPlace;
    procedure LowerTextInAnyPlace;
    procedure CompleteUseOfWildcards;
    procedure EmptyPattern;
    procedure DobleWildcardProblem;
    procedure PatternIsUpperOnly;
  end;

implementation

procedure TStencilTextTest.DobleWildcardProblem;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals('tesTER', StencilText.Apply(TText.New('tester'), TText.New('???>>>>???')));
end;

procedure TStencilTextTest.PatternIsUpperOnly;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals(EmptyStr, StencilText.Apply(TText.New('tester'), TText.New('>')));
end;

procedure TStencilTextTest.EmptyPattern;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals(EmptyStr, StencilText.Apply(TText.New('RAC123456'), TText.New(EmptyStr)));
end;

procedure TStencilTextTest.FixedTextInPattern;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals('RAP123Fixed4', StencilText.Apply(TText.New('RAC123456'), TText.New('??P???(Fixed)?')));
end;

procedure TStencilTextTest.FixedTextInPatternComplex;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals('Prefix_RAP123FixedC', StencilText.Apply(TText.New('RAC123456'), TText.New('(Prefix_)??P???(Fixed)C')));
end;

procedure TStencilTextTest.IsFullApplicableWithMask;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckTrue(StencilText.IsFullApplicable(TText.New('17030915215168256946'), TText.New('????????????????????')));
end;

procedure TStencilTextTest.TextIsEmpty;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckTrue(StencilText.Apply(TText.New(EmptyStr), TText.New('????????????????????')).IsEmpty);
end;

procedure TStencilTextTest.TextNotMatchWithMask;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckFalse(StencilText.IsFullApplicable(TText.New('17030915215168256946'), TText.New('?????Z')));
end;

procedure TStencilTextTest.TextSize;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals(7, Length(StencilText.Apply(TText.New('RAC123456'), TText.New('??P????'))));
end;

procedure TStencilTextTest.OverWriteTextWithPattern;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals('RAP1234', StencilText.Apply(TText.New('RAC123456'), TText.New('??P????')));
  CheckEquals('MO002206', StencilText.Apply(TText.New('RAC123456'), TText.New('MO002206')));
  CheckEquals('04N1234', StencilText.Apply(TText.New('RAC123456'), TText.New('04N????')));
  CheckEquals('MO205145', StencilText.Apply(TText.New('RAC123456'), TText.New('MO20514?')));
end;

procedure TStencilTextTest.UpperTextInAnyPlace;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals('tesTER', StencilText.Apply(TText.New('tester'), TText.New('???>???')));
end;

procedure TStencilTextTest.UpperTextInFirstPlace;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals('TEST', StencilText.Apply(TText.New('test'), TText.New('>????')));
end;

procedure TStencilTextTest.UpperTextInLastPlace;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals('test', StencilText.Apply(TText.New('test'), TText.New('????>')));
end;

procedure TStencilTextTest.LowerTextInAnyPlace;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals('TESter', StencilText.Apply(TText.New('TESTER'), TText.New('???<???')));
end;

procedure TStencilTextTest.LowerTextInFirstPlace;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals('test', StencilText.Apply(TText.New('TEST'), TText.New('<????')));
end;

procedure TStencilTextTest.LowerTextInLastPlace;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals('TEST', StencilText.Apply(TText.New('TEST'), TText.New('????<')));
end;

procedure TStencilTextTest.CompleteUseOfWildcards;
var
  StencilText: IStencilText;
begin
  StencilText := TStencilText.New(TStencilTextWildcardIdentifier.New);
  CheckEquals('Prefixed-RAP123456_filename.EXTENSION_Suffix', StencilText.Apply(TText.New('RAC123456_FILENAME.ext'),
    TText.New('(Prefixed-)??P??????_<????????.>???ENSION(_Suffix)')));
end;

initialization

RegisterTest(TStencilTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
