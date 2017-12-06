{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Beautify.Intf;

interface

type
  ITextBeautify = interface
    ['{3A8A99D4-B239-4C09-9991-FDF8D70841D7}']
    function Apply(const ArrayText: Array of string): String;
    function DelimitedList(const Value: String): String;

    procedure ChangeMargin(const Margin: Byte);
  end;

implementation

end.
