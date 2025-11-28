unit UFrameCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation;

type
  TFrameCliente = class(TFrame)
    Rectangle1: TRectangle;
    Image1: TImage;
    ImgAlterar: TImage;
    ImgExcluir: TImage;
    LabelNome: TLabel;
    LabelEmail: TLabel;
    procedure ImgAlterarClick(Sender: TObject);
    procedure ImgExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses UFrmCliente;

procedure TFrameCliente.ImgAlterarClick(Sender: TObject);
begin
  FrmCliente.AlteraCliente(ImgAlterar.Tag);
end;

procedure TFrameCliente.ImgExcluirClick(Sender: TObject);
begin
  FrmCliente.DeletaCliente(ImgExcluir.Tag);
end;

end.
