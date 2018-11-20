{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Unformat text object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit UnformatText;

interface

uses
  SysUtils,
  Text;

type
{$REGION 'documentation'}
{
  @abstract(Unformat text based in template)
  @member(
    NextFormatChar Peek in the next format template char occurence and increase offset position
    @param(Format Template text)
    @param(FormatOffset Offset parameter output)
    @return(Format char template)
  )
  @member(
    NextTextChar Positionated in the next text char occurence
    @param(Text Source text)
    @param(TextOffset Offset parameter output)
    @return(Text char template)
  )
  @member(
    PeekFormatChar Tries to peek in the next format template char
    @param(Text Source text)
    @param(TextOffset Offset parameter output)
    @return(Text char template)
  )
  @member(
    ScanTextInt Scan text and parse values into integer array output
    @param(Text Source text)
    @param(Format Template text)
    @param(FormatOffset Format offset position)
    @param(TextOffset Text offset position)
    @param(Arg Integer array output)
  )
  @member(
    ScanTextString Scan text and parse values into string array output
    @param(Text Source text)
    @param(Format Template text)
    @param(FormatOffset Format offset position)
    @param(TextOffset Text offset position)
    @param(Arg String array output)
  )
  @member(
    Build Parse format template over text and return items
    @param(Arg String array output)
  )
  @member(
    Create Object constructor
    @param(Text Source text)
    @param(Format Template text)
    @param(Arguments Array of out arguments)
  )
  @member(
    New Create a new @classname as interface
    @param(Text Source text)
    @param(Format Template text)
    @param(Arguments Array of out arguments)
  )
}
{$ENDREGION}
  TUnformatText = class sealed(TInterfacedObject, IInterface)
  const
    EOL = #0;
  strict private
    _Text, _Format: IText;
  private
    function NextFormatChar(const Format: IText; var FormatOffset: Cardinal): Char;
    function NextTextChar(const Text: IText; var TextOffset: Cardinal): Char;
    function PeekFormatChar(const Format: IText; var FormatOffset: Cardinal): Char;
    function ScanTextInt(const Text, Format: IText; var FormatOffset, TextOffset: Cardinal; const Arg: Pointer)
      : Boolean;
    function ScanTextString(const Text, Format: IText; var FormatOffset, TextOffset: Cardinal;
      const Arg: Pointer = nil): string;
    function Build(Arguments: array of Pointer): Cardinal;
  public
    constructor Create(const Text, Format: IText; Arguments: array of Pointer);
    class function New(const Text, Format: IText; Arguments: array of Pointer): IInterface;
  end;

implementation

function TUnformatText.NextFormatChar(const Format: IText; var FormatOffset: Cardinal): Char;
begin
  Result := PeekFormatChar(Format, FormatOffset);
  if Result <> EOL then
    Inc(FormatOffset);
end;

function TUnformatText.NextTextChar(const Text: IText; var TextOffset: Cardinal): Char;
begin
  Result := EOL;
  if TextOffset <= Text.Size then
  begin
    Result := Text.Value[TextOffset];
    Inc(TextOffset);
  end;
end;

function TUnformatText.PeekFormatChar(const Format: IText; var FormatOffset: Cardinal): Char;
begin
  if FormatOffset <= Format.Size then
    Result := Format.Value[FormatOffset]
  else
    Result := EOL;
end;

function TUnformatText.ScanTextInt(const Text, Format: IText; var FormatOffset, TextOffset: Cardinal;
  const Arg: Pointer): Boolean;
var
  Value: string;
begin
  Value := ScanTextString(Text, Format, FormatOffset, TextOffset, nil);
  Result := TryStrToInt(Value, PInteger(Arg)^);
end;

function TUnformatText.ScanTextString(const Text, Format: IText; var FormatOffset, TextOffset: Cardinal;
  const Arg: Pointer = nil): string;
var
  EndChar: Char;
  TextChar: Char;
begin
  Result := EmptyStr;
  EndChar := PeekFormatChar(Format, FormatOffset);
  TextChar := NextTextChar(Text, TextOffset);
  while (TextChar > ' ') and (TextChar <> EndChar) do
  begin
    Result := Result + TextChar;
    TextChar := NextTextChar(Text, TextOffset);
  end;
  if TextChar <> EOL then
    Dec(TextOffset);
  if Assigned(Arg) then
    PString(Arg)^ := Result;
end;

function TUnformatText.Build(Arguments: array of Pointer): Cardinal;
var
  TextOffset: Cardinal;
  FormatOffset: Cardinal;
  TextChar: Char;
  FormatChar: Char;
begin
  Result := 0;
  TextOffset := 1;
  FormatOffset := 1;
  FormatChar := NextFormatChar(_Format, FormatOffset);
  while FormatChar <> EOL do
  begin
    if FormatChar <> '%' then
    begin
      TextChar := NextTextChar(_Text, TextOffset);
      if (TextChar = EOL) or (FormatChar <> TextChar) then
        Exit;
    end
    else
    begin
      FormatChar := NextFormatChar(_Format, FormatOffset);
      case FormatChar of
        '%':
          begin
            if NextTextChar(_Text, TextOffset) <> '%' then
            begin
              PCardinal(Arguments[0])^ := 0;
              Exit;
            end;
          end;
        's':
          begin
            ScanTextString(_Text, _Format, FormatOffset, TextOffset, Arguments[Result]);
            Inc(Result);
          end;
        'd', 'u':
          begin
            if not ScanTextInt(_Text, _Format, FormatOffset, TextOffset, Arguments[Result]) then
              Exit;
            Inc(Result);
          end;
      else
        raise EConvertError.CreateFmt('Unknown ScanFormat character : "%s"!', [FormatChar]);
      end;
    end;
    FormatChar := NextFormatChar(_Format, FormatOffset);
  end;
end;

constructor TUnformatText.Create(const Text, Format: IText; Arguments: array of Pointer);
begin
  _Text := Text;
  _Format := Format;
  Build(Arguments);
end;

class function TUnformatText.New(const Text, Format: IText; Arguments: array of Pointer): IInterface;
begin
  Result := TUnformatText.Create(Text, Format, Arguments);
end;

end.
