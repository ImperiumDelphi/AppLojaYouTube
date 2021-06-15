unit uMessaging;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Json, System.Messaging,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, uListaProduto, FMX.ISMessageDlg,
  uCardProd;

type

  TMessageShowProduto = Class(TMessage)
     Private
        FCard : TFrameCardProduto;
     Public
        Constructor Create(aCardProd : TFrameCardProduto);
        Property CardProd : TFrameCardProduto Read FCard;
     End;

  TMessageHideProduto = Class(TMessage);

implementation

{ TMessageShowProduto }

constructor TMessageShowProduto.Create(aCardProd: TFrameCardProduto);
begin
FCard := aCardProd;
end;



end.
