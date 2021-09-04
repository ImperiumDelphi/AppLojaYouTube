unit uLoja;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Json, System.Messaging,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, uListaProduto;

type
  TForm7 = class(TForm)
    FrameListaProdutos1: TFrameListaProdutos;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
  end;

var
  Form7: TForm7;

implementation

Uses
   uMessaging;

{$R *.fmx}

procedure TForm7.FormClose(Sender: TObject; var Action: TCloseAction);
begin
TMessageManager.DefaultManager.SendMessage(Self, TMessageHideProduto.Create);
end;

end.
