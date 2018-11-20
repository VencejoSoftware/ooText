{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Random text object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit RandomText;

interface

uses
  Text;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IText))
  Creates a random text with specific size and charmap
  @member(Size @seealso(IText.Size))
  @member(Value @seealso(IText.Value))
  @member(IsEmpty @seealso(IText.IsEmpty))
  @member(
    Build Build randomized string
    @param(CharMap Letter to randomize)
    @param(Size Amount of letter for result)
    @return(Random string)
  )
  @member(
    Create Object constructor
    @param(CharMap Letter to randomize)
    @param(Size Amount of letter for result)
  )
  @member(
    New Create a new @classname as interface
    @param(Size Amount of letter for result)
  )
  @member(
    NewWithCharMap Create a new @classname as interface from a native string
    @param(CharMap Letter to randomize)
    @param(Size Amount of letter for result)
  )
}
{$ENDREGION}
  TRandomText = class sealed(TInterfacedObject, IText)
  strict private
  const
    CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopkrsyuvwxyz1234567890_-.,:;*+=!¡¿?\[]{}()#$%&/@';
  strict private
    _Text: IText;
  private
    function Build(const CharMap: String; const Size: Cardinal): String;
  public
    function Size: Cardinal;
    function Value: String;
    function IsEmpty: Boolean;
    constructor Create(const CharMap: String; const Size: Cardinal);
    class function New(const Size: Cardinal): IText;
    class function NewWithCharMap(const CharMap: String; const Size: Cardinal): IText;
  end;

implementation

function TRandomText.Build(const CharMap: String; const Size: Cardinal): String;
var
  i, ValidLen: Cardinal;
begin
  Randomize;
  ValidLen := Length(CharMap);
  SetLength(Result, Size);
  for i := 1 to Size do
    Result[i] := CharMap[Succ(Random(ValidLen))];
end;

function TRandomText.Value: String;
begin
  Result := _Text.Value;
end;

function TRandomText.IsEmpty: Boolean;
begin
  Result := _Text.IsEmpty;
end;

function TRandomText.Size: Cardinal;
begin
  Result := _Text.Size;
end;

constructor TRandomText.Create(const CharMap: String; const Size: Cardinal);
begin
  _Text := TText.New(Build(CharMap, Size));
end;

class function TRandomText.New(const Size: Cardinal): IText;
begin
  Result := TRandomText.Create(TRandomText.CHARS, Size);
end;

class function TRandomText.NewWithCharMap(const CharMap: String; const Size: Cardinal): IText;
begin
  Result := TRandomText.Create(CharMap, Size);
end;

end.
