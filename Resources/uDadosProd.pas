unit uDadosProd;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Ani,
  uCardProd, uFarmeTextButton, FMX.Layouts, uSpin;

type
  TFrameDadosProduto = class(TFrame)
    Rectangle1: TRectangle;
    Nome: TText;
    Qtd: TFrameSpin;
    Valor: TText;
    Layout1: TLayout;
    Text1: TText;
    Text2: TText;
    Descricao: TText;
    FrameTextButton1: TFrameTextButton;
  private
    FCardProd: TFrameCardProduto;
    procedure SetCardProd(const Value: TFrameCardProduto);
    procedure ClickQtd(Sender : TObject);
  public
    Constructor Create(aOwner : TComponent); Override;
    Property CardProd : TFrameCardProduto  Read FCardProd Write SetCardProd;
    Procedure Hide;
  end;

implementation

{$R *.fmx}

{ TFrameDadosProduto }

procedure TFrameDadosProduto.ClickQtd(Sender: TObject);
begin
Valor.Text := (Qtd.Value * FcardProd.Price).ToString;
end;

constructor TFrameDadosProduto.Create(aOwner: TComponent);
begin
inherited;
Qtd.OnChange := ClickQtd;
end;

procedure TFrameDadosProduto.Hide;
begin
TAnimator.AnimateFloat(Self, 'Margins.Bottom', -Height, 0.4);
end;

procedure TFrameDadosProduto.SetCardProd(const Value: TFrameCardProduto);
begin
FCardProd       := Value;
Nome     .Text  := '';
Descricao.Text  := '';
Qtd      .Value := 1;
TThread.CreateAnonymousThread(
   Procedure
   Begin
   TThread.Synchronize(Nil,
      procedure
      Begin
      Nome     .Text := FCardProd.ItemName;
      Descricao.Text := FCardProd.About;
      Valor    .Text := FCardProd.Price.ToString;
      End);
   TThread.Synchronize(Nil,
      procedure
      Begin
      Height := 239+Descricao.Height;
      Margins.Bottom := -Height;
      TAnimator.AnimateFloat(Self, 'Margins.Bottom', 0, 0.4);
      End);
   End).Start;
end;

end.
