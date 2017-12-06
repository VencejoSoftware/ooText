{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText;

interface

type
  IText = interface
    ['{1B06C790-56E1-4974-A634-85DB304BF9CF}']
    function Size: Integer;
    function Value: String;
    function IsEmpty: Boolean;
  end;

  TText = class sealed(TInterfacedObject, IText)
  strict private
    _Value: String;
  public
    function Size: Integer;
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

function TText.Size: Integer;
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
