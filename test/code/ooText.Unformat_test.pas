{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Unformat_test;

interface

uses
  SysUtils,
  ooText.Unformat,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextUnformatTest = class(TTestCase)
  published
    procedure StringArgument;
    procedure IntegerArgument;
    procedure WithWildcard;
    procedure UnrecognizedChar;
  end;

implementation

procedure TTextUnformatTest.IntegerArgument;
var
  Arg: Integer;
begin
  TTextUnformat.New('"pepe 99"', '"pepe %d"', [@Arg]);
  CheckEquals(99, Arg);
end;

procedure TTextUnformatTest.StringArgument;
var
  Arg: String;
begin
  TTextUnformat.New('"pepe"', '"%s"', [@Arg]);
  CheckEquals('pepe', Arg);
end;

procedure TTextUnformatTest.UnrecognizedChar;
var
  Arg: String;
  ErrorFound: Boolean;
begin
  ErrorFound := False;
  try
    TTextUnformat.New('"pepe"', '"%g"', [@Arg]);
  except
    on e: EConvertError do
      ErrorFound := True;
  end;
  CheckTrue(ErrorFound);
end;

procedure TTextUnformatTest.WithWildcard;
var
  Arg: Integer;
begin
  TTextUnformat.New('"pepe 99"', '"pepe %%"', [@Arg]);
  CheckEquals(0, Arg);
end;

initialization

RegisterTest(TTextUnformatTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
