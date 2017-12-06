{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Beautify_test;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooText.Beautify.Simple,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TBeautifyTest = class(TTestCase)
  published
    procedure WithDeaultMargin;
    procedure WithMarginTwo;
    procedure DelimitedText123;
  end;

implementation

procedure TBeautifyTest.DelimitedText123;
begin
  CheckEquals('(123)', TSimpleBeautify.New.DelimitedList('123'));
end;

procedure TBeautifyTest.WithDeaultMargin;
begin
  CheckEquals('text', TSimpleBeautify.New.Apply(['text']));
end;

procedure TBeautifyTest.WithMarginTwo;
var
  Beautify: ITextBeautify;
begin
  Beautify := TSimpleBeautify.New;
  Beautify.ChangeMargin(3);
  CheckEquals('   text', Beautify.Apply(['text']));
end;

initialization

RegisterTest(TBeautifyTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
