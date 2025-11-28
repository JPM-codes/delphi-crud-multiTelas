unit UFrmCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Objects, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Actions, FMX.ActnList, FMX.Layouts, FMX.DialogService;

type
  TFrmCliente = class(TForm)
    TabControl1: TTabControl;
    TabConsulta: TTabItem;
    TabCadastro: TTabItem;
    Rectangle1: TRectangle;
    Image1: TImage;
    Rectangle2: TRectangle;
    Image2: TImage;
    Rectangle3: TRectangle;
    Label1: TLabel;
    EditNome: TEdit;
    Rectangle4: TRectangle;
    Label2: TLabel;
    EditCPF: TEdit;
    Rectangle5: TRectangle;
    Label3: TLabel;
    EditEmail: TEdit;
    RecSalvar: TRectangle;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Rectangle7: TRectangle;
    Label7: TLabel;
    ActionList1: TActionList;
    MudaAba: TChangeTabAction;
    VertCliente: TVertScrollBox;
    Image3: TImage;
    procedure Image1Click(Sender: TObject);
    procedure Rectangle7Click(Sender: TObject);
    procedure RecSalvarClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AtualizaCliente; //Ctrl + Shift + C
    procedure AlteraCliente(CodigoCliente: integer);
    procedure DeletaCliente(CodigoCliente: integer);
  end;

var
  FrmCliente: TFrmCliente;

implementation

{$R *.fmx}

uses UDMDados, UFrameCliente;

procedure TFrmCliente.AlteraCliente(CodigoCliente: integer);
begin
  DMDados.QDados.Close;
  DMDados.QDados.SQL.Clear;
  DMDados.QDados.SQL.Add('SELECT * FROM CLIENTE WHERE ID_CLIENTE =:ID_CLIENTE');
  DMDados.QDados.ParamByName('ID_CLIENTE').Value := CodigoCliente;
  DMDados.QDados.Open;

  EditNome.Text  := DMDados.QDados.FieldByName('NOME').AsString;
  EditEmail.Text := DMDados.QDados.FieldByName('EMAIL').AsString;
  EditCPF.Text   := DMDados.QDados.FieldByName('CPF').AsString;

  //Deixo marcado a tag do botão com o código que quero Alterar
  RecSalvar.Tag := CodigoCliente;

  MudaAba.Tab := TabCadastro;
  MudaAba.ExecuteTarget(Self);
end;

procedure TFrmCliente.AtualizaCliente;
begin
  //Responsável por atualizar os clientes cadastrados
  VertCliente.BeginUpdate;

  var i : integer;

  //Limpando todos os itens do VertScrollBox -> VertCliente
  for i := VertCliente.Content.ChildrenCount - 1 downto 0 do
    if VertCliente.Content.Children[i] is TFrame then
      TFrame(VertCliente.Content.Children[i]).DisposeOf;

  var Frame : TFrameCliente;

  DMDados.QDados.Close;
  DMDados.QDados.SQL.Clear;
  DMDados.QDados.SQL.Add('SELECT * FROM CLIENTE ORDER BY NOME');
  DMDados.QDados.Open;
  While not DMDados.QDados.Eof do
  begin
    Frame := TFrameCliente.Create(nil);

    Frame.LabelNome.Text  := DMDados.QDados.FieldByName('NOME').AsString;
    Frame.LabelEmail.Text := DMDados.QDados.FieldByName('EMAIL').AsString;

    Frame.ImgAlterar.Tag := DMDados.QDados.FieldByName('ID_CLIENTE').AsInteger;
    Frame.ImgExcluir.Tag := DMDados.QDados.FieldByName('ID_CLIENTE').AsInteger;

    Frame.Align := TAlignLayout.Top;
    VertCliente.AddObject(Frame);

    DMDados.QDados.Next;
  end;

  VertCliente.EndUpdate;
end;

procedure TFrmCliente.DeletaCliente(CodigoCliente: integer);
begin
  //uses - FMX.DialogService

  TDialogService.MessageDialog(
    'Deseja realmente excluir?',         // AMessage: A mensagem a ser exibida
    TMsgDlgType.mtConfirmation,          // ADialogType: Tipo de diálogo (ícone de confirmação)
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], // AButtons: Botões a serem exibidos (Sim e Não)
    TMsgDlgBtn.mbNo,                     // ADefaultButton: Botão padrão focado (opcional)
    0,                                   // AHelpContext: Contexto de ajuda (opcional, use 0)
    procedure(const AResult: TModalResult) // ACloseDialogProc: Método anônimo (callback)
    begin
      // Este bloco de código será executado APÓS o usuário clicar em um botão
      if AResult = mrYes then
      begin
        // Código para quando o usuário clicar em 'Sim'
        DMDados.QDados.Close;
        DMDados.QDados.SQL.Clear;
        DMDados.QDados.SQL.Add('DELETE FROM CLIENTE WHERE ID_CLIENTE =:ID_CLIENTE');
        DMDados.QDados.ParamByName('ID_CLIENTE').Value := CodigoCliente;
        DMDados.QDados.ExecSQL;

        AtualizaCliente;
      end
    end
  );
end;

procedure TFrmCliente.FormShow(Sender: TObject);
begin
  //Hora de abrir a tela
  AtualizaCliente;

  TabControl1.ActiveTab := TabConsulta;
  TabControl1.TabPosition := TTabPosition.None;
end;

procedure TFrmCliente.Image1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmCliente.Image2Click(Sender: TObject);
begin
  MudaAba.Tab := TabConsulta;
  MudaAba.ExecuteTarget(Self);
end;

procedure TFrmCliente.Image3Click(Sender: TObject);
begin
  AtualizaCliente;
end;

procedure TFrmCliente.RecSalvarClick(Sender: TObject);
begin
  //Validações para não deixar salvar sem preencher.
  if EditNome.Text = '' then
  begin
    ShowMessage('Preencha o nome');
    Exit;
  end;

  if EditEmail.Text = '' then
  begin
    ShowMessage('Preencha o email');
    Exit;
  end;

  if EditCPF.Text = '' then
  begin
    ShowMessage('Preencha o CPF');
    Exit;
  end;

  DMDados.QDados.Close;
  DMDados.QDados.SQL.Clear;

  if RecSalvar.Tag = 0 then
  begin
    DMDados.QDados.SQL.Add('INSERT INTO CLIENTE (NOME, EMAIL, CPF) ');
    DMDados.QDados.SQL.Add('VALUES (:NOME, :EMAIL, :CPF)');
  end
  else
  begin
    DMDados.QDados.SQL.Add('UPDATE CLIENTE SET NOME = :NOME, EMAIL = :EMAIL, CPF = :CPF ');
    DMDados.QDados.SQL.Add(' WHERE ID_CLIENTE = :ID_CLIENTE');
    DMDados.QDados.ParamByName('ID_CLIENTE').Value := RecSalvar.Tag;
  end;

  DMDados.QDados.ParamByName('NOME').Value  := EditNome.Text;
  DMDados.QDados.ParamByName('EMAIL').Value := EditEmail.Text;
  DMDados.QDados.ParamByName('CPF').Value   := EditCPF.Text;
  DMDados.QDados.ExecSQL;

  EditNome.Text  := '';
  EditEmail.Text := '';
  EditCPF.Text   := '';

  AtualizaCliente;

  MudaAba.Tab := TabConsulta;
  MudaAba.ExecuteTarget(Self);
end;

procedure TFrmCliente.Rectangle7Click(Sender: TObject);
begin
  //Deixo marcado a tag do botão gravar com 0 = inserindo
  RecSalvar.Tag := 0;

  MudaAba.Tab := TabCadastro;
  MudaAba.ExecuteTarget(Self);
end;

end.
