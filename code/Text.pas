{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Text object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit Text;

interface

type
{$REGION 'documentation'}
{
  @abstract(Text object)
  String object oriented
  @member(
    Size Number of letters
    @return(Number with the text length)
  )
  @member(
    Value Text content
    @return(String with the content)
  )
  @member(
    IsEmpty Checks if text has no letters
    @return(@true if has letters, @false if not)
  )
}
{$ENDREGION}
  IText = interface
    ['{CF7959E9-8B86-4F52-9DB2-19778C31B522}']
    function Size: Cardinal;
    function Value: String;
    function IsEmpty: Boolean;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IText))
  @member(Size @seealso(IText.Size))
  @member(Value @seealso(IText.Value))
  @member(IsEmpty @seealso(IText.IsEmpty))
  @member(
    Create Object constructor
    @param(Source Source text)
  )
  @member(
    New Create a new @classname as interface
    @param(Source Source text)
  )
}
{$ENDREGION}

  TText = class sealed(TInterfacedObject, IText)
  strict private
    _Value: String;
  public
    function Size: Cardinal;
    function Value: String;
    function IsEmpty: Boolean;
    constructor Create(const Source: String);
    class function New(const Source: String): IText;
  end;

implementation

function TText.Value: String;
begin
  Result := _Value;
end;

function TText.IsEmpty: Boolean;
begin
  Result := Size < 1;
end;

function TText.Size: Cardinal;
begin
  Result := Length(Value);
end;

constructor TText.Create(const Source: String);
begin
  _Value := Source;
end;

class function TText.New(const Source: String): IText;
begin
  Result := TText.Create(Source);
end;

end.
