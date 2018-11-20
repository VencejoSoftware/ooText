{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Word tokenize object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit WordTokenize;

interface

uses
  Text,
  TextMatch,
  Iterator,
  WordEnumerator;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IStringEnumerable))
  @member(GetEnumerator @seealso(IStringEnumerable.GetEnumerator))
  @member(
    Create Object constructor
    @param(Text Source text)
    @param(Delimiter Delimiter text)
    @param(TextMatch Text matcher object)
    @param(StartAt Start tokenize at this position)
    @param(EndAt Finisth tokenize at this position)
  )
  @member(
    New Create a new @classname as interface
    @param(Text Source text)
    @param(Delimiter Delimiter text)
    @param(TextMatch Text matcher object)
    @param(StartAt Start tokenize at this position)
    @param(EndAt Finisth tokenize at this position)
  )
}
{$ENDREGION}
  TWordTokenize = class sealed(TInterfacedObject, IStringEnumerable)
  strict private
    _Enumerator: IStringEnumerator;
  public
    function GetEnumerator: IStringEnumerator;
    constructor Create(const Text, Delimiter: IText; const TextMatch: ITextMatch; const StartAt, EndAt: Cardinal);
    class function New(const Text, Delimiter: IText; const TextMatch: ITextMatch; const StartAt: Cardinal = 0;
      const EndAt: Cardinal = 0): IStringEnumerable;
  end;

implementation

function TWordTokenize.GetEnumerator: IStringEnumerator;
begin
  Result := _Enumerator;
end;

constructor TWordTokenize.Create(const Text, Delimiter: IText; const TextMatch: ITextMatch;
  const StartAt, EndAt: Cardinal);
begin
  _Enumerator := TWordEnumerator.New(Text, Delimiter, TextMatch, StartAt, EndAt);
end;

class function TWordTokenize.New(const Text, Delimiter: IText; const TextMatch: ITextMatch; const StartAt: Cardinal = 0;
  const EndAt: Cardinal = 0): IStringEnumerable;
begin
  Result := TWordTokenize.Create(Text, Delimiter, TextMatch, StartAt, EndAt);
end;

end.
