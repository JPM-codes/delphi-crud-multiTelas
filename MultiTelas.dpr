program MultiTelas;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFrmPrincipal in 'UFrmPrincipal.pas' {FrmPrincipal},
  UFrmCliente in 'UFrmCliente.pas' {FrmCliente},
  UDMDados in 'UDMDados.pas' {DMDados: TDataModule},
  UFrameCliente in 'UFrameCliente.pas' {FrameCliente: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmCliente, FrmCliente);
  Application.CreateForm(TDMDados, DMDados);
  Application.Run;
end.
