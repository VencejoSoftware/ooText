{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Text matcher object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit TextMatch;

interface

uses
  Text,
  TextLocation;

type
{$REGION 'documentation'}
{
  @abstract(Text matcher object)
  Tries to find a subtext in a text
  @member(
    Find Tries to find a subtext in text with a specific start position
    @param(Source Source text)
    @param(ToFind Subtext to find)
    @param(StartAt Initial position)
    @return(@link(ITextLocation Location))
  )
}
{$ENDREGION}
  ITextMatch = interface
    ['{9742C3A9-6584-4BC9-BF7E-C5BED97B08B4}']
    function Find(const Source, ToFind: IText; const StartAt: Cardinal): ITextLocation;
  end;

implementation

end.
