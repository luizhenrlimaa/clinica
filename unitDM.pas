unit unitDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDM = class(TDataModule)
    Conexao: TFDConnection;
    tbPaciente: TFDTable;
    tbAgendamento: TFDTable;
    dsPaciente: TDataSource;
    dsAgendamento: TDataSource;
    tbPacienteid: TFDAutoIncField;
    tbPacientenome: TStringField;
    tbPacientecpf: TStringField;
    tbPacientecelular: TStringField;
    tbPacientedata_cadastro: TDateField;
    tbAgendamentoid: TFDAutoIncField;
    tbAgendamentoid_paciente: TIntegerField;
    tbAgendamentodata: TDateField;
    tbAgendamentohora: TStringField;
    tbAgendamentoespecialidade: TStringField;
    tbAgendamentomedico: TStringField;
    consulta: TFDQuery;
    procedure tbPacienteAfterInsert(DataSet: TDataSet);
    procedure tbPacienteBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses unitCadPacientes, unitCadAgendamentos , Dialogs;
{$R *.dfm}


procedure TDM.tbPacienteAfterInsert(DataSet: TDataSet);
begin
  tbPacientedata_cadastro.Value := Date();
end;

procedure TDM.tbPacienteBeforePost(DataSet: TDataSet);
begin
      consulta.Close;
      consulta.SQL.Clear;
      consulta.SQL.Add('SELECT cpf from paciente WHERE  cpf = :pCpf');
      consulta.ParamByName('pCpf').Value := tbPacientecpf.Text ;
      consulta.Open;

      if (consulta.RecordCount > 0) then

         begin
            ShowMessage('CPF j? cadastrado!');
            Abort;
         end;
end;

end.
