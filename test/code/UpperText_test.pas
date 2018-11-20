{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit UpperText_test;

interface

uses
  SysUtils,
  Text, UpperText,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TUpperTextTest = class sealed(TTestCase)
  published
    procedure EmptyStringReturnEmpty;
    procedure TextReturnTEXT;
    procedure TEXTReturnEqual;
  end;

implementation

procedure TUpperTextTest.EmptyStringReturnEmpty;
begin
  CheckTrue(TUpperText.NewFromString(EmptyStr).IsEmpty);
end;

procedure TUpperTextTest.TextReturnTEXT;
begin
  CheckEquals('TEXT', TUpperText.New(TText.New('Text')).Value);
end;

procedure TUpperTextTest.TEXTReturnEqual;
begin
  CheckEquals('TEXT', TUpperText.New(TText.New('TEXT')).Value);
end;

initialization

RegisterTest(TUpperTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
