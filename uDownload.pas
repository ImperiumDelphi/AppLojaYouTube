unit uDownload;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Json, System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;


Const
   Protocol = 'https';
   Host     = 'app.jusimperium.com.br/cgi/cgicurso.exe';
   Port     = '';

type

  IDownloadResult = Interface
     ['{688B050D-A0A8-4FC8-9D66-350C7F86E925}']
     Procedure DownlaodFinish(aStr : TStringStream);
     End;

  TDownloadRequest = Record
     FOwner : IDownloadResult;
     FPath  : String;
     Class Function Create(aOwner : IDownloadResult; aPath : String) : TDownloadRequest; Static;
     Property Owner : IDownloadResult Read FOwner;
     Property Path  : String          Read FPath;
     End;

  TDownload = Class
     Private
        Class Var
           FList  : TList<TDownloadRequest>;
        Class Procedure CreateClass;
     Public
        Class Procedure Add(aPriority : Boolean; aOwner : IDownloadResult; aPath : String);
     End;



implementation

{ TDownloadRequest }

class function TDownloadRequest.Create(aOwner: IDownloadResult; aPath: String): TDownloadRequest;
begin
Result.FOwner := aOwner;
Result.FPath  := aPath;
end;


{ TDownload }

class procedure TDownload.Add(aPriority: Boolean; aOwner : IDownloadResult; aPath : String);
begin
TMonitor.Enter(FList);
if aPriority And (FList.Count > 0) then
   FList.Insert(0, TDownloadRequest.Create(aOwner, aPath))
Else
   FList.Add(TDownloadRequest.Create(aOwner, aPath));
TMonitor.Exit(FList);
end;

class procedure TDownload.CreateClass;
begin
FList := TList<TDownloadRequest>.Create;
TThread.CreateAnonymousThread(
   Procedure
   Var
      http : TNetHttpClient;
      Str  : TStringStream;
      Item : TDownloadRequest;
   Begin
   http := TNetHttpClient.Create(Nil);
   Str  := TStringStream.Create('', TEncoding.UTF8);
   Http.ResponseTimeout := 6000;
   while Not Application.Terminated do
      Begin
      if Flist.Count > 0 then
         Begin
         TMonitor.Enter(FList);
         Item := Flist.Items[0];
         FList.Delete(0);
         TMonitor.Exit(FList);
         Str.Clear;
         Try
            Http.Get(Protocol+'://'+Host+'/'+Item.Path, Str);
            Item.FOwner.DownlaodFinish(Str);
         Except
            End;
         End
      Else
         Sleep(20);
      End;
   http .DisposeOf;
   Str  .DisposeOf;
   Flist.DisposeOf;
   End).Start;
end;

Initialization
TDownload.CreateClass;



end.
