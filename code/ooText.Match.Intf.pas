{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Match.Intf;

interface

type
  ITextMatch = interface
    ['{B3CA6A1B-3122-4C93-A91E-F2626ED03E13}']
    function FoundStart: Integer;
    function FoundEnd: Integer;
    function Find(const Text, ToFind: String; const StartAt: Integer): Boolean;
  end;

implementation

end.
