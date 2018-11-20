{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Word enumerator object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit WordEnumerator;

interface

uses
  SysUtils,
  Text,
  TextLocation,
  TextMatch,
  Iterator;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IStringEnumerator))
  Sequentially traces a text splitting in terms with a delimiter
  @member(GetCurrent @seealso(IStringEnumerator.GetCurrent))
  @member(MoveNext @seealso(IStringEnumerator.MoveNext))
  @member(Reset @seealso(IStringEnumerator.Reset))
  @member(
    HasNext Tries to find the next Delimiter
    @return(@true if exists next occurrence, @false if not)
  )
  @member(
    NextPosition It is positioned in the next position.
  )
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
  TWordEnumerator = class sealed(TInterfacedObject, IStringEnumerator)
  strict private
    _Location: ITextLocation;
    _Text, _Delimiter: IText;
    _TextMatch: ITextMatch;
    _StartAt, _EndAt: Cardinal;
  private
    function HasNext: Boolean;
    procedure NextPosition;
  public
    function GetCurrent: string;
    function MoveNext: Boolean;
    procedure Reset;
    constructor Create(const Text, Delimiter: IText; const TextMatch: ITextMatch; const StartAt, EndAt: Cardinal);
    class function New(const Text, Delimiter: IText; const TextMatch: ITextMatch; const StartAt, EndAt: Cardinal)
      : IStringEnumerator;
  end;

implementation

function TWordEnumerator.HasNext: Boolean;
begin
  _Location := _TextMatch.Find(_Text, _Delimiter, _StartAt);
  Result := Assigned(_Location);
end;

procedure TWordEnumerator.NextPosition;
begin
  if _EndAt > _StartAt then
    _StartAt := _EndAt + _Delimiter.Size
  else
    Inc(_StartAt);
end;

function TWordEnumerator.GetCurrent: string;
begin
  Result := Copy(_Text.Value, _StartAt, _EndAt - _StartAt);
end;

function TWordEnumerator.MoveNext: Boolean;
begin
  NextPosition;
  Result := HasNext;
  if Result then
    _EndAt := _Location.StartAt;
  if _EndAt <= 0 then
    _EndAt := Succ(_Text.Size);
end;

procedure TWordEnumerator.Reset;
begin
  _StartAt := 0;
  _EndAt := 0;
end;

constructor TWordEnumerator.Create(const Text, Delimiter: IText; const TextMatch: ITextMatch;
  const StartAt, EndAt: Cardinal);
begin
  _Text := Text;
  _Delimiter := Delimiter;
  _TextMatch := TextMatch;
  _StartAt := StartAt;
  _EndAt := EndAt;
end;

class function TWordEnumerator.New(const Text, Delimiter: IText; const TextMatch: ITextMatch;
  const StartAt, EndAt: Cardinal): IStringEnumerator;
begin
  Result := TWordEnumerator.Create(Text, Delimiter, TextMatch, StartAt, EndAt);
end;

end.
