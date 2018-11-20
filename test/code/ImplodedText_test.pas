{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ImplodedText_test;

interface

uses
  ImplodedText,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TImplodedTextTest = class sealed(TTestCase)
  published
    procedure Join4ItemsReturnSize10;
    procedure Join4ItemsWithPCDividerReturn1pcApcBpcLAST;
    procedure Join1ablastReturn1comaAcomaBcomaLast;
    procedure EmptyArrayReturnIsEmptyTrue;
    procedure Join4ItemsReturnSize10ReturnIsEmptyFalse;
  end;

implementation

procedure TImplodedTextTest.Join4ItemsReturnSize10;
begin
  CheckEquals(10, TImplodedText.New(['1', 'a', 'b', 'last']).Size);
end;

procedure TImplodedTextTest.Join4ItemsWithPCDividerReturn1pcApcBpcLAST;
begin
  CheckEquals('1; a; b; last', TImplodedText.New(['1', 'a', 'b', 'last'], '; ').Value);
end;

procedure TImplodedTextTest.Join1ablastReturn1comaAcomaBcomaLast;
begin
  CheckEquals('1,a,b,last', TImplodedText.New(['1', 'a', 'b', 'last']).Value);
end;

procedure TImplodedTextTest.EmptyArrayReturnIsEmptyTrue;
begin
  CheckTrue(TImplodedText.New([]).IsEmpty);
end;

procedure TImplodedTextTest.Join4ItemsReturnSize10ReturnIsEmptyFalse;
begin
  CheckFalse(TImplodedText.New(['1', 'a', 'b', 'last']).IsEmpty);
end;

initialization

RegisterTest(TImplodedTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
