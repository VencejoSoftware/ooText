{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SecureText;
{$IFNDEF FPC}
{$SETPEOPTFLAGS $140}
{$ENDIF}

interface

uses
  SysUtils,
{$IFDEF FPC}
{$ELSE}
  Windows,
{$ENDIF}
  DCPrijndael, DCPblowfish, DCPsha256,
  Text;

type
  // Use Rijndael/blowfish to en/decrypt string
  TSecureText = class sealed(TInterfacedObject, IText)
  strict private
    _Key1, _Key2: AnsiString;
    _Value: string;
  private
    function Encrypt(const Value, Key1, Key2: AnsiString): AnsiString;
    function Decrypt(const Value, Key1, Key2: AnsiString): AnsiString;
  public
    function Size: Cardinal;
    function Value: String;
    function IsEmpty: Boolean;
    constructor Create(const Source: string);
    class function New(const Source: String): IText;
  end;

implementation

procedure WipeString(const str: String);
var
  i: Integer;
  iSize: Integer;
  pValue: PChar;
begin
  iSize := Length(str);
  pValue := PChar(str);
  for i := 0 to 7 do
  begin
{$IFDEF FPC}
    FillByte(pValue, iSize, 0);
    FillByte(pValue, iSize, $FF); // 1111 1111
    FillByte(pValue, iSize, $AA); // 1010 1010
    FillByte(pValue, iSize, $55); // 0101 0101
    FillByte(pValue, iSize, 0);
{$ELSE}
    ZeroMemory(pValue, iSize);
    FillMemory(pValue, iSize, $FF); // 1111 1111
    FillMemory(pValue, iSize, $AA); // 1010 1010
    FillMemory(pValue, iSize, $55); // 0101 0101
    ZeroMemory(pValue, iSize);
{$ENDIF}
  end;
end;

procedure DealocateString(Value: String);
var
  i: Integer;
begin
  i := PInteger(PByte(Value) - 8)^;
  if (i > - 1) and (i < 2) then
{$IFDEF FPC}
    FillByte(Pointer(Value), Length(Value) * Sizeof(Char), 0);
{$ELSE}
    ZeroMemory(Pointer(Value), Length(Value) * Sizeof(Char));
{$ENDIF}
end;

function TSecureText.Size: Cardinal;
begin
  Result := Length(Value);
end;

function TSecureText.Value: String;
begin
  Result := Decrypt(AnsiString(_Value), _Key1, _Key2);
end;

function TSecureText.IsEmpty: Boolean;
begin
  Result := Size < 1;
end;

function TSecureText.Decrypt(const Value, Key1, Key2: AnsiString): AnsiString;
var
  BlowFish: TDCP_Blowfish;
  Rijndael: TDCP_rijndael;
begin
  Result := {$IFDEF FPC} EmptyStr {$ELSE} EmptyAnsiStr {$ENDIF};
  Rijndael := TDCP_rijndael.Create(nil);
  try
    Rijndael.InitStr(Key2, TDCP_sha256);
    Result := Rijndael.DecryptString(Value);
    Rijndael.Burn;
  finally
    Rijndael.Free;
  end;
  BlowFish := TDCP_Blowfish.Create(nil);
  try
    BlowFish.InitStr(Key1, TDCP_sha256);
    Result := BlowFish.DecryptString(Result);
    BlowFish.Burn;
  finally
    BlowFish.Free;
  end;
end;

function TSecureText.Encrypt(const Value, Key1, Key2: AnsiString): AnsiString;
var
  BlowFish: TDCP_Blowfish;
  Rijndael: TDCP_rijndael;
begin
  Result := {$IFDEF FPC} EmptyStr {$ELSE} EmptyAnsiStr {$ENDIF};
  BlowFish := TDCP_Blowfish.Create(nil);
  try
    BlowFish.InitStr(Key1, TDCP_sha256);
    Result := BlowFish.EncryptString(Value);
    BlowFish.Burn;
  finally
    BlowFish.Free;
  end;
  Rijndael := TDCP_rijndael.Create(nil);
  try
    Rijndael.InitStr(Key2, TDCP_sha256);
    Result := Rijndael.EncryptString(Result);
    Rijndael.Burn;
  finally
    Rijndael.Free;
  end;
end;

constructor TSecureText.Create(const Source: string);
var
  GUIDKey: TGUID;
begin
  CreateGUID(GUIDKey);
  _Key1 := GUIDToString(GUIDKey);
  CreateGUID(GUIDKey);
  _Key2 := GUIDToString(GUIDKey);
  _Value := Encrypt(Source, _Key1, _Key2);
  if Length(Source) > 0 then
    DealocateString(Source);
end;

class function TSecureText.New(const Source: String): IText;
begin
  Result := TSecureText.Create(Source);
end;

end.
