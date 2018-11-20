{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Imploded text object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ImplodedText;

interface

uses
  SysUtils,
  Text;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IText))
  Creates a text joining a string array and a divider
  @member(Size @seealso(IText.Size))
  @member(Value @seealso(IText.Value))
  @member(IsEmpty @seealso(IText.IsEmpty))
  @member(
    Join Join the array of strings
    @param(Items String array)
    @param(Delimiter Item divider)
    @return(Joined items as string)
  )
  @member(
    Create Object constructor
    @param(Items String array)
    @param(Delimiter Item divider)
  )
  @member(
    New Create a new @classname as interface
    @param(Items String array)
    @param(Delimiter Item divider)
  )
}
{$ENDREGION}
  TImplodedText = class sealed(TInterfacedObject, IText)
  strict private
  const
    DEFAULT_DELIMITER = ',';
  strict private
    _Text: IText;
  private
    function Join(const Items: array of string; const Delimiter: string): string;
  public
    function Size: Cardinal;
    function Value: String;
    function IsEmpty: Boolean;
    constructor Create(const Items: array of string; const Delimiter: string);
    class function New(const Items: array of string; const Delimiter: string = DEFAULT_DELIMITER): IText;
  end;

implementation

function TImplodedText.Join(const Items: array of string; const Delimiter: string): string;
var
  i: Integer;
begin
  for i := 0 to high(Items) do
    if i = 0 then
      Result := Items[i]
    else
      Result := Result + Delimiter + Items[i];
end;

function TImplodedText.Value: String;
begin
  Result := _Text.Value;
end;

function TImplodedText.IsEmpty: Boolean;
begin
  Result := _Text.IsEmpty;
end;

function TImplodedText.Size: Cardinal;
begin
  Result := _Text.Size;
end;

constructor TImplodedText.Create(const Items: array of string; const Delimiter: string);
begin
  _Text := TText.New(Join(Items, Delimiter));
end;

class function TImplodedText.New(const Items: array of string; const Delimiter: string): IText;
begin
  Result := TImplodedText.Create(Items, Delimiter);
end;

end.
