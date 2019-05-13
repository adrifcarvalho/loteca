unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Menus, StdCtrls, uInclusao, uAuxiliar, uAlteracao,
  UAlteracaoSemResultado, uConsulta, uDM, System.UITypes, //UInformarPartida,
  //UJogoCartas, UJogoCartasAuto01, UJogoCartasAuto02; //UAnalisePartida,
  //UAnalisePadroes;//,
  UConsultaPartida, uAlteracaoPartidaSemResultado;

type
  TFPrincipal = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    MainMenu1: TMainMenu;
    Incluso1: TMenuItem;
    Alteracao: TMenuItem;
    Label1: TLabel;
    Alterar1: TMenuItem;
    Alterarjogoespecfico1: TMenuItem;
    Consulta1: TMenuItem;
    BaseDados: TMenuItem;
    Alterardescriocavaleiros1: TMenuItem;
    CargaAuxiliar1: TMenuItem;
    Jogarcartas1: TMenuItem;
    Jogosemordemdecrescente1: TMenuItem;
    Analisedejogosporpartida1: TMenuItem;
    Analisedepadroes1: TMenuItem;
    Consultaporpartida1: TMenuItem;
    Alterarresultadodeumapartida1: TMenuItem;
    tradicional1: TMenuItem;
    auto01: TMenuItem;
    auto02: TMenuItem;
    procedure Incluso1Click(Sender: TObject);
    procedure Alterarjogoespecfico1Click(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure Alterardescriocavaleiros1Click(Sender: TObject);
    procedure CargaAuxiliar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Jogosemordemdecrescente1Click(Sender: TObject);
    procedure Analisedejogosporpartida1Click(Sender: TObject);
    procedure Analisedepadroes1Click(Sender: TObject);
    procedure Consultaporpartida1Click(Sender: TObject);
    procedure Alterarresultadodeumapartida1Click(Sender: TObject);
    procedure tradicional1Click(Sender: TObject);
    procedure auto01Click(Sender: TObject);
    procedure auto02Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

procedure TFPrincipal.Incluso1Click(Sender: TObject);
begin
   FInclusao := TFInclusao.Create(Self);
   FInclusao.ShowModal;
end;

procedure TFPrincipal.Jogosemordemdecrescente1Click(Sender: TObject);
begin
   FConsulta := TFConsulta.Create(Self);
   FConsulta.ShowModal;
end;

procedure TFPrincipal.tradicional1Click(Sender: TObject);
begin
(*   FInformarPartida := TFInformarPartida.Create(Self);
   FInformarPartida.ShowModal;
   if (FInformarPartida.ModalResult = mrOk) then
   begin
      FJogoCartas := TFJogoCartas.Create(Self);
      FJogoCartas.gsTimeA   := FInformarPartida.TimeASel;
      FJogoCartas.gsTimeB   := FInformarPartida.TimeBSel;
      FJogoCartas.gsData    := FInformarPartida.DataSel;
      FJogoCartas.giPartida := FInformarPartida.PartidaSel;
      FInformarPartida.Close;
      FJogoCartas.ShowModal;
   end;*)
end;

procedure TFPrincipal.Alterarjogoespecfico1Click(Sender: TObject);
begin
   FAlteracao := TFAlteracao.Create(Self);
   FAlteracao.ShowModal;
end;

procedure TFPrincipal.Alterarresultadodeumapartida1Click(Sender: TObject);
begin
   FAlteracaoPartidaSemResultado := TFAlteracaoPartidaSemResultado.Create(Self);
   FAlteracaoPartidaSemResultado.ShowModal;
end;

procedure TFPrincipal.Analisedejogosporpartida1Click(Sender: TObject);
begin
 //  FAnalisePartida := TFAnalisePartida.Create(Self);
  // FAnalisePartida.ShowModal;
end;

procedure TFPrincipal.Analisedepadroes1Click(Sender: TObject);
begin
//   FAnalisePadroes := TFAnalisePadroes.Create(Self);
 //  FAnalisePadroes.ShowModal;
end;

procedure TFPrincipal.auto01Click(Sender: TObject);
begin
(*   FInformarPartida := TFInformarPartida.Create(Self);
   FInformarPartida.ShowModal;
   if (FInformarPartida.ModalResult = mrOk) then
   begin
        FJogoCartasAuto01 := TFJogoCartasAuto01.Create(Self);
        FJogoCartasAuto01.gsTimeA   := FInformarPartida.TimeASel;
        FJogoCartasAuto01.gsTimeB   := FInformarPartida.TimeBSel;
        FJogoCartasAuto01.gsData    := FInformarPartida.DataSel;
        FJogoCartasAuto01.giPartida := FInformarPartida.PartidaSel;
        FJogoCartasAuto01.gsImagemA := FInformarPartida.ImagemTimeASel;
        FJogoCartasAuto01.gsImagemB := FInformarPartida.ImagemTimeBSel;
        FInformarPartida.Close;
        FJogoCartasAuto01.ShowModal;
   end;*)
end;

procedure TFPrincipal.auto02Click(Sender: TObject);
begin
(*   FInformarPartida := TFInformarPartida.Create(Self);
   FInformarPartida.ShowModal;
   if (FInformarPartida.ModalResult = mrOk) then
   begin
        FJogoCartasAuto02 := TFJogoCartasAuto02.Create(Self);
        FJogoCartasAuto02.gsTimeA   := FInformarPartida.TimeASel;
        FJogoCartasAuto02.gsTimeB   := FInformarPartida.TimeBSel;
        FJogoCartasAuto02.gsData    := FInformarPartida.DataSel;
        FJogoCartasAuto02.giPartida := FInformarPartida.PartidaSel;
        FJogoCartasAuto02.gsImagemA := FInformarPartida.ImagemTimeASel;
        FJogoCartasAuto02.gsImagemB := FInformarPartida.ImagemTimeBSel;
        FInformarPartida.Close;
        FJogoCartasAuto02.ShowModal;
   end;*)
end;

procedure TFPrincipal.Alterar1Click(Sender: TObject);
begin
   FAlteracaoSemResultado := TFAlteracaoSemResultado.Create(Self);
   FAlteracaoSemResultado.ShowModal;
end;

procedure TFPrincipal.CargaAuxiliar1Click(Sender: TObject);
begin
   FAuxiliar := TFAuxiliar.Create(Self);
   FAuxiliar.ShowModal;
end;

procedure TFPrincipal.Consultaporpartida1Click(Sender: TObject);
begin
   FConsultaPartida := TFConsultaPartida.Create(Self);
   FConsultaPartida.ShowModal;
end;

procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TFPrincipal.Alterardescriocavaleiros1Click(Sender: TObject);
begin
   MessageDlg('Aguarde, alterando banco de dados...',mtWarning,[mbOk],0);
   Screen.Cursor := crSQLWait;
   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add('update ARCANOS_MENORES set Descricao = ''CAV COPAS'' where Numero = ''C'' and Naipe = ''C''');
   DM.FDQuery1.ExecSQL;

   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add('update ARCANOS_MENORES set Descricao = ''CAV ESPADAS'' where Numero = ''C'' and Naipe = ''E''');
   DM.FDQuery1.ExecSQL;

   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add('update ARCANOS_MENORES set Descricao = ''CAV OUROS'' where Numero = ''C'' and Naipe = ''O''');
   DM.FDQuery1.ExecSQL;

   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add('update ARCANOS_MENORES set Descricao = ''CAV PAUS'' where Numero = ''C'' and Naipe = ''P''');
   DM.FDQuery1.ExecSQL;
   DM.FDQuery1.Close;

   Screen.Cursor := crDefault;
   MessageDlg('Alteração efetuada com sucesso!',mtInformation,[mbOk],0);
end;

end.
