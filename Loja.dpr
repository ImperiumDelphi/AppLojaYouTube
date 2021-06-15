program Loja;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLoja in 'uLoja.pas' {Form7},
  uCardProd in 'Resources\uCardProd.pas' {FrameCardProduto: TFrame},
  uSpeedButton in 'Resources\uSpeedButton.pas' {FrameSpeedButton: TFrame},
  uDownload in 'uDownload.pas',
  uListaProduto in 'Resources\uListaProduto.pas' {FrameListaProdutos: TFrame},
  uViewProd in 'Resources\uViewProd.pas' {FrameViewProduto: TFrame},
  uDadosProd in 'Resources\uDadosProd.pas' {FrameDadosProduto: TFrame},
  uSpin in 'Resources\uSpin.pas' {FrameSpin: TFrame},
  uFarmeTextButton in 'Resources\uFarmeTextButton.pas' {FrameTextButton: TFrame},
  uMessaging in 'uMessaging.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.

