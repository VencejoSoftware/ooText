{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Stencil_test;

interface

uses
  SysUtils,
  ooText, ooText.Stencil,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextStencilTest = class(TTestCase)
  published
    procedure IsApplicableWithMask;
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

procedure TTextStencilTest.DobleWildcardProblem;
begin
  CheckEquals('tesTER', TTextStencil.NewFromString('tester', '???>>>>???').Value);
end;

procedure TTextStencilTest.PatternIsUpperOnly;
begin
  CheckEquals(EmptyStr, TTextStencil.NewFromString('tester', '>').Value);
end;

procedure TTextStencilTest.EmptyPattern;
begin
  CheckEquals(EmptyStr, TTextStencil.NewFromString('RAC123456', EmptyStr).Value);
end;

procedure TTextStencilTest.FixedTextInPattern;
begin
  CheckEquals('RAP123Fixed4', TTextStencil.NewFromString('RAC123456', '??P???(Fixed)?').Value);
end;

procedure TTextStencilTest.FixedTextInPatternComplex;
begin
  CheckEquals('Prefix_RAP123FixedC', TTextStencil.NewFromString('RAC123456', '(Prefix_)??P???(Fixed)C').Value);
end;

procedure TTextStencilTest.IsApplicableWithMask;
begin
  CheckTrue(TTextStencil.NewFromString('17030915215168256946', '????????????????????').IsApplicable);
end;

procedure TTextStencilTest.TextIsEmpty;
begin
  CheckTrue(TTextStencil.NewFromString(EmptyStr, '????????????????????').IsEmpty);
end;

procedure TTextStencilTest.TextNotMatchWithMask;
begin
  CheckFalse(TTextStencil.NewFromString('17030915215168256946', '?????Z').IsApplicable);
end;

procedure TTextStencilTest.TextSize;
begin
  CheckEquals(9, TTextStencil.NewFromString('RAC123456', '??P????').Size);
end;

procedure TTextStencilTest.OverWriteTextWithPattern;
begin
  CheckEquals('RAP1234', TTextStencil.NewFromString('RAC123456', '??P????').Value);
  CheckEquals('MO002206', TTextStencil.NewFromString('RAC123456', 'MO002206').Value);
  CheckEquals('04N1234', TTextStencil.NewFromString('RAC123456', '04N????').Value);
  CheckEquals('MO205145', TTextStencil.NewFromString('RAC123456', 'MO20514?').Value);
end;

procedure TTextStencilTest.UpperTextInAnyPlace;
begin
  CheckEquals('tesTER', TTextStencil.NewFromString('tester', '???>???').Value);
end;

procedure TTextStencilTest.UpperTextInFirstPlace;
begin
  CheckEquals('TEST', TTextStencil.NewFromString('test', '>????').Value);
end;

procedure TTextStencilTest.UpperTextInLastPlace;
begin
  CheckEquals('test', TTextStencil.NewFromString('test', '????>').Value);
end;

procedure TTextStencilTest.LowerTextInAnyPlace;
begin
  CheckEquals('TESter', TTextStencil.NewFromString('TESTER', '???<???').Value);
end;

procedure TTextStencilTest.LowerTextInFirstPlace;
begin
  CheckEquals('test', TTextStencil.NewFromString('TEST', '<????').Value);
end;

procedure TTextStencilTest.LowerTextInLastPlace;
begin
  CheckEquals('TEST', TTextStencil.NewFromString('TEST', '????<').Value);
end;

procedure TTextStencilTest.CompleteUseOfWildcards;
begin
  CheckEquals('Prefixed-RAP123456_filename.EXTENSION_Suffix', TTextStencil.NewFromString('RAC123456_FILENAME.ext',
      '(Prefixed-)??P??????_<????????.>???ENSION(_Suffix)').Value);
end;

initialization

RegisterTest(TTextStencilTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
