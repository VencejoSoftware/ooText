{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Divided text object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit DividedText;

interface

uses
  SysUtils;

type
{$REGION 'documentation'}
{
  @abstract(Divided text interface)
  Split a string from position object
  @member(
    IsDivided Checks if a text was cutted
    @return(@True if text is cutted, @false if not)
  )
  @member(
    LeftPart Left part of uncutted text
    @return(String copied from 1 to cut position)
  )
  @member(
    RightPart Right part of uncutted text
    @return(String copied from cut position + 1 to length)
  )
}
{$ENDREGION}
  IDividedText = interface
    ['{8CEDA80B-085C-4CE5-97FE-DFCBFFFAF984}']
    function IsDivided: Boolean;
    function LeftPart: String;
    function RightPart: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IDividedText))
  @member(IsDivided @seealso(IDividedText.IsDivided))
  @member(LeftPart @seealso(IDividedText.LeftPart))
  @member(RightPart @seealso(IDividedText.RightPart))
  @member(
    Create Object constructor
    @param(Text Source text)
    @param(Position Split position)
  )
  @member(
    New Create a new @classname as interface
    @param(Text Source text)
    @param(Position Split position)
  )
}
{$ENDREGION}

  TDividedText = class sealed(TInterfacedObject, IDividedText)
  strict private
    _LeftPart, _RightPart: String;
  public
    function IsDivided: Boolean;
    function LeftPart: String;
    function RightPart: String;
    constructor Create(const Text: String; const Position: Cardinal);
    class function New(const Text: String; const Position: Cardinal): IDividedText;
  end;

implementation

function TDividedText.RightPart: String;
begin
  Result := _RightPart;
end;

function TDividedText.LeftPart: String;
begin
  Result := _LeftPart;
end;

function TDividedText.IsDivided: Boolean;
begin
  Result := (_LeftPart <> EmptyStr);
  Result := Result and (_RightPart <> EmptyStr);
end;

constructor TDividedText.Create(const Text: String; const Position: Cardinal);
begin
  if Position > 0 then
  begin
    _LeftPart := Copy(Text, 1, Position);
    _RightPart := Copy(Text, Succ(Position));
  end
  else
  begin
    _LeftPart := EmptyStr;
    _RightPart := EmptyStr;
  end;
end;

class function TDividedText.New(const Text: String; const Position: Cardinal): IDividedText;
begin
  Result := TDividedText.Create(Text, Position);
end;

end.
