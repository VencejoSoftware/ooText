{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Stencil.Wildcard_test;

interface

uses
  SysUtils,
  ooText.Stencil.Wildcard,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextStencilWildcardTest = class(TTestCase)
  published
    procedure IsValidWildcard;
    procedure IsNotWildcard;
    procedure IsWildcardTypeNone;
    procedure IsWildcardTypeReplace;
    procedure IsWildcardTypeFixedTextStart;
    procedure IsWildcardTypeFixedTextEnd;
    procedure IsWildcardTypeLowerCase;
    procedure IsWildcardTypeUpperCase;
  end;

implementation

procedure TTextStencilWildcardTest.IsNotWildcard;
var
  TextStencilWildcard: ITextStencilWildcard;
begin
  TextStencilWildcard := TTextStencilWildcard.New;
  CheckFalse(TextStencilWildcard.IsWildcard('1'));
  CheckFalse(TextStencilWildcard.IsWildcard('A'));
  CheckFalse(TextStencilWildcard.IsWildcard('a'));
end;

procedure TTextStencilWildcardTest.IsValidWildcard;
var
  TextStencilWildcard: ITextStencilWildcard;
begin
  TextStencilWildcard := TTextStencilWildcard.New;
  CheckTrue(TextStencilWildcard.IsWildcard('?'));
  CheckTrue(TextStencilWildcard.IsWildcard('('));
  CheckTrue(TextStencilWildcard.IsWildcard(')'));
  CheckTrue(TextStencilWildcard.IsWildcard('<'));
  CheckTrue(TextStencilWildcard.IsWildcard('>'));
end;

procedure TTextStencilWildcardTest.IsWildcardTypeFixedTextEnd;
begin
  CheckTrue(TTextStencilWildcard.New.WildcardType(')') = swtFixedEnd);
end;

procedure TTextStencilWildcardTest.IsWildcardTypeFixedTextStart;
begin
  CheckTrue(TTextStencilWildcard.New.WildcardType('(') = swtFixedStart);
end;

procedure TTextStencilWildcardTest.IsWildcardTypeLowerCase;
begin
  CheckTrue(TTextStencilWildcard.New.WildcardType('<') = swtLowerCase);
end;

procedure TTextStencilWildcardTest.IsWildcardTypeNone;
begin
  CheckTrue(TTextStencilWildcard.New.WildcardType(#0) = swtNone);
end;

procedure TTextStencilWildcardTest.IsWildcardTypeReplace;
begin
  CheckTrue(TTextStencilWildcard.New.WildcardType('?') = swtOverwrite);
end;

procedure TTextStencilWildcardTest.IsWildcardTypeUpperCase;
begin
  CheckTrue(TTextStencilWildcard.New.WildcardType('>') = swtUpperCase);
end;

initialization

RegisterTest(TTextStencilWildcardTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
