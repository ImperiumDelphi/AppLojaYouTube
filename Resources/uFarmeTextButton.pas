unit uFarmeTextButton;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects;

type
  TFrameTextButton = class(TFrame)
    Rectangle1: TRectangle;
    Text1: TText;
    procedure FrameClick(Sender: TObject);
    procedure FrameTap(Sender: TObject; const Point: TPointF);
  private
    FOnClicked: TNotifyEvent;
  public
    Property OnClicked : TNotifyEvent Read FOnClicked   Write FOnClicked;
  end;

implementation

{$R *.fmx}

procedure TFrameTextButton.FrameClick(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
FrameTap(Sender, TPointF.Create(0, 0));
{$ENDIF}
end;

procedure TFrameTextButton.FrameTap(Sender: TObject; const Point: TPointF);
begin
If Assigned(FOnClicked) Then FonClicked(Sender);
end;

end.
