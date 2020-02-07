unit uConfig;

interface
uses
  Vcl.Forms,System.SysUtils,windows;
const
  //https://www.debenu.com/open-source/delphizxingqrcode/
  DEBUG:boolean=false;
  APP_NAME='��ά��������';
  APP_VERSION='v1.01';
  APP_CONTACT='��ϵ��ʽ��QQ:39848872΢��:byc6352';
  WORK_DIR:string='QRcode';
  LOG_NAME:string='QRcodeLog.txt';

var
  workdir:string;//����Ŀ¼
  logfile:string;//
  apkfilename:string;
  isInit:boolean=false;

  procedure init();
implementation
procedure init();
var
    me:String;
begin
  isInit:=true;
  me:=application.ExeName;
  workdir:=extractfiledir(me)+'\'+WORK_DIR;
  if(not DirectoryExists(workdir))then ForceDirectories(workdir);

  logfile:=workdir+'\'+LOG_NAME;

end;
begin
  init();
end.