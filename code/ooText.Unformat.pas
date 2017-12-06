{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Unformat;

interface

uses
  SysUtils, Math;

type
  TFormatItems = array of Pointer;

  TTextUnformat = class sealed(TInterfacedObject, IInterface)
  strict private
    _Value, _Format: String;
  private
    function GetFormatChar(const Format: String; var FormatOffset: Integer): Char;
    function GetTextChar(const Text: String; var TextOffset: Integer): Char;
    function PeekFormatChar(const Format: String; var FormatOffset: Integer): Char;
    function ScanTextInteger(const Text, Format: String; var FormatOffset, TextOffset: Integer;
      const Arg: Pointer): Boolean;
    function ScanTextString(const Text, Format: String; var FormatOffset, TextOffset: Integer;
      const Arg: Pointer = nil): string;
    function Generate(Arguments: array of Pointer): Integer;
  public
    constructor Create(const Text, Format: string; Arguments: array of Pointer);
    class function New(const Text, Format: string; Arguments: array of Pointer): IInterface;
  end;

implementation

function TTextUnformat.GetTextChar(const Text: String; var TextOffset: Integer): Char;
begin
  Result := #0;
  if TextOffset <= Length(Text) then
  begin
    Result := Text[TextOffset];
    Inc(TextOffset);
  end;
end;

function TTextUnformat.PeekFormatChar(const Format: String; var FormatOffset: Integer): Char;
begin
  if FormatOffset <= Length(Format) then
    Result := Format[FormatOffset]
  else
    Result := #0;
end;

function TTextUnformat.GetFormatChar(const Format: String; var FormatOffset: Integer): Char;
begin
  Result := PeekFormatChar(Format, FormatOffset);
  if Result <> #0 then
    Inc(FormatOffset);
end;

function TTextUnformat.ScanTextString(const Text, Format: String; var FormatOffset, TextOffset: Integer;
  const Arg: Pointer = nil): string;
var
  EndChar: Char;
  TextChar: Char;
begin
  Result := EmptyStr;
  EndChar := PeekFormatChar(Format, FormatOffset);
  TextChar := GetTextChar(Text, TextOffset);
  while (TextChar > ' ') and (TextChar <> EndChar) do
  begin
    Result := Result + TextChar;
    TextChar := GetTextChar(Text, TextOffset);
  end;
  if TextChar <> #0 then
    Dec(TextOffset);
  if Assigned(Arg) then
    PString(Arg)^ := Result;
end;

function TTextUnformat.ScanTextInteger(const Text, Format: String; var FormatOffset, TextOffset: Integer;
  const Arg: Pointer): Boolean;
var
  Value: string;
begin
  Value := ScanTextString(Text, Format, FormatOffset, TextOffset, nil);
  Result := TryStrToInt(Value, { out } PInteger(Arg)^);
end;

function TTextUnformat.Generate(Arguments: array of Pointer): Integer;
var
  TextOffset: Integer;
  FormatOffset: Integer;
  TextChar: Char;
  FormatChar: Char;
begin
  Result := 0;
  TextOffset := 1;
  FormatOffset := 1;
  FormatChar := GetFormatChar(_Format, FormatOffset);
  while FormatChar <> #0 do
  begin
    if FormatChar <> '%' then
    begin
      TextChar := GetTextChar(_Value, TextOffset);
      if (TextChar = #0) or (FormatChar <> TextChar) then
        Exit;
    end
    else
    begin
      FormatChar := GetFormatChar(_Format, FormatOffset);
      case FormatChar of
        '%': begin
            if GetTextChar(_Value, TextOffset) <> '%' then
            begin
              PInteger(Arguments[0])^ := 0;
              Exit;
            end;
          end;
        's': begin
            ScanTextString(_Value, _Format, FormatOffset, TextOffset, Arguments[Result]);
            Inc(Result);
          end;
        'd', 'u': begin
            if not ScanTextInteger(_Value, _Format, FormatOffset, TextOffset, Arguments[Result]) then
              Exit;
            Inc(Result);
          end;
      else raise EConvertError.CreateFmt('Unknown ScanFormat character : "%s"!', [FormatChar]);
      end;
    end;
    FormatChar := GetFormatChar(_Format, FormatOffset);
  end;
end;

constructor TTextUnformat.Create(const Text, Format: string; Arguments: array of Pointer);
begin
  _Value := Text;
  _Format := Format;
  Generate(Arguments);
end;

class function TTextUnformat.New(const Text, Format: string; Arguments: array of Pointer): IInterface;
begin
  Result := TTextUnformat.Create(Text, Format, Arguments);
end;

end.
