unit uSpeedButton;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Filter.Effects, FMX.Objects;

type
  TFrameSpeedButton = class(TFrame)
    Rectangle1: TRectangle;
    Image1: TImage;
    FillRGBEffect1: TFillRGBEffect;
    procedure FrameClick(Sender: TObject);
    procedure FrameTap(Sender: TObject; const Point: TPointF);
  private
    FOnClicked: TNotifyEvent;
  public
    Property OnClicked : TNotifyEvent Read FOnClicked   Write FOnClicked;
  end;

implementation

{$R *.fmx}

procedure TFrameSpeedButton.FrameClick(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
FrameTap(Sender, TPointF.Create(0, 0));
{$ENDIF}
end;

procedure TFrameSpeedButton.FrameTap(Sender: TObject; const Point: TPointF);
begin
If Assigned(FOnClicked) Then FonClicked(Sender);
end;

end.
