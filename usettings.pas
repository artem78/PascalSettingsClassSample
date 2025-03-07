unit USettings;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IniFiles;

type
  TSettingsChangeNotifyEvent = procedure(const AParam: String) of Object;

  { TSettings }

  TSettings = class
    private
      Ini: TIniFile;

      procedure SetFormTitle(const AVal: String);
      function GetFormTitle: String;
      procedure SetNum(AVal: Integer);
      function GetNum: Integer;
      procedure SetFloatNum(AVal: Double);
      function GetFloatNum: Double;
      procedure SetChecked(AVal: Boolean);
      function GetChecked: Boolean;

      procedure SetParam(const AName: String; AVal: Variant);
      procedure DoChange(const AParam: String);
    public
      OnChange: TSettingsChangeNotifyEvent;

      constructor Create;
      destructor Destroy; override;

      property FormTitle: String read GetFormTitle write SetFormTitle;
      property Num: Integer read GetNum write SetNum;
      property FloatNum: Double read GetFloatNum write SetFloatNum;
      property Checked: Boolean read GetChecked write SetChecked;
  end;

var
  Settings: TSettings;

implementation

uses Variants;

const MAIN_INI_SECTION = 'general';

procedure TSettings.SetFormTitle(const AVal: String);
begin
  SetParam('FormTitle', AVal);
end;

function TSettings.GetFormTitle: String;
begin
  Result := ini.ReadString(MAIN_INI_SECTION, 'FormTitle', 'THE FORM');
end;

procedure TSettings.SetNum(AVal: Integer);
begin
  SetParam('Num', AVal);
end;

function TSettings.GetNum: Integer;
begin
  Result := ini.ReadInteger(MAIN_INI_SECTION, 'Num', -1);
end;

procedure TSettings.SetFloatNum(AVal: Double);
begin
  SetParam('FloatNum', AVal);
end;

function TSettings.GetFloatNum: Double;
begin
  Result := ini.ReadFloat(MAIN_INI_SECTION, 'FloatNum', 0.0);
end;

procedure TSettings.SetChecked(AVal: Boolean);
begin
  SetParam('Checked', AVal);
end;

function TSettings.GetChecked: Boolean;
begin
  Result := ini.ReadBool(MAIN_INI_SECTION, 'Checked', False);
end;

procedure TSettings.SetParam(const AName: String; AVal: Variant);
begin
  case varType(AVal) of
    varInteger: ini.WriteInteger(MAIN_INI_SECTION, AName, AVal);
    varString: ini.WriteString(MAIN_INI_SECTION, AName, AVal);
    varBoolean: ini.WriteBool(MAIN_INI_SECTION, AName, AVal);
    varDouble: ini.WriteFloat(MAIN_INI_SECTION, AName, AVal);
    else
      raise Exception.CreateFmt('Don''t know how to save type %d', [ord(varType(AVal))]);
  end;

  DoChange(AName);
end;

procedure TSettings.DoChange(const AParam: String);
begin
  if Assigned(OnChange) then
    OnChange(AParam);
end;

constructor TSettings.Create;
begin
  OnChange := Nil;

  Ini := TIniFile.Create('settings.ini', [ifoWriteStringBoolean]);
  ini.BoolTrueStrings := ['true'];
  ini.BoolFalseStrings := ['false'];
end;

destructor TSettings.Destroy;
begin
  Ini.Free;
end;

initialization
  Settings := TSettings.Create;

finalization
  Settings.Free;

end.

