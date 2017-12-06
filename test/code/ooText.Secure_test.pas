{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Secure_test;

interface

uses
  SysUtils,
  ooText.Secure,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFrameWork
{$ENDIF};

type
  TSecureTextTest = class(TTestCase)
  published
    procedure TestSize;
    procedure TestData;
    procedure TestDataHidden;
    procedure TestIsEmpty;
  end;

implementation

procedure TSecureTextTest.TestData;
begin
  // CheckEquals('Something', NewTSecureText('Something').Data);
end;

procedure TSecureTextTest.TestDataHidden;
var
  TempString: String;
begin
  TempString := 'Something';
  CheckEquals('Something', TSecureText.New(TempString).Value);
end;

procedure TSecureTextTest.TestIsEmpty;
var
  ValueString: String;
begin
  ValueString := 'Something';
  CheckFalse(TSecureText.New(ValueString).IsEmpty);
  CheckTrue(TSecureText.New(EmptyStr).IsEmpty);
end;

procedure TSecureTextTest.TestSize;
begin
  CheckEquals(9, TSecureText.New('Something').Size);
end;

initialization

RegisterTest(TSecureTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
