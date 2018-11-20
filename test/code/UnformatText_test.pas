{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit UnformatText_test;

interface

uses
  SysUtils,
  Text,
  UnformatText,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TUnformatTextTest = class sealed(TTestCase)
  published
    procedure StringArgument;
    procedure IntegerArgument;
    procedure WithWildcard;
    procedure UnrecognizedChar;
  end;

implementation

procedure TUnformatTextTest.StringArgument;
var
  Arg: String;
begin
  TUnformatText.New(TText.New('"pepe"'), TText.New('"%s"'), [@Arg]);
  CheckEquals('pepe', Arg);
end;

procedure TUnformatTextTest.IntegerArgument;
var
  Arg: Integer;
begin
  TUnformatText.New(TText.New('"pepe 99"'), TText.New('"pepe %d"'), [@Arg]);
  CheckEquals(99, Arg);
end;

procedure TUnformatTextTest.WithWildcard;
var
  Arg: Integer;
begin
  TUnformatText.New(TText.New('"pepe 99"'), TText.New('"pepe %%"'), [@Arg]);
  CheckEquals(0, Arg);
end;

procedure TUnformatTextTest.UnrecognizedChar;
var
  Arg: String;
  ErrorFound: Boolean;
begin
  ErrorFound := False;
  try
    TUnformatText.New(TText.New('"pepe"'), TText.New('"%g"'), [@Arg]);
  except
    on e: EConvertError do
      ErrorFound := True;
  end;
  CheckTrue(ErrorFound);
end;

initialization

RegisterTest(TUnformatTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
