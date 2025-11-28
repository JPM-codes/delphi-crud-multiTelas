unit UFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.Objects,
  FMX.Layouts, FMX.Edit, System.Actions, FMX.ActnList, FMX.DialogService;

type
  TFrmPrincipal = class(TForm)
    ActionList1: TActionList;
    MudaAba: TChangeTabAction;
    TabControl1: TTabControl;
    TabLogin: TTabItem;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    Layout1: TLayout;
    Image1: TImage;
    Anotações: TLabel;
    Layout3: TLayout;
    Rectangle8: TRectangle;
    EditSenha: TEdit;
    Rectangle9: TRectangle;
    Label4: TLabel;
    Layout2: TLayout;
    Rectangle7: TRectangle;
    EditLogin: TEdit;
    TabMenu: TTabItem;
    Rectangle10: TRectangle;
    Rectangle11: TRectangle;
    Image2: TImage;
    Label6: TLabel;
    Layout4: TLayout;
    Rectangle12: TRectangle;
    Rectangle13: TRectangle;
    Image3: TImage;
    Label1: TLabel;
    TabCadastro: TTabItem;
    Label2: TLabel;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Layout5: TLayout;
    Image4: TImage;
    Label3: TLabel;
    Layout6: TLayout;
    Rectangle3: TRectangle;
    EditCadConfSenha: TEdit;
    Rectangle4: TRectangle;
    Label5: TLabel;
    Layout7: TLayout;
    Rectangle14: TRectangle;
    EditCadSenha: TEdit;
    Layout8: TLayout;
    Rectangle15: TRectangle;
    EditCadNome: TEdit;
    Rectangle16: TRectangle;
    Rectangle17: TRectangle;
    Label8: TLabel;
    TabCadastroSucesso: TTabItem;
    Rectangle18: TRectangle;
    Rectangle19: TRectangle;
    Label7: TLabel;
    Timer1: TTimer;
    procedure Rectangle9Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Rectangle12Click(Sender: TObject);
    procedure Rectangle16Click(Sender: TObject);
    procedure Rectangle17Click(Sender: TObject);
    procedure Rectangle4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UFrmCliente, UDMDados;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  TabControl1.ActiveTab := TabLogin;
  TabControl1.TabPosition := TTabPosition.None;
end;

procedure TFrmPrincipal.Image2Click(Sender: TObject);
begin
  TDialogService.MessageDialog('Deseja realmente sair?',
    // AMessage: A mensagem a ser exibida
    TMsgDlgType.mtConfirmation,
    // ADialogType: Tipo de diálogo (ícone de confirmação)
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    // AButtons: Botões a serem exibidos (Sim e Não)
    TMsgDlgBtn.mbNo, // ADefaultButton: Botão padrão focado (opcional)
    0, // AHelpContext: Contexto de ajuda (opcional, use 0)
    procedure(const AResult: TModalResult)
    // ACloseDialogProc: Método anônimo (callback)
    begin
      // Este bloco de código será executado APÓS o usuário clicar em um botão
      if AResult = mrYes then
      begin
        // Código para quando o usuário clicar em 'Sim'
        EditLogin.Text := '';
        EditSenha.Text := '';

        MudaAba.Tab := TabLogin;
        MudaAba.ExecuteTarget(Self);
      end
    end);
end;


procedure TFrmPrincipal.Rectangle12Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCliente, FrmCliente);
  FrmCliente.Show;
end;

procedure TFrmPrincipal.Rectangle16Click(Sender: TObject);
begin
  MudaAba.Tab := TabCadastro;
  MudaAba.ExecuteTarget(Self);
end;

procedure TFrmPrincipal.Rectangle17Click(Sender: TObject);
begin
  MudaAba.Tab := TabLogin;
  MudaAba.ExecuteTarget(Self);
end;

procedure TFrmPrincipal.Rectangle4Click(Sender: TObject);
begin
  // Validações para não deixar salvar sem preencher.
  if EditCadNome.Text = '' then
  begin
    ShowMessage('Preencha o nome');
    Exit;
  end;

  if EditCadSenha.Text = '' then
  begin
    ShowMessage('Preencha a senha');
    Exit;
  end;

  if EditCadConfSenha.Text = '' then
  begin
    ShowMessage('Preencha o confirmar senha');
    Exit;
  end;

  if (EditCadSenha.Text <> EditCadConfSenha.Text) then
  begin
    ShowMessage('As senhas não são iguais!');
    Exit;
  end;

  DMDados.QDados.Close;
  DMDados.QDados.SQL.Clear;
  DMDados.QDados.SQL.Add('SELECT * FROM USUARIO');
  DMDados.QDados.SQL.Add('WHERE NOME = :NOME');
  DMDados.QDados.ParamByName('NOME').Value := EditCadNome.Text;

  DMDados.QDados.Open();
  if not(DMDados.QDados.IsEmpty) then
  begin
    ShowMessage('O usuario ' + EditCadNome.Text + ' já existe!');
    Exit;
  end;

  DMDados.QDados.Close;
  DMDados.QDados.SQL.Clear;

  begin
    DMDados.QDados.SQL.Add('INSERT INTO USUARIO (NOME, SENHA) ');
    DMDados.QDados.SQL.Add('VALUES (:NOME, :SENHA)');
  end;

  DMDados.QDados.ParamByName('NOME').Value := EditCadNome.Text;
  DMDados.QDados.ParamByName('SENHA').Value := EditCadSenha.Text;
  DMDados.QDados.ExecSQL;

  EditCadNome.Text := '';
  EditCadSenha.Text := '';
  EditCadConfSenha.Text := '';


  MudaAba.Tab := TabCadastroSucesso;
  MudaAba.ExecuteTarget(Self);
  Timer1.Enabled := True;
end;

procedure TFrmPrincipal.Rectangle9Click(Sender: TObject);
begin

  // Validações básicas
  if EditLogin.Text = '' then
  begin
    ShowMessage('Digite o usuário!');
    Exit;
  end;

  if EditSenha.Text = '' then
  begin
    ShowMessage('Digite a senha!');
    Exit;
  end;

  // Consulta no banco
  DMDados.QDados.Close;
  DMDados.QDados.SQL.Clear;
  DMDados.QDados.SQL.Add('SELECT * FROM USUARIO');
  DMDados.QDados.SQL.Add('WHERE NOME = :NOME AND SENHA = :SENHA');
  DMDados.QDados.ParamByName('NOME').Value := EditLogin.Text;
  DMDados.QDados.ParamByName('SENHA').Value := EditSenha.Text;

  DMDados.QDados.Open;

  // Se não encontrou usuário
  if DMDados.QDados.IsEmpty then
  begin
    ShowMessage('Usuário ou senha incorretos!');
    Exit;
  end;

  // Se chegou aqui, login OK
  ShowMessage('Login realizado com sucesso!');

  // Abra o menu ou mude de tela
  MudaAba.Tab := TabMenu;
  MudaAba.ExecuteTarget(Self);

end;

procedure TFrmPrincipal.Timer1Timer(Sender: TObject);
begin
  MudaAba.Tab := TabLogin;
  MudaAba.ExecuteTarget(Self);
  Timer1.Enabled := False;
end;

end.
