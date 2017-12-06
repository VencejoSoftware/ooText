{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Tokenize_test;

interface

uses
  SysUtils,
  ooText.Match.Sensitive, ooText.Match.Insensitive,
  ooEnumerator,
  ooText.Tokenize,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TTextTokenizeTest = class sealed(TTestCase)
  const
    TEXT = 'Test 1, Test2, B, ';
  published
    procedure Current;
    procedure EmptyEnumerable;
    procedure NoSeparator;
    procedure LargeSeparator;
    procedure SeparatorEqualText;
    procedure NotSeparatorFound;
    procedure TestTokenizeList;
    procedure EnumerableSensitive;
    procedure EnumerableInsensitive;
    procedure Reset;
  end;

implementation

procedure TTextTokenizeTest.Current;
var
  Tokenize: IStringEnumerable;
begin
  Tokenize := TTextTokenize.New(TEXT, ', ', TTextMatchSensitive.New);
  Tokenize.Enumerator.MoveNext;
  CheckEquals('Test 1', Tokenize.Enumerator.Current);
end;

procedure TTextTokenizeTest.EmptyEnumerable;
var
  StringItem: String;
begin
  for StringItem in TTextTokenize.New(EmptyStr, 'ZS ', TTextMatchSensitive.New) do
    CheckEquals(EmptyStr, StringItem);
end;

procedure TTextTokenizeTest.NoSeparator;
var
  StringItem: String;
begin
  for StringItem in TTextTokenize.New(TEXT, EmptyStr, TTextMatchSensitive.New) do
    CheckEquals(TEXT, StringItem);
end;

procedure TTextTokenizeTest.NotSeparatorFound;
var
  StringItem: String;
begin
  for StringItem in TTextTokenize.New(TEXT, 'ZS ', TTextMatchSensitive.New) do
    CheckEquals(TEXT, StringItem);
end;

procedure TTextTokenizeTest.Reset;
var
  Tokenize: IStringEnumerable;
begin
  Tokenize := TTextTokenize.New(TEXT, ', ', TTextMatchSensitive.New);
  Tokenize.Enumerator.MoveNext;
  Tokenize.Enumerator.MoveNext;
  CheckEquals('Test2', Tokenize.Enumerator.Current);
  Tokenize.Enumerator.Reset;
  Tokenize.Enumerator.MoveNext;
  CheckEquals('Test 1', Tokenize.Enumerator.Current);
end;

procedure TTextTokenizeTest.SeparatorEqualText;
var
  StringItem: String;
begin
  for StringItem in TTextTokenize.New(TEXT, TEXT, TTextMatchSensitive.New) do
    CheckEquals(EmptyStr, StringItem);
end;

procedure TTextTokenizeTest.LargeSeparator;
var
  StringItem: String;
begin
  for StringItem in TTextTokenize.New(TEXT, TEXT + TEXT, TTextMatchSensitive.New) do
    CheckEquals(TEXT, StringItem);
end;

procedure TTextTokenizeTest.TestTokenizeList;
var
  StringItem: String;
  i: Integer;
begin
  i := 0;
  for StringItem in TTextTokenize.New(TEXT, ', ', TTextMatchSensitive.New) do
  begin
    case i of
      0: CheckEquals('Test 1', StringItem);
      1: CheckEquals('Test2', StringItem);
      2: CheckEquals('B', StringItem);
      3: CheckEquals('', StringItem);
    else
      Check(False, 'Count item fail!')
    end;
    Inc(i);
  end;
end;

procedure TTextTokenizeTest.EnumerableSensitive;
var
  StringItem: String;
  i: Integer;
begin
  i := 0;
  for StringItem in TTextTokenize.New(TEXT, 'T', TTextMatchSensitive.New) do
  begin
    case i of
      0: CheckEquals(EmptyStr, StringItem);
      1: CheckEquals('est 1, ', StringItem);
      2: CheckEquals('est2, B, ', StringItem);
    else
      Check(False, 'Count item fail!')
    end;
    Inc(i);
  end;
end;

procedure TTextTokenizeTest.EnumerableInsensitive;
var
  StringItem: String;
  i: Integer;
begin
  i := 0;
  for StringItem in TTextTokenize.New(TEXT, 'T', TTextMatchInsensitive.New, 0, 0) do
  begin
    case i of
      0: CheckEquals(EmptyStr, StringItem);
      1: CheckEquals('es', StringItem);
      2: CheckEquals(' 1, ', StringItem);
      3: CheckEquals('es', StringItem);
      4: CheckEquals('2, B, ', StringItem);
    else
      Check(False, 'Count item fail!');
    end;
    Inc(i);
  end;
end;

initialization

RegisterTest(TTextTokenizeTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
