{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Secure;
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
  ooText;

type
  ISecureText = interface(IText)
    ['{80653F75-E95D-46A8-B011-9A2C8C6B441E}']
    procedure Encrypt(const Key1, Key2: AnsiString);
    procedure Decrypt(const Key1, Key2: AnsiString);
  end;

  // Use Rijndael/blowfish to en/decrypt string
  TSecureText = class sealed(TInterfacedObject, ISecureText)
  strict private
    _Value: string;
  private
    procedure SetValue(const Value: string);
  public
    function Size: Integer;
    function Value: String;
    function IsEmpty: Boolean;

    procedure Encrypt(const Key1, Key2: AnsiString);
    procedure Decrypt(const Key1, Key2: AnsiString);

    constructor Create(const InsecureString: string);
    destructor Destroy; override;

    class function New(const InsecureString: String): ISecureText;
  end;

implementation

function TSecureText.Value: String;
begin
  Result := _Value;
end;

procedure TSecureText.Decrypt(const Key1, Key2: AnsiString);
var
  BlowFish: TDCP_Blowfish;
  Rijndael: TDCP_rijndael;
  Ret: AnsiString;
begin
  Rijndael := TDCP_rijndael.Create(nil);
  BlowFish := TDCP_Blowfish.Create(nil);
  try
    Ret := {$IFDEF FPC} EmptyStr {$ELSE} EmptyAnsiStr {$ENDIF};
    Rijndael.InitStr(Key2, TDCP_sha256);
    Ret := Rijndael.DecryptString(AnsiString(Value));
    Rijndael.Burn;
    BlowFish.InitStr(Key1, TDCP_sha256);
    Ret := BlowFish.DecryptString(Ret);
    BlowFish.Burn;
    SetValue(string(Ret));
  finally
    BlowFish.Free;
    Rijndael.Free;
  end;
end;

procedure TSecureText.Encrypt(const Key1, Key2: AnsiString);
var
  BlowFish: TDCP_Blowfish;
  Rijndael: TDCP_rijndael;
  Ret: AnsiString;
begin
  Rijndael := TDCP_rijndael.Create(nil);
  BlowFish := TDCP_Blowfish.Create(nil);
  try
    Ret := {$IFDEF FPC} EmptyStr {$ELSE} EmptyAnsiStr {$ENDIF};
    Rijndael.InitStr(Key2, TDCP_sha256);
    BlowFish.InitStr(Key1, TDCP_sha256);
    Ret := BlowFish.EncryptString(AnsiString(Value));
    BlowFish.Burn;
    Ret := Rijndael.EncryptString(Ret);
    Rijndael.Burn;
    SetValue(string(Ret));
  finally
    BlowFish.Free;
    Rijndael.Free;
  end;
end;

function TSecureText.IsEmpty: Boolean;
begin
  Result := Size < 1;
end;

function TSecureText.Size: Integer;
begin
  Result := Length(Value);
end;

procedure TSecureText.SetValue(const Value: string);
begin
  SetString(_Value, PChar(Value), System.Length(Value));
end;

constructor TSecureText.Create(const InsecureString: string);
begin
  SetValue(InsecureString);
end;

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

destructor TSecureText.Destroy;
begin
  if not IsEmpty then
    DealocateString(_Value);
  inherited;
end;

class function TSecureText.New(const InsecureString: String): ISecureText;
begin
  Result := TSecureText.Create(InsecureString);
  if not Result.IsEmpty then
    DealocateString(InsecureString);
end;

end.
