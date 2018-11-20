{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Upper text object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit UpperText;

interface

uses
  SysUtils,
  Text;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IText))
  Upper case text represtantion
  @member(Size @seealso(IText.Size))
  @member(Value @seealso(IText.Value))
  @member(IsEmpty @seealso(IText.IsEmpty))
  @member(
    Create Object constructor
    @param(Text Source text)
  )
  @member(
    New Create a new @classname as interface
    @param(Text Source text)
  )
  @member(
    NewFromString Create a new @classname as interface from native string
    @param(Source String value)
  )
}
{$ENDREGION}
  TUpperText = class sealed(TInterfacedObject, IText)
  strict private
    _Text: IText;
  public
    function Size: Cardinal;
    function Value: String;
    function IsEmpty: Boolean;
    constructor Create(const Text: IText);
    class function New(const Text: IText): IText;
    class function NewFromString(const Source: String): IText;
  end;

implementation

function TUpperText.Size: Cardinal;
begin
  Result := _Text.Size;
end;

function TUpperText.Value: String;
begin
  Result := _Text.Value;
end;

function TUpperText.IsEmpty: Boolean;
begin
  Result := _Text.IsEmpty;
end;

constructor TUpperText.Create(const Text: IText);
begin
  _Text := TText.New(UpperCase(Text.Value));
end;

class function TUpperText.New(const Text: IText): IText;
begin
  Result := TUpperText.Create(Text);
end;

class function TUpperText.NewFromString(const Source: String): IText;
begin
  Result := TUpperText.Create(TText.New(Source));
end;

end.
