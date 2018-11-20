{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit StencilTextWildcardIdentifier_test;

interface

uses
  SysUtils,
  StencilTextWildcardIdentifier,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TStencilTextWildcardIdentifierTest = class sealed(TTestCase)
  published
    procedure IsValidWildcard;
    procedure IsNotWildcard;
    procedure IsWildcardKindNone;
    procedure IsWildcardKindReplace;
    procedure IsWildcardKindFixedTextStart;
    procedure IsWildcardKindFixedTextEnd;
    procedure IsWildcardKindLowerCase;
    procedure IsWildcardKindUpperCase;
  end;

implementation

procedure TStencilTextWildcardIdentifierTest.IsValidWildcard;
var
  StencilTextWildcardIdentifier: IStencilTextWildcardIdentifier;
begin
  StencilTextWildcardIdentifier := TStencilTextWildcardIdentifier.New;
  CheckTrue(StencilTextWildcardIdentifier.IsWildcard('?'));
  CheckTrue(StencilTextWildcardIdentifier.IsWildcard('('));
  CheckTrue(StencilTextWildcardIdentifier.IsWildcard(')'));
  CheckTrue(StencilTextWildcardIdentifier.IsWildcard('<'));
  CheckTrue(StencilTextWildcardIdentifier.IsWildcard('>'));
end;

procedure TStencilTextWildcardIdentifierTest.IsNotWildcard;
var
  StencilTextWildcardIdentifier: IStencilTextWildcardIdentifier;
begin
  StencilTextWildcardIdentifier := TStencilTextWildcardIdentifier.New;
  CheckFalse(StencilTextWildcardIdentifier.IsWildcard('1'));
  CheckFalse(StencilTextWildcardIdentifier.IsWildcard('A'));
  CheckFalse(StencilTextWildcardIdentifier.IsWildcard('a'));
end;

procedure TStencilTextWildcardIdentifierTest.IsWildcardKindNone;
begin
  CheckTrue(TStencilTextWildcardIdentifier.New.WildcardKind(#0) = None);
end;

procedure TStencilTextWildcardIdentifierTest.IsWildcardKindReplace;
begin
  CheckTrue(TStencilTextWildcardIdentifier.New.WildcardKind('?') = Overwrite);
end;

procedure TStencilTextWildcardIdentifierTest.IsWildcardKindFixedTextStart;
begin
  CheckTrue(TStencilTextWildcardIdentifier.New.WildcardKind('(') = FixedStart);
end;

procedure TStencilTextWildcardIdentifierTest.IsWildcardKindFixedTextEnd;
begin
  CheckTrue(TStencilTextWildcardIdentifier.New.WildcardKind(')') = FixedEnd);
end;

procedure TStencilTextWildcardIdentifierTest.IsWildcardKindUpperCase;
begin
  CheckTrue(TStencilTextWildcardIdentifier.New.WildcardKind('>') = UpperCase);
end;

procedure TStencilTextWildcardIdentifierTest.IsWildcardKindLowerCase;
begin
  CheckTrue(TStencilTextWildcardIdentifier.New.WildcardKind('<') = LowerCase);
end;

initialization

RegisterTest(TStencilTextWildcardIdentifierTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
