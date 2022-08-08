program MailerLiteDemo;

uses
  Vcl.Forms,
  Forms.Main in 'Forms.Main.pas' {Form1},
  MailerLiteService in '..\Source\MailerLiteService.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
