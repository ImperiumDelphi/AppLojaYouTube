unit uSpin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects, uSpeedButton;

type
  TFrameSpin = class(TFrame)
    BTMenos: TFrameSpeedButton;
    BtMais: TFrameSpeedButton;
    Valor: TText;
  private
    FOnChange: TNotifyEvent;
    function GetValue: Integer;
    procedure SetValue(const Value: Integer);
    procedure ClickSpin(Sender : TObject);
  public
    COnstructor Create(aOwner : TComponent); Override;
    Property Value    : Integer      Read GetValue   Write SetValue;
    Property OnChange : TNotifyEvent Read FOnChange  Write FOnChange;

  end;

implementation

{$R *.fmx}

{ TFrameSpin }

procedure TFrameSpin.ClickSpin(Sender: TObject);
begin
Value := Value + (Sender As TFrame).Tag;
if Value < 1 then Value := 1;
end;

constructor TFrameSpin.Create(aOwner: TComponent);
begin
inherited;
BtMenos.OnClicked := ClickSpin;
BtMais .OnClicked := ClickSpin;
end;

function TFrameSpin.GetValue: Integer;
begin
Result := Valor.Text.ToInteger;
end;

procedure TFrameSpin.SetValue(const Value: Integer);
begin
if Valor.text <> Value.ToString then
   Begin
   Valor.Text := Value.ToString;
   if Assigned(FOnChange) then FonChange(Self);
   End;
end;

end.
