program QRcode;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {fMain},
  uConfig in 'uConfig.pas',
  uLog in 'uLog.pas',
  DelphiZXIngQRCode in 'DelphiZXIngQRCode.pas',
  uQRCode in 'uQRCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
