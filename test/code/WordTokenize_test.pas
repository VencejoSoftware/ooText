{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit WordTokenize_test;

interface

uses
  SysUtils,
  SensitiveTextMatch, InsensitiveTextMatch,
  Text,
  Iterator,
  WordTokenize,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TWordTokenizeTest = class sealed(TTestCase)
  const
    TEST_TEXT = 'Test 1, Test2, B, ';
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

procedure TWordTokenizeTest.Current;
var
  Tokenize: IStringEnumerable;
begin
  Tokenize := TWordTokenize.New(TText.New(TEST_TEXT), TText.New(', '), TSensitiveTextMatch.New);
  Tokenize.Iterator.MoveNext;
  CheckEquals('Test 1', Tokenize.Iterator.Current);
end;

procedure TWordTokenizeTest.EmptyEnumerable;
var
  StringItem: String;
begin
  for StringItem in TWordTokenize.New(TText.New(EmptyStr), TText.New('ZS '), TSensitiveTextMatch.New) do
    CheckEquals(EmptyStr, StringItem);
end;

procedure TWordTokenizeTest.NoSeparator;
var
  StringItem: String;
begin
  for StringItem in TWordTokenize.New(TText.New(TEST_TEXT), TText.New(EmptyStr), TSensitiveTextMatch.New) do
    CheckEquals(TEST_TEXT, StringItem);
end;

procedure TWordTokenizeTest.NotSeparatorFound;
var
  StringItem: String;
begin
  for StringItem in TWordTokenize.New(TText.New(TEST_TEXT), TText.New('ZS '), TSensitiveTextMatch.New) do
    CheckEquals(TEST_TEXT, StringItem);
end;

procedure TWordTokenizeTest.Reset;
var
  Tokenize: IStringEnumerable;
begin
  Tokenize := TWordTokenize.New(TText.New(TEST_TEXT), TText.New(', '), TSensitiveTextMatch.New);
  Tokenize.Iterator.MoveNext;
  Tokenize.Iterator.MoveNext;
  CheckEquals('Test2', Tokenize.Iterator.Current);
  Tokenize.Iterator.Reset;
  Tokenize.Iterator.MoveNext;
  CheckEquals('Test 1', Tokenize.Iterator.Current);
end;

procedure TWordTokenizeTest.SeparatorEqualText;
var
  StringItem: String;
begin
  for StringItem in TWordTokenize.New(TText.New(TEST_TEXT), TText.New(TEST_TEXT), TSensitiveTextMatch.New) do
    CheckEquals(EmptyStr, StringItem);
end;

procedure TWordTokenizeTest.LargeSeparator;
var
  StringItem: String;
begin
  for StringItem in TWordTokenize.New(TText.New(TEST_TEXT), TText.New(TEST_TEXT + TEST_TEXT),
    TSensitiveTextMatch.New) do
    CheckEquals(TEST_TEXT, StringItem);
end;

procedure TWordTokenizeTest.TestTokenizeList;
var
  StringItem: String;
  i: Byte;
begin
  i := 0;
  for StringItem in TWordTokenize.New(TText.New(TEST_TEXT), TText.New(', '), TSensitiveTextMatch.New) do
  begin
    case i of
      0:
        CheckEquals('Test 1', StringItem);
      1:
        CheckEquals('Test2', StringItem);
      2:
        CheckEquals('B', StringItem);
      3:
        CheckEquals('', StringItem);
    else
      Check(False, 'Count item fail!')
    end;
    Inc(i);
  end;
end;

procedure TWordTokenizeTest.EnumerableSensitive;
var
  StringItem: String;
  i: Byte;
begin
  i := 0;
  for StringItem in TWordTokenize.New(TText.New(TEST_TEXT), TText.New('T'), TSensitiveTextMatch.New) do
  begin
    case i of
      0:
        CheckEquals(EmptyStr, StringItem);
      1:
        CheckEquals('est 1, ', StringItem);
      2:
        CheckEquals('est2, B, ', StringItem);
    else
      Check(False, 'Count item fail!')
    end;
    Inc(i);
  end;
end;

procedure TWordTokenizeTest.EnumerableInsensitive;
var
  StringItem: String;
  i: Byte;
begin
  i := 0;
  for StringItem in TWordTokenize.New(TText.New(TEST_TEXT), TText.New('T'), TInsensitiveTextMatch.New, 0, 0) do
  begin
    case i of
      0:
        CheckEquals(EmptyStr, StringItem);
      1:
        CheckEquals('es', StringItem);
      2:
        CheckEquals(' 1, ', StringItem);
      3:
        CheckEquals('es', StringItem);
      4:
        CheckEquals('2, B, ', StringItem);
    else
      Check(False, 'Count item fail!');
    end;
    Inc(i);
  end;
end;

initialization

RegisterTest(TWordTokenizeTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
