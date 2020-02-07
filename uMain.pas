unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,strutils,
  uConfig,uLog,uQRcode,Jpeg,Vcl.Imaging.pngimage;

type
  TfMain = class(TForm)
    Panel1: TPanel;
    btnClose: TButton;
    Bar1: TStatusBar;
    btnSave: TButton;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    cmbEncoding: TComboBox;
    edtQuietZone: TEdit;
    cmbSize: TComboBox;
    Label1: TLabel;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    cmbType: TComboBox;
    Label4: TLabel;
    Save1: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure cmbEncodingChange(Sender: TObject);
    procedure edtQuietZoneChange(Sender: TObject);
    procedure cmbSizeChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    procedure updateQR();
    function getRect(para:string):TRect;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}
function TfMain.getRect(para:string):TRect;
var
  w,h,i:integer;
  s1,s2:string;
begin
  result:=Rect(0, 0, 600, 600);
  i:=pos('*',para);
  if(i<=0)then exit;
  s1:=leftstr(para,i-1);
  s2:=rightstr(para,length(para)-i);
  w:=strtointdef(s1,600);
  h:=strtointdef(s2,600);
  result:=Rect(0,0,w,h);
end;
procedure TfMain.updateQR();
var
  bmp:TBitmap;
  rt:TRect;
begin

  bmp:=QRcode.getBmp(memo1.Text);
  rt:=getRect(cmbSize.Text);
  image1.Picture.Assign(nil);
  image1.Width:=rt.Width;
  image1.Height:=rt.Height;
  image1.canvas.fillrect(rect(0,0,image1.Width,image1.Height));
  image1.Canvas.StretchDraw(rt, bmp);
  image1.Update;
  bar1.Panels[0].Text:='大小：'+cmbSize.Text;
end;
procedure TfMain.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfMain.btnSaveClick(Sender: TObject);
var
  jpg: TJPEGImage; // 要use Jpeg单元
  png: TPNGImage;
  filename:string;
begin
  //image1.Picture.SaveToFile('c:\b.bmp');
  save1.FilterIndex:=cmbType.ItemIndex+1;
  save1.FileName:='a.'+cmbType.Items[cmbType.ItemIndex];
  if(save1.Execute(fmain.handle))then
  begin
    filename:=save1.FileName;
    save1.InitialDir:=extractfiledir(filename);
  end else begin
    exit;
  end;
  case cmbType.ItemIndex of
  0:begin
      image1.Picture.Bitmap.SaveToFile(filename);
    end;
  1:begin
      jpg:=TJPEGImage.Create;
      jpg.Assign(image1.Picture.Bitmap);
      jpg.SaveToFile(filename);
      //image1.Picture.Bitmap.SaveToFile('c:\b.bmp');
      jpg.Free;
    end;
  2:begin
      png:= TPNGImage.Create;
      png.Assign(image1.Picture.Bitmap);
      //png.CompressionLevel:=9;
      png.SaveToFile(filename);
      //image1.Picture.Bitmap.SaveToFile('c:\b.bmp');
      png.Free;
    end;
  end;


end;

procedure TfMain.cmbEncodingChange(Sender: TObject);
begin
  QRcode.Encoding:=cmbEncoding.ItemIndex;
  updateQR();
end;

procedure TfMain.cmbSizeChange(Sender: TObject);
begin
  updateQR();
end;

procedure TfMain.edtQuietZoneChange(Sender: TObject);
begin
  QRcode.QuietZone:=strtointdef(trim(edtQuietZone.Text),4);
  updateQR();
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QRcode.Free;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  QRcode:=TQRcode.Create;
  fmain.Caption:=uConfig.APP_NAME+uConfig.APP_VERSION+uConfig.APP_CONTACT;
  updateQR();

end;

procedure TfMain.Memo1Change(Sender: TObject);
begin
  updateQR();
end;

end.
