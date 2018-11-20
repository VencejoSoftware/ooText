{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Text padded letter (right or left) object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit LetterPaddedText;

interface

uses
  SysUtils,
  Text;

type
{$REGION 'documentation'}
{
  Enum for archive attributes
  @value Left Repetition of letters are positionated at left
  @value Right Repetition of letters are positionated at right
}
{$ENDREGION}
  TLetterPaddedMode = (Left, Right);

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IText))
  Creates a text with padded letter (right or left)
  @member(Size @seealso(IText.Size))
  @member(Value @seealso(IText.Value))
  @member(IsEmpty @seealso(IText.IsEmpty))
  @member(
    Build Build padded string
    @param(Text Source text)
    @param(MaxLength Maximun lenght of padded text)
    @param(Letter Letter to use when pad)
    @param(Mode Pad mode to apply)
    @return(@link(IText Text padded))
  )
  @member(
    Create Object constructor
    @param(Text @link(IText Text) object)
    @param(MaxLength Maximun lenght of padded text)
    @param(Letter Letter to use when pad)
    @param(Mode Pad mode to apply)
  )
  @member(
    New Create a new @classname as interface
    @param(Text @link(IText Text) object)
    @param(MaxLength Maximun lenght of padded text)
    @param(Letter Letter to use when pad)
    @param(Mode Pad mode to apply)
  )
  @member(
    NewFromString Create a new @classname as interface from a native string
    @param(Text Source text)
    @param(MaxLength Maximun lenght of padded text)
    @param(Letter Letter to use when pad)
    @param(Mode Pad mode to apply)
  )
}
{$ENDREGION}

  TLetterPaddedText = class sealed(TInterfacedObject, IText)
  strict private
    _Text: IText;
  private
    function Build(const Text: IText; const MaxLength: Cardinal; const Letter: Char;
      const Mode: TLetterPaddedMode): IText;
  public
    function Size: Cardinal;
    function Value: String;
    function IsEmpty: Boolean;
    constructor Create(const Text: IText; const MaxLength: Cardinal; const Letter: Char; const Mode: TLetterPaddedMode);
    class function New(const Text: IText; const MaxLength: Cardinal; const Letter: Char;
      const Mode: TLetterPaddedMode): IText;
    class function NewFromString(const Text: String; const MaxLength: Cardinal; const Letter: Char;
      const Mode: TLetterPaddedMode): IText;
  end;

implementation

function TLetterPaddedText.Size: Cardinal;
begin
  Result := _Text.Size;
end;

function TLetterPaddedText.Value: String;
begin
  Result := _Text.Value;
end;

function TLetterPaddedText.IsEmpty: Boolean;
begin
  Result := _Text.IsEmpty;
end;

function TLetterPaddedText.Build(const Text: IText; const MaxLength: Cardinal; const Letter: Char;
  const Mode: TLetterPaddedMode): IText;
var
  DiffLen: Cardinal;
  PadLetters: String;
begin
  DiffLen := MaxLength - Text.Size;
  PadLetters := StringOfChar(Letter, DiffLen);
  if Mode = Left then
    Result := TText.New(PadLetters + Text.Value)
  else
    Result := TText.New(Text.Value + PadLetters);
end;

constructor TLetterPaddedText.Create(const Text: IText; const MaxLength: Cardinal; const Letter: Char;
  const Mode: TLetterPaddedMode);
begin
  if MaxLength < Text.Size then
    _Text := TText.New(Text.Value)
  else
    _Text := Build(Text, MaxLength, Letter, Mode);
end;

class function TLetterPaddedText.New(const Text: IText; const MaxLength: Cardinal; const Letter: Char;
  const Mode: TLetterPaddedMode): IText;
begin
  Result := TLetterPaddedText.Create(Text, MaxLength, Letter, Mode);
end;

class function TLetterPaddedText.NewFromString(const Text: String; const MaxLength: Cardinal; const Letter: Char;
  const Mode: TLetterPaddedMode): IText;
begin
  Result := TLetterPaddedText.New(TText.New(Text), MaxLength, Letter, Mode);
end;

end.
