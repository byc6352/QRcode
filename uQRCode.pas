unit uQRCode;

interface
uses
  windows, Vcl.Graphics,DelphiZXingQRCode;
type
  //TQRCodeEncoding = (qrAuto, qrNumeric, qrAlphanumeric, qrISO88591, qrUTF8NoBOM, qrUTF8BOM);
  TQRCode = class
    private
      mQRCodeBitmap:TBitmap;
      mEncoding:integer;
      mQRCodeEncoding:TQRCodeEncoding;
      mQuietZone:integer;
      procedure setEncoding(Encoding:integer);
      procedure setQuietZone(QuietZone:integer);
    public
      constructor Create();
      destructor Destroy;   //override;
      property QRCodeBitmap:TBitmap read mQRCodeBitmap;
      property Encoding:integer read mEncoding write setEncoding;
      property QuietZone:integer read mQuietZone write setQuietZone;
      function getBmp(text:string):TBitmap;
  end;
var
  QRCode:TQRCode;
implementation
constructor TQRCode.Create();
begin
  mQRCodeBitmap:=tBitmap.create;
  mQRCodeEncoding:=qrAuto;
  mEncoding:=0;
  mQuietZone:=4;
end;
destructor TQRCode.Destroy;
begin
  mQRCodeBitmap.free;
end;
{-------------------------------------------------------------------------------
������:    setEncoding ���ñ���ģʽ
����:      Encoding:TQRCodeEncoding  1.����ģʽ��
����ֵ:    �ޡ�

-------------------------------------------------------------------------------}
procedure TQRCode.setEncoding(Encoding:integer);
begin
  mEncoding:=Encoding;
  mQRCodeEncoding:=TQRCodeEncoding(Encoding);
end;
{-------------------------------------------------------------------------------
������:    setEncoding ���ñ���ģʽ
����:      Encoding:TQRCodeEncoding  1.����ģʽ��
����ֵ:    �ޡ�

-------------------------------------------------------------------------------}
procedure TQRCode.setQuietZone(QuietZone:integer);
begin
  mQuietZone:=QuietZone;
end;
{-------------------------------------------------------------------------------
������:    getBmp ���ɶ�ά��ͼƬ
����:      text:string  1���ַ�����
����ֵ:    TBitmap�� ��ά��ͼƬ

-------------------------------------------------------------------------------}
function TQRCode.getBmp(text:string):TBitmap;
var
  DelphiZXingQRCode: TDelphiZXingQRCode;
  Row, Column: Integer;
begin
  DelphiZXingQRCode := TDelphiZXingQRCode.Create;
  try
    DelphiZXingQRCode.Data := Text;
    DelphiZXingQRCode.Encoding := mQRCodeEncoding;
    DelphiZXingQRCode.QuietZone := mQuietZone;
    mQRCodeBitmap.SetSize(DelphiZXingQRCode.Rows, DelphiZXingQRCode.Columns);
    for Row := 0 to DelphiZXingQRCode.Rows - 1 do
    begin
      for Column := 0 to DelphiZXingQRCode.Columns - 1 do
      begin
        if (DelphiZXingQRCode.IsBlack[Row, Column]) then
        begin
          mQRCodeBitmap.Canvas.Pixels[Column, Row] := clBlack;
        end else
        begin
          mQRCodeBitmap.Canvas.Pixels[Column, Row] := clWhite;
        end;
      end;
    end;
  finally
    result:=mQRCodeBitmap;
    DelphiZXingQRCode.Free;
  end;

end;
end.