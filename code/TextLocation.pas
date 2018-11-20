{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Text location object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit TextLocation;

interface

type
{$REGION 'documentation'}
{
  @abstract(Text location object)
  Indicates the start and the end position of some text
  @member(
    StartAt Start position of text
    @return(Start position)
  )
  @member(
    FinishAt End position of text
    @return(Finish position)
  )
  @member(
    IsValid Checks if the text location is valid
    @return(@true if location is valid, @false if not)
  )
}
{$ENDREGION}
  ITextLocation = interface
    ['{23268074-F0A0-40F7-A98F-E0007E9A512C}']
    function StartAt: Cardinal;
    function FinishAt: Cardinal;
    function IsValid: Boolean;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ITextLocation))
  @member(StartAt @seealso(ITextLocation.StartAt))
  @member(FinishAt @seealso(ITextLocation.FinishAt))
  @member(IsValid @seealso(ITextLocation.IsValid))
  @member(
    Create Object constructor
    @param(StartAt Start position)
    @param(FinishAt End position)
  )
  @member(
    New Create a new @classname as interface
    @param(StartAt Start position)
    @param(FinishAt End position)
  )
}
{$ENDREGION}

  TTextLocation = class sealed(TInterfacedObject, ITextLocation)
  strict private
    _StartAt, _FinishAt: Cardinal;
  public
    function StartAt: Cardinal;
    function FinishAt: Cardinal;
    function IsValid: Boolean;
    constructor Create(const StartAt, FinishAt: Cardinal);
    class function New(const StartAt, FinishAt: Cardinal): ITextLocation;
  end;

implementation

function TTextLocation.StartAt: Cardinal;
begin
  Result := _StartAt;
end;

function TTextLocation.FinishAt: Cardinal;
begin
  Result := _FinishAt;
end;

function TTextLocation.IsValid: Boolean;
begin
  Result := (_StartAt > 0) and (_FinishAt > 0);
end;

constructor TTextLocation.Create(const StartAt, FinishAt: Cardinal);
begin
  _StartAt := StartAt;
  _FinishAt := FinishAt;
end;

class function TTextLocation.New(const StartAt, FinishAt: Cardinal): ITextLocation;
begin
  Result := TTextLocation.Create(StartAt, FinishAt);
end;

end.
