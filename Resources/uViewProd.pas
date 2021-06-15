unit uViewProd;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Messaging,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects,
  FMX.Ani,
  uCardProd, uSpeedButton, uDadosProd;

type

  TFrameViewProduto = class(TFrame)
    Fundo: TRectangle;
    Foto: TImage;
    Fechar: TFrameSpeedButton;
    DadosProd: TFrameDadosProduto;
  private
    procedure ListnerShow(const Sender: TObject; const M: TMessage);
    Procedure ShowProduto(aCard : TFrameCardProduto);
    Procedure HideProduto(Sender : TObject);
    procedure ListnerHide(const Sender: TObject; const M: TMessage);
  public
    Constructor Create(aOwner : TComponent); Override;
  end;

Var
   ViewProduto : TFrameViewProduto;

implementation

Uses
   uMessaging;

{$R *.fmx}

{ TFrame1 }

constructor TFrameViewProduto.Create(aOwner: TComponent);
begin
inherited;
FEchar.OnClicked := HideProduto;
TMessageManager.DefaultManager.SubscribeToMessage(TMessageShowProduto, ListnerShow);
TMessageManager.DefaultManager.SubscribeToMessage(TMessageHideProduto, ListnerHide);
end;

procedure TFrameViewProduto.ListnerShow(const Sender: TObject; const M: TMessage);
begin
ShowProduto((M As TmessageShowProduto).CardProd);
end;

procedure TFrameViewProduto.ListnerHide(const Sender: TObject; const M: TMessage);
begin
Parent := Nil;
end;

procedure TFrameViewProduto.HideProduto(Sender : TObject);
begin
TAnimator.AnimateFloat(Self, 'Opacity', 0, 0.3);
TThread.CreateAnonymousThread(
   Procedure
   Begin
   Sleep(300);
   TThread.Queue(Nil,
      Procedure
      Begin
      Parent := Nil;
      End);
   End).Start;
end;

procedure TFrameViewProduto.ShowProduto(aCard: TFrameCardProduto);
begin
Opacity   := 1;
Parent    := Application.MainForm;
Width     := Application.MainForm.ClientWidth;
Height    := Application.MainForm.ClientHeight;
BringToFront;
Fundo.Align      := TAlignLayout.None;
Fundo.Width      := aCard.Width;
Fundo.Height     := aCard.Height;
Fundo.Fill.Color := aCard.Color;
Fundo.XRadius    := aCard.Backgrground.XRadius;
Fundo.YRadius    := aCard.Backgrground.YRadius;
Fundo.Position.X := aCard.Backgrground.AbsoluteRect.Left;
Fundo.Position.Y := aCard.Backgrground.AbsoluteRect.Top;
Foto .Width      := aCard.Image.Width;
Foto .Height     := aCard.Image.Height;
Foto .Position.X := aCard.Image.AbsoluteRect.Left;
Foto .Position.Y := aCard.Image.AbsoluteRect.Top;
Foto .Bitmap     := aCard.Bitmap;
aCard.Opacity    := 0;

DadosProd.CardProd := aCard;

TThread.CreateAnonymousThread(
   Procedure
   Begin
   Sleep(40);

   TThread.Queue(Nil,
      Procedure
      Var
         W, H : Single;
         PosY : Single;
      Begin
      W    := Foto.Width  * 1.5;
      H    := Foto.Height * 1.5;
      PosY := (Application.MainForm.ClientHeight-DadosProd.Height-H)/2;

      TAnimator.AnimateFloat(Fundo, 'Position.X', (Width- Fundo.Width)/2,  0.2);
      TAnimator.AnimateFloat(Fundo, 'Position.Y', (Height-Fundo.Height)/2, 0.2);

      TAnimator.AnimateFloat(Foto,  'Width',      W,                       0.4);
      TAnimator.AnimateFloat(Foto,  'height',     H,                       0.4);
      TAnimator.AnimateFloat(Foto,  'Position.X', (Width - W)/2,           0.4);
      TAnimator.AnimateFloat(Foto,  'Position.Y', PosY,                    0.4);
      End);

   Sleep(200);
   TThread.Queue(Nil,
      Procedure
      Begin
      Fundo.Align := TAlignLayout.Center;
      TAnimator.AnimateFloat(Fundo, 'Width',   Width,  0.2);
      TAnimator.AnimateFloat(Fundo, 'Height',  Height, 0.2);
      TAnimator.AnimateFloat(Fundo, 'XRadius', 0,      0.2);
      TAnimator.AnimateFloat(Fundo, 'YRadius', 0,      0.2);
      End);
   Sleep(200);
   TThread.Queue(Nil,
      Procedure
      Begin
      aCard.Opacity    := 1;
      End);
   End).Start;
end;

Initialization
ViewProduto := TFrameViewProduto.Create(Nil);

Finalization
ViewProduto.DisposeOf;

end.
