unit uCardProd;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Messaging,
  System.Json,  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, uSpeedButton,
  uDownload;

type
  TFrameCardProduto = class(TFrame, IDownloadResult)
    FBack: TRectangle;
    NomeProd: TText;
    Preco: TText;
    Text3: TText;
    FImage: TImage;
    BtAdd: TFrameSpeedButton;
    procedure FrameResize(Sender: TObject);
    procedure FrameClick(Sender: TObject);
    procedure FrameTap(Sender: TObject; const Point: TPointF);
  private
    FImagesCount: Integer;
    FId: String;
    FShowCard: Boolean;
    FAbout: String;
    FSale: Boolean;
    FCategory: String;
    function GetBitmap: TBitmap;
    function GetColor: TAlphaColor;
    function GetCorner: Single;
    function GetItemName: String;
    function GetPrice: Single;
    procedure SetColor(const Value: TAlphaColor);
    procedure SetCorner(const Value: Single);
    procedure SetItemName(const Value: String);
    procedure SetPrice(const Value: Single);
    Procedure DownlaodFinish(aStr : TStringStream);
  public
    Class Function CreateCardProduto(aParent : TControl; aJson : TJsonObject) : TFrameCardproduto;
    procedure SetPosition(aX, aY : Single);
    Property ShowCard     : Boolean     Read FShowCard    Write FShowCard;
    Property ItemName     : String      Read GetItemName  Write SetItemName;
    Property Price        : Single      Read GetPrice     Write SetPrice;
    Property About        : String      Read FAbout       Write FAbout;
    Property ID           : String      Read FId          Write FId;
    Property Category     : String      Read FCategory    Write FCategory;
    Property Sale         : Boolean     Read FSale        Write FSale;
    Property ImagesCount  : Integer     Read FImagesCount Write FImagesCount;
    Property Color        : TAlphaColor Read GetColor     Write SetColor;
    Property Corner       : Single      Read GetCorner    Write SetCorner;
    Property Bitmap       : TBitmap     Read GetBitmap;
    Property Image        : TImage      Read FImage;
    Property Backgrground : TRectangle  Read FBack;
    end;

implementation

Uses
   uMessaging;

{$R *.fmx}

class function TFrameCardProduto.CreateCardProduto(aParent: TControl; aJson: TJsonObject): TFrameCardproduto;
Var
   R, W, H : Single;
begin
Result             := TFrameCardProduto.Create(aParent);
Result.ID          := aJson.GetValue('id')       .Value;
Result.Category    := aJson.GetValue('categoria').Value;
Result.ItemName    := aJson.GetValue('nome')     .Value;
Result.Price       := aJson.GetValue('preco')    .Value.ToSingle;
Result.About       := aJson.GetValue('descricao').Value;
Result.Sale        := aJson.GetValue('destaque') .Value = 'S';
Result.ImagesCount := aJson.GetValue('fotos')    .Value.ToInteger;
Result.Name        := 'CardProduto'+Result.ID;
Result.Width       := ((aParent As TVertScrollBox).Width-48)/2;
case Trunc(Result.ID.ToInteger Mod 8) of
   0 : Result.Color := $ffff7e6e;
   1 : Result.Color := $fff7ad00;
   2 : Result.Color := $ffffd301;
   3 : Result.Color := $ffffe7c6;
   4 : Result.Color := $ff57bde4;
   5 : Result.Color := $ffff8300;
   6 : Result.Color := $ffffd6e7;
   7 : Result.Color := $ffffd584;
   end;
W             := aJson.GetValue('W').Value.ToInteger;
H             := aJson.GetValue('H').Value.ToInteger;
R             := W  / H;
H             := Result.Height-Result.FImage.Height + ((Result.Width-16) / R);
Result.Height := H;
Result.Parent := aParent;
Result.SetPosition(2000, 0);
TDownload.Add(False, Result, '/produto/foto/'+Result.ID);
end;

procedure TFrameCardProduto.FrameClick(Sender: TObject);
begin
{$IfDef MSWindows}
FrameTap(Sender, TPointF.Create(0,0));
{$ENDIF}
end;

procedure TFrameCardProduto.FrameTap(Sender: TObject; const Point: TPointF);
begin
TMessageManager.DefaultManager.SendMessage(Self, TMessageShowProduto.Create(Self));
end;

procedure TFrameCardProduto.DownlaodFinish(aStr: TStringStream);
begin
TThread.Synchronize(Nil,
   procedure
   Begin
   aStr.Position := 0;
   FImage.Bitmap.LoadFromStream(aStr);
   End);
end;

procedure TFrameCardProduto.FrameResize(Sender: TObject);
begin
BtAdd   .Position.X := Width - BtAdd.Width-10;
NomeProd.Width      := Width - 28;
end;

procedure TFrameCardProduto.SetColor(const Value: TAlphaColor);
begin
FBack.Fill.Color := Value;
end;

procedure TFrameCardProduto.SetCorner(const Value: Single);
begin
FBack.XRadius := Value;
FBack.YRadius := Value;
end;

procedure TFrameCardProduto.SetItemName(const Value: String);
begin
NomeProd.Text := Value;
end;

procedure TFrameCardProduto.SetPosition(aX, aY : Single);
Begin
Position.x := aX;
Position.Y := aY;
End;

procedure TFrameCardProduto.SetPrice(const Value: Single);
begin
Preco.Text := Value.ToString;
end;

function TFrameCardProduto.GetBitmap: TBitmap;
begin
Result := FImage.Bitmap;
end;

function TFrameCardProduto.GetColor: TAlphaColor;
begin
Result := FBack.Fill.Color;
end;

function TFrameCardProduto.GetCorner: Single;
begin
Result := FBack.XRadius;
end;

function TFrameCardProduto.GetItemName: String;
begin
Result := NomeProd.Text;
end;

function TFrameCardProduto.GetPrice: Single;
begin
Result := Preco.Text.ToSingle;
end;

end.
