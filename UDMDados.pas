unit UDMDados;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, System.IOUtils, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDMDados = class(TDataModule)
    FDConnection: TFDConnection;
    QDados: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDConnectionAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMDados: TDMDados;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDMDados.DataModuleCreate(Sender: TObject);
begin
  //Aqui especifico o local que será salvo o banco de dados
  //Caminho padrão definido pelo sistema.
  FDConnection.Params.Values['Database'] := System.IOUtils.TPath.GetDocumentsPath +
                                          '/' + 'BDDados.SQL';
end;

procedure TDMDados.FDConnectionAfterConnect(Sender: TObject);
begin
  Var SQL, SQLLOGIN : String;

  //Crio a tabela de Cliente
  SQL := 'CREATE TABLE IF NOT EXISTS CLIENTE (' +
         '  ID_CLIENTE INTEGER,' +
         '  NOME TEXT,' +
         '  EMAIL TEXT, ' +
         '  CPF TEXT,' +
         '  PRIMARY KEY (ID_CLIENTE))';

  SQLLOGIN := 'CREATE TABLE IF NOT EXISTS USUARIO (' +
              '  ID_LOGIN INTEGER, ' +
              '  NOME TEXT, ' +
              '  SENHA TEXT, ' +
              '  PRIMARY KEY (ID_LOGIN))';
  //Executo o que está na variável SQL
  FDConnection.ExecSQL(SQL);
  FDConnection.ExecSQL(SQLLOGIN);
end;

end.
