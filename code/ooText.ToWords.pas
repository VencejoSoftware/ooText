{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.ToWords;

interface

uses
  SysUtils,
  Generics.Collections,
  ooText.WordDelimiter,
  ooText;

type
  TWordList = TList<IText>;

  ITextToWords = interface(IText)
    ['{A12BEBD3-D3EB-4414-8185-119BCEB8D955}']
    function WordList: TWordList;
  end;

  TTextToWords = class sealed(TInterfacedObject, ITextToWords)
  strict private
    _Text: IText;
    _WordList: TWordList;
  private
    procedure SplitText(const Text: IText; const DelimiterCharSet: TSysCharSet);
  public
    function Size: Integer;
    function Value: String;
    function IsEmpty: Boolean;
    function WordList: TWordList;

    constructor Create(const Text: IText; const DelimiterCharSet: TSysCharSet = []);
    destructor Destroy; override;

    class function New(const Text: IText; const DelimiterCharSet: TSysCharSet = []): ITextToWords;
    class function NewFromString(const Text: String; const DelimiterCharSet: TSysCharSet = []): ITextToWords;
  end;

implementation

function TTextToWords.Value: String;
begin
  Result := _Text.Value;
end;

function TTextToWords.IsEmpty: Boolean;
begin
  Result := Size < 1;
end;

function TTextToWords.Size: Integer;
begin
  Result := WordList.Count;
end;

function TTextToWords.WordList: TWordList;
begin
  Result := _WordList;
end;

procedure TTextToWords.SplitText(const Text: IText; const DelimiterCharSet: TSysCharSet);
var
  TextWordDelimiter: ITextWordDelimiter;
  i: Integer;
  Word: String;
begin
  TextWordDelimiter := TTextWordDelimiter.New(DelimiterCharSet);
  Word := EmptyStr;
  for i := 1 to Text.Size do
  begin
    if TextWordDelimiter.Check(Text.Value, i) then
    begin
      _WordList.Add(TText.New(Word));
      Word := EmptyStr;
    end
    else
    begin
      Word := Word + Text.Value[i];
    end;
  end;
  if Length(Word) > 0 then
    _WordList.Add(TText.New(Word));
end;

constructor TTextToWords.Create(const Text: IText; const DelimiterCharSet: TSysCharSet);
begin
  _WordList := TWordList.Create;
  _Text := Text;
  SplitText(_Text, DelimiterCharSet);
end;

destructor TTextToWords.Destroy;
begin
  _WordList.Free;
  inherited;
end;

class function TTextToWords.New(const Text: IText; const DelimiterCharSet: TSysCharSet): ITextToWords;
begin
  Result := TTextToWords.Create(Text, DelimiterCharSet);
end;

class function TTextToWords.NewFromString(const Text: String; const DelimiterCharSet: TSysCharSet): ITextToWords;
begin
  Result := TTextToWords.New(TText.New(Text), DelimiterCharSet);
end;

end.
