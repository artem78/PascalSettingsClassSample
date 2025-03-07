unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin, USettings;

type
  { TForm1 }

  TForm1 = class(TForm)
    Add5Button: TButton;
    Label1: TLabel;
    SpinEdit2: TSpinEdit;
    Sub5Button: TButton;
    SaveButton: TButton;
    CheckBox1: TCheckBox;
    Edit2: TEdit;
    FloatSpinEdit1: TFloatSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    procedure Add5ButtonClick(Sender: TObject);
    procedure CheckBox1Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure SpinEdit1Exit(Sender: TObject);
    procedure SpinEdit2Exit(Sender: TObject);
    procedure Sub5ButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    //Settings: TSettings;
    procedure OnSettingsChange(const AParam: String);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}


{ TForm1 }

procedure TForm1.SaveButtonClick(Sender: TObject);
begin
  Settings.FormTitle:=Edit2.Text;
  Settings.Num:=SpinEdit1.Value;
  Settings.FloatNum:=FloatSpinEdit1.Value;
  Settings.Checked:=CheckBox1.Checked;

  //Settings.Save;
end;

procedure TForm1.Add5ButtonClick(Sender: TObject);
begin
  //SpinEdit1.Value := SpinEdit1.Value + 5;
  Settings.Num := Settings.Num + 5;
end;

procedure TForm1.CheckBox1Exit(Sender: TObject);
begin
  Settings.Checked := TCheckBox(Sender).Checked;
end;

procedure TForm1.Edit2Exit(Sender: TObject);
begin
  Settings.FormTitle := TEdit(Sender).Text;
end;

procedure TForm1.SpinEdit1Exit(Sender: TObject);
begin
  Settings.Num := TSpinEdit(Sender).Value;
end;

procedure TForm1.SpinEdit2Exit(Sender: TObject);
begin
  Settings.Num := TSpinEdit(Sender).Value;
end;

procedure TForm1.Sub5ButtonClick(Sender: TObject);
begin
  //SpinEdit1.Value := SpinEdit1.Value - 5;
  Settings.Num := Settings.Num - 5;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //Settings := TSettings.Create;
  Settings.OnChange := @OnSettingsChange;

  // Fill initial values
  Caption := Settings.FormTitle;
  Edit2.Text := Settings.FormTitle;
  SpinEdit1.Value := Settings.Num;
  SpinEdit2.Value := Settings.Num;
  FloatSpinEdit1.Value := Settings.FloatNum;
  CheckBox1.Checked := Settings.Checked;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  //Settings.Free;
end;

procedure TForm1.OnSettingsChange(const AParam: String);
begin
  //ShowMessage(AParam);
  case AParam of
    'FormTitle':
      begin
        Caption := Settings.FormTitle;
        Edit2.Text := Settings.FormTitle;
      end;

    'Num':
      begin
        SpinEdit1.Value := Settings.Num;
        SpinEdit2.Value := Settings.Num;
      end;

    'FloatNum':
      FloatSpinEdit1.Value := Settings.FloatNum;

    'Checked':
      CheckBox1.Checked := Settings.Checked;

    else
      ShowMessage(AParam + ' changed');
  end;
end;

end.

