{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  ooText.Beautify_test in '..\code\ooText.Beautify_test.pas',
  ooText.Cutted_test in '..\code\ooText.Cutted_test.pas',
  ooText.FromArray_test in '..\code\ooText.FromArray_test.pas',
  ooText.Match.Reverse_test in '..\code\ooText.Match.Reverse_test.pas',
  ooText.Match.WordInsensitive_test in '..\code\ooText.Match.WordInsensitive_test.pas',
  ooText.Match.WordSensitive_test in '..\code\ooText.Match.WordSensitive_test.pas',
  ooText.MatchInsensitive_test in '..\code\ooText.MatchInsensitive_test.pas',
  ooText.MatchSensitive_test in '..\code\ooText.MatchSensitive_test.pas',
  ooText.MoneyPlain_test in '..\code\ooText.MoneyPlain_test.pas',
  ooText.PadZeros_test in '..\code\ooText.PadZeros_test.pas',
  ooText.Random_test in '..\code\ooText.Random_test.pas',
  ooText.RandomFixed_test in '..\code\ooText.RandomFixed_test.pas',
  ooText.Replace_test in '..\code\ooText.Replace_test.pas',
  ooText.Secure_test in '..\code\ooText.Secure_test.pas',
  ooText.Stencil.Wildcard_test in '..\code\ooText.Stencil.Wildcard_test.pas',
  ooText.Stencil_test in '..\code\ooText.Stencil_test.pas',
  ooText.Tokenize_test in '..\code\ooText.Tokenize_test.pas',
  ooText.ToWords_test in '..\code\ooText.ToWords_test.pas',
  ooText.Unformat_test in '..\code\ooText.Unformat_test.pas',
  ooText.WordDelimiter_test in '..\code\ooText.WordDelimiter_test.pas',
  ooText_test in '..\code\ooText_test.pas';

{R *.RES}

begin
  Run;

end.
