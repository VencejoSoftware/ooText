{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SecureText_test;

interface

uses
  SysUtils,
  Text,
  SecureText,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFrameWork
{$ENDIF};

type
  TSecureTextTest = class sealed(TTestCase)
  published
    procedure SecureEmptyReturn;
    procedure SomethingReturnSomethigValue;
    procedure TestSizeIs4;
    procedure SymbolsReutrnSize13;
  end;

implementation

procedure TSecureTextTest.SecureEmptyReturn;
begin
  CheckTrue(TSecureText.New(EmptyStr).IsEmpty);
end;

procedure TSecureTextTest.SomethingReturnSomethigValue;
begin
  CheckEquals('something', TSecureText.New('something').Value);
end;

procedure TSecureTextTest.TestSizeIs4;
begin
  CheckEquals(4, TSecureText.New('Test').Size);
end;

procedure TSecureTextTest.SymbolsReutrnSize13;
begin
  CheckEquals('!"·$%&/()=ª\º', TSecureText.New('!"·$%&/()=ª\º').Value);
  CheckEquals(13, TSecureText.New('!"·$%&/()=ª\º').Size);
end;

initialization

RegisterTest(TSecureTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
