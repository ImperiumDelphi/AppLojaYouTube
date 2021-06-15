unit uListaProduto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Json,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts,
  uDownload;

type
  TFrameListaProdutos = class(TFrame, IDownloadResult)
    ListaProduto: TVertScrollBox;
  private
    Procedure ListaProdutos;
    procedure RealignCards;
    procedure DownlaodFinish(aStr: TStringStream);
  Protected
    Procedure Loaded; Override;
  public
  end;

implementation

Uses
   uCardProd;

{$R *.fmx}

{ TFrame1 }

procedure TFrameListaProdutos.Loaded;
begin
inherited;
ListaProdutos;
end;

procedure TFrameListaProdutos.ListaProdutos;
begin
TDownload.Add(True, Self, 'produtos');
end;

Procedure TFrameListaProdutos.DownlaodFinish(aStr : TStringStream);
Var
   Str : TStringStream;
Begin
Str := TStringStream.Create('', TEncoding.utf8);
Str.LoadFromStream(aStr);
TThread.CreateAnonymousThread(
   Procedure
   Var
      JsonArr  : TJsonArray;
      Json     : TJsonObject;
      I        : Integer;
   Begin
   JSonArr := TJsonObject.ParseJSONValue(Str.DataString) As TJsonArray;
   for I := 0 to JSonArr.Count-1 do
      Begin
      Json := JSonArr.Items[I] As TJsonObject;
      TFrameCardProduto.CreateCardProduto(ListaProduto, Json);
      End;
   RealignCards;
   Str.DisposeOf;
   End).Start;
End;

procedure TFrameListaProdutos.RealignCards;
begin
TThread.Queue(Nil,
   Procedure
   Var
      Y1, Y2 : Single;
      X      : Single;
      I      : Integer;
      Item   : TFrameCardProduto;
   Begin
   Y1 := 0;
   Y2 := 0;
   for I := 0 to ListaProduto.Content.ControlsCount-1 do
      Begin
      Item := ListaProduto.Content.Controls.Items[I] As TFrameCardProduto;
      if Y1 <= Y2 then
         Begin
         X := 16;
         Item.SetPosition(x, Y1);
         Y1 := Y1 + Item.Height+16;
         End
      Else
         Begin
         X := Listaproduto.Width/2 + 8;
         Item.SetPosition(x, Y2);
         Y2 := Y2 + Item.Height+16;
         End;
      End;
   End);
end;

end.
