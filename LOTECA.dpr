program LOTECA;

uses
  Forms,
  UAuxiliar in 'UAuxiliar.pas' {FAuxiliar},
  UInclusao in 'UInclusao.pas' {FInclusao},
  UPrincipal in 'UPrincipal.pas' {FPrincipal},
  UDM in 'UDM.pas' {DM: TDataModule},
  UAlteracao in 'UAlteracao.pas' {FAlteracao},
  UAlteracaoPartidaSemResultado in 'UAlteracaoPartidaSemResultado.pas' {FAlteracaoPartidaSemResultado},
  UConsulta in 'UConsulta.pas' {FConsulta},
  UConsultaPartida in 'UConsultaPartida.pas' {FConsultaPartida},
  UAlteracaoSemResultado in 'UAlteracaoSemResultado.pas' {FAlteracaoSemResultado};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'LOTECA';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
