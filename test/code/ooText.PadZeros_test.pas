{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.PadZeros_test;

interface

uses
  SysUtils,
  ooText,
  ooText.PadZeros,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextLeftPadTest = class(TTestCase)
  published
    procedure TextSizeLess;
    procedure TextSizeGreater;
    procedure ValuePadGreater;
    procedure ValuePadLess;
    procedure ValuePadZeros;
    procedure TextIsEmpty;
    procedure TextIsNotEmpty;
  end;

implementation

procedure TTextLeftPadTest.ValuePadZeros;
begin
  CheckEquals('00999', TTextLeftPad.New(TText.New('999'), 5, '0').Value);
end;

procedure TTextLeftPadTest.ValuePadGreater;
begin
  CheckEquals('       AAA', TTextLeftPad.NewFromString('AAA', 10, ' ').Value);
end;

procedure TTextLeftPadTest.ValuePadLess;
begin
  CheckEquals('1234', TTextLeftPad.NewFromString('1234', 3, '0').Value);
end;

procedure TTextLeftPadTest.TextIsEmpty;
begin
  CheckTrue(TTextLeftPad.NewFromString(EmptyStr, 0, '-').IsEmpty);
end;

procedure TTextLeftPadTest.TextIsNotEmpty;
begin
  CheckFalse(TTextLeftPad.NewFromString('AAA', 1, ' ').IsEmpty);
end;

procedure TTextLeftPadTest.TextSizeLess;
begin
  CheckEquals(4, TTextLeftPad.NewFromString('1234', 3, '0').Size);
end;

procedure TTextLeftPadTest.TextSizeGreater;
begin
  CheckEquals(10, TTextLeftPad.NewFromString('AAA', 10, ' ').Size);
end;

initialization

RegisterTest(TTextLeftPadTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
