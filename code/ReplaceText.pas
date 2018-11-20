{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Replace text object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ReplaceText;

interface

uses
  SysUtils,
  TextLocation,
  TextMatch,
  Text;

type
{$REGION 'documentation'}
{
  @abstract(Replace text object)
  Replace text with subtext using a matcher object
  @member(
    OneMatch Tries to replace a subtext in text with a specific start position
    @param(Text Source text)
    @param(ToFind Text to replace)
    @param(NewWord New text to use)
    @param(StartAt Initial position)
    @return(@link(IText Replaced text))
  )
  @member(
    AllMatches Tries to replace all subtext in text with a specific start position
    @param(Text Source text)
    @param(ToFind Text to replace)
    @param(NewWord New text to use)
    @param(StartAt Initial position)
    @return(@link(IText Replaced text))
  )
}
{$ENDREGION}
  IReplaceText = interface
    ['{5DCAA772-1693-4D2F-B413-5948C0A873BA}']
    function OneMatch(const Text, ToFind, NewText: IText; const StartAt: Cardinal): IText;
    function AllMatches(const Text, ToFind, NewText: IText; const StartAt: Cardinal): IText;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IReplaceText))
  @member(OneMatch @seealso(IReplaceText.OneMatch))
  @member(AllMatches @seealso(IReplaceText.AllMatches))
  @member(
    MatchAndReplace Find a replace text
    @param(Text Source text)
    @param(ToFind Text to replace)
    @param(NewWord New text to use)
    @param(StartAt Initial position)
    @param(AllMatches Indicates if use a incremental recursion to replace all)
    @return(@link(IText Replaced text))
  )
  @member(
    Crate Object constructor
    @param(TextMatch Text matcher object)
  )
  @member(
    New Create a new @classname as interface
    @param(TextMatch Text matcher object)
  )
}
{$ENDREGION}

  TReplaceText = class sealed(TInterfacedObject, IReplaceText)
  strict private
    _TextMatch: ITextMatch;
  private
    function MatchAndReplace(const Text, ToFind, NewText: IText; const StartAt: Cardinal;
      const AllMatches: Boolean): IText;
  public
    function OneMatch(const Text, ToFind, NewText: IText; const StartAt: Cardinal): IText;
    function AllMatches(const Text, ToFind, NewText: IText; const StartAt: Cardinal): IText;
    constructor Create(const TextMatch: ITextMatch);
    class function New(const TextMatch: ITextMatch): IReplaceText;
  end;

implementation

function TReplaceText.MatchAndReplace(const Text, ToFind, NewText: IText; const StartAt: Cardinal;
  const AllMatches: Boolean): IText;
var
  LeftPart, RightPart: String;
  Location: ITextLocation;
begin
  Result := Text;
  Location := _TextMatch.Find(Text, ToFind, StartAt);
  if not Assigned(Location) then
    Exit;
  LeftPart := Copy(Text.Value, StartAt, Location.StartAt - StartAt);
  RightPart := Copy(Text.Value, Succ(Location.FinishAt));
  if AllMatches then
    RightPart := MatchAndReplace(TText.New(RightPart), ToFind, NewText, 1, AllMatches).Value;
  Result := TText.New(LeftPart + NewText.Value + RightPart);
end;

function TReplaceText.AllMatches(const Text, ToFind, NewText: IText; const StartAt: Cardinal): IText;
begin
  Result := MatchAndReplace(Text, ToFind, NewText, StartAt, True);
end;

function TReplaceText.OneMatch(const Text, ToFind, NewText: IText; const StartAt: Cardinal): IText;
begin
  Result := MatchAndReplace(Text, ToFind, NewText, StartAt, False);
end;

constructor TReplaceText.Create(const TextMatch: ITextMatch);
begin
  _TextMatch := TextMatch;
end;

class function TReplaceText.New(const TextMatch: ITextMatch): IReplaceText;
begin
  Result := TReplaceText.Create(TextMatch);
end;

end.
