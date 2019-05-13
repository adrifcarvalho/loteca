unit UAnalisePadroes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, SqlExpr, Buttons, Grids, DBGrids,
  ExtCtrls, uDM, ComCtrls, FireDAC.UI.Intf, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, System.UITypes, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.CheckLst;

type
  TFAnalisePadroes = class(TForm)
    Panel1: TPanel;
    RadioGroupTime: TRadioGroup;
    BitBtnPrever: TBitBtn;
    Label13: TLabel;
    BitBtnLimpar: TBitBtn;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    StringGrid1: TStringGrid;
    FDQuery1: TFDQuery;
    FDQuery1Count: TFDQuery;
    Panel5: TPanel;
    FDQHeader: TFDQuery;
    Panel2: TPanel;
    GroupBoxTimeA: TGroupBox;
    GroupBoxTimeB: TGroupBox;
    cklbCasaA1: TCheckListBox;
    Label1: TLabel;
    cklbCasaA2: TCheckListBox;
    Label2: TLabel;
    cklbCasaA3: TCheckListBox;
    Label3: TLabel;
    Label4: TLabel;
    cklbCasaB1: TCheckListBox;
    Label5: TLabel;
    cklbCasaB2: TCheckListBox;
    Label6: TLabel;
    cklbCasaB3: TCheckListBox;
    Label43: TLabel;
    Label44: TLabel;
    MaskEditData: TMaskEdit;
    ComboBoxPartidas: TComboBox;
    Label45: TLabel;
    procedure BitBtnPreverClick(Sender: TObject);
    procedure BitBtnLimparClick(Sender: TObject);
//    procedure NiceGrid1DrawCell(Sender: TObject; ACanvas: TCanvas; X,
  //    Y: Integer; Rc: TRect; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure MaskEditDataChange(Sender: TObject);
  private
    { Private declarations }
    lsArcanoMaior1A, lsArcanoMenor1A, lsNaipe1A: string;
    lsArcanoMaior2A, lsArcanoMenor2A, lsNaipe2A: string;
    lsArcanoMaior3A, lsArcanoMenor3A, lsNaipe3A: string;
    lsArcanoMaior1B, lsArcanoMenor1B, lsNaipe1B: string;
    lsArcanoMaior2B, lsArcanoMenor2B, lsNaipe2B: string;
    lsArcanoMaior3B, lsArcanoMenor3B, lsNaipe3B: string;

    procedure MontarSQLPadrao(Query: TFDQuery; QueryCount: TFDQuery);
    procedure PreencherNiceGrid(NiceGrid: TNiceGrid; Query: TFDQuery; bHeader: Boolean);
    procedure PreencherStringGrid(QueryHeader: TFDQuery; QueryDetail: TFDQuery; Grid: TStringGrid; bHeader: Boolean);
    procedure LimparEdits;
    procedure LimparGrids(var NiceGrid: TNiceGrid; var SGrid: TStringGrid);
  public
    { Public declarations }
    gs1AMaior, gs1AMenor, gs1ANaipe,
    gs2AMaior, gs2AMenor, gs2ANaipe,
    gs3AMaior, gs3AMenor, gs3ANaipe,
    gs1BMaior, gs1BMenor, gs1BNaipe,
    gs2BMaior, gs2BMenor, gs2BNaipe,
    gs3BMaior, gs3BMenor, gs3BNaipe: string;
  end;
  TTotais = record
     QtdVitoria: real;
     QtdDerrota: real;
     QtdEmpate : real;
     QtdTotal:   real;
  end;

var
  FAnalisePadroes: TFAnalisePadroes;
  gTotais: TTotais;

const ap = Chr(39);

implementation

{$R *.dfm}

procedure TFAnalisePadroes.FormCreate(Sender: TObject);
begin
   //limpa o StringGrid
   NiceGrid1.RowCount := 0;
end;

procedure TFAnalisePadroes.BitBtnPreverClick(Sender: TObject);
var lsSQL, lsPartida: string;
begin
   if (MaskEditData.Text = '  /  /    ') then
   begin
      MessageDlg('Informe a data do jogo!', mtWarning,[mbOk],0);
      MaskEditData.SetFocus;
      Exit;
   end;

   if (ComboBoxPartidas.ItemIndex = -1) then
   begin
      MessageDlg('Escolha uma partida!', mtWarning, [mbOk], 0);
      ComboBoxPartidas.SetFocus;
      Exit;
   end;

   if (RadioGroupTime.ItemIndex = -1) then
   begin
      MessageDlg('Escolha um filtro!', mtWarning, [mbOk], 0);
      RadioGroupTime.SetFocus;
      Exit;
   end;

   LimparEdits;
   LimparGrids(NiceGrid1,StringGrid1);


   lsPartida := ComboBoxPartidas.Items[ComboBoxPartidas.ItemIndex];
   lsPartida := Copy(lsPartida,1,Pos(' - ',lsPartida)-1);

   LimparEdits;
   LimparGrids(NiceGrid1,StringGrid1);

   Screen.Cursor := crHourGlass;
   //encontra os jogos da partida. Para cada jogo, alimentar os grids com os padrões
   try
      lsSQL := 'select * from LOTECA where Id in (select idJogo from JOGOS_PARTIDAS where idPartida = '+lsPartida+')';
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.Open;
   except
      MessageDlg('Erro consulta à tabela LOTECA'+#13#10+'SQL = '+lsSQL, mtError, [mbOk], 0);
      DM.FDQuery1.Close;
      Screen.Cursor := crDefault;
      Exit;
   end;

   while not DM.FDQuery1.Eof do
   begin
      lsArcanoMaior1A := DM.FDQuery1.FieldByName('A_CASA1_MAIOR').AsString;
      lsArcanoMenor1A := DM.FDQuery1.FieldByName('A_CASA1_MENOR').AsString;
      lsNaipe1A       := DM.FDQuery1.FieldByName('A_CASA1_NAIPE').AsString;
      lsArcanoMaior2A := DM.FDQuery1.FieldByName('A_CASA2_MAIOR').AsString;
      lsArcanoMenor2A := DM.FDQuery1.FieldByName('A_CASA2_MENOR').AsString;
      lsNaipe2A       := DM.FDQuery1.FieldByName('A_CASA2_NAIPE').AsString;
      lsArcanoMaior3A := DM.FDQuery1.FieldByName('A_CASA3_MAIOR').AsString;
      lsArcanoMenor3A := DM.FDQuery1.FieldByName('A_CASA3_MENOR').AsString;
      lsNaipe3A       := DM.FDQuery1.FieldByName('A_CASA3_NAIPE').AsString;

      lsArcanoMaior1B := DM.FDQuery1.FieldByName('B_CASA1_MAIOR').AsString;
      lsArcanoMenor1B := DM.FDQuery1.FieldByName('B_CASA1_MENOR').AsString;
      lsNaipe1B       := DM.FDQuery1.FieldByName('B_CASA1_NAIPE').AsString;
      lsArcanoMaior2B := DM.FDQuery1.FieldByName('B_CASA2_MAIOR').AsString;
      lsArcanoMenor2B := DM.FDQuery1.FieldByName('B_CASA2_MENOR').AsString;
      lsNaipe2B       := DM.FDQuery1.FieldByName('B_CASA2_NAIPE').AsString;
      lsArcanoMaior3B := DM.FDQuery1.FieldByName('B_CASA3_MAIOR').AsString;
      lsArcanoMenor3B := DM.FDQuery1.FieldByName('B_CASA3_MENOR').AsString;
      lsNaipe3B       := DM.FDQuery1.FieldByName('B_CASA3_NAIPE').AsString;

      FDQHeader.Close;
      FDQHeader.ParamByName('liId').AsInteger := DM.FDQuery1.FieldByName('Id').AsInteger;
      FDQHeader.Open;

      //encontrar os padrões para cada um dos jogos que estarão com cabeçalho em cinza
      MontarSQLPadrao(FDQuery1, FDQuery1Count);
      DM.FDQuery1.Next;
   end;

   //agora coloca em forma de percentagem
   if (gTotais.QtdTotal <> 0) then
   begin
      gTotais.QtdVitoria := ((gTotais.QtdVitoria * 100)/gTotais.QtdTotal);
      gTotais.QtdDerrota := ((gTotais.QtdDerrota * 100)/gTotais.QtdTotal);
      gTotais.QtdEmpate  := ((gTotais.QtdEmpate * 100)/gTotais.QtdTotal);
//      EdVitorias1.Text := FormatFloat('#0.00',gTotais.QtdVitoria[1]) + '%';
//      EdDerrotas1.Text := FormatFloat('#0.00',gTotais.QtdDerrota[1]) + '%';
//      EdEmpates1.Text  := FormatFloat('#0.00',gTotais.QtdEmpate[1]) + '%';
   end;

   Screen.Cursor := crDefault;
end;

{*****************************************************************************
*                                                                            *
**********                     MontarSQLPadrao                      **********
*                                                                            *
*****************************************************************************}
procedure TFAnalisePadroes.MaskEditDataChange(Sender: TObject);
var lsSQL, lsData: string;
begin
   if (Length(Trim(MaskEditData.Text)) <> 10) then Exit;

   if (MaskEditData.Text = '  /  /    ') then
   begin
      MessageDlg('Informe a data do jogo!', mtWarning,[mbOk],0);
      MaskEditData.SetFocus;
      Exit;
   end;

   try
      StrToDate(MaskEditData.Text);
   except
      MessageDlg('Data inválida!', mtWarning,[mbOk],0);
      MaskEditData.SetFocus;
      Exit;
   end;

   lsData := MaskEditData.Text;
   lsData := Copy(lsData,7,4)+'-'+Copy(lsData,4,2)+'-'+Copy(lsData,1,2);

   try
      lsSQL := 'select * from PARTIDAS where data_partida = '+AP+lsData+AP+
               ' order by idPartida';
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.Open;

      ComboBoxPartidas.Items.Clear;
      while not DM.FDQuery1.Eof do
      begin
         ComboBoxPartidas.Items.Add(FormatFloat('00',DM.FDQuery1.FieldByName('idPartida').AsInteger)+' - '+
                                    DM.FDQuery1.FieldByName('timeA').AsString+' X '+
                                    DM.FDQuery1.FieldByName('timeB').AsString);
         DM.FDQuery1.Next;
      end;
      ComboBoxPartidas.Enabled := True;
      ComboBoxPartidas.ItemIndex := 0;
   except
      MessageDlg('Erro consulta à tabela PARTIDAS'+#13#10+'SQL = '+lsSQL, mtError, [mbOk], 0);
      DM.FDQuery1.Close;
      Screen.Cursor := crDefault;
      Exit;
   end;
end;

procedure TFAnalisePadroes.MontarSQLPadrao(Query: TFDQuery; QueryCount: TFDQuery);
var lsSQL: string;
    lbPrivez: Boolean;
    lsArcMai1Filtro, lsArcMai2Filtro, lsArcMai3Filtro, lsArcMen1Filtro,
    lsArcMen2Filtro, lsArcMen3Filtro, lsNaipe1Filtro, lsNaipe2Filtro, lsNaipe3Filtro,
    lsArcMai1Oposto, lsArcMai2Oposto, lsArcMai3Oposto,lsArcMen1Oposto,
    lsArcMen2Oposto, lsArcMen3Oposto, lsNaipe1Oposto, lsNaipe2Oposto, lsNaipe3Oposto: string;
begin
   case RadioGroupTime.ItemIndex of
      0: //comparar com time A
      begin
         lsArcMai1Filtro := lsArcanoMaior1A;
         lsArcMai2Filtro := lsArcanoMaior2A;
         lsArcMai3Filtro := lsArcanoMaior3A;
         lsArcMen1Filtro := lsArcanoMenor1A;
         lsArcMen2Filtro := lsArcanoMenor2A;
         lsArcMen3Filtro := lsArcanoMenor3A;
         lsNaipe1Filtro := lsNaipe1A;
         lsNaipe2Filtro := lsNaipe2A;
         lsNaipe3Filtro := lsNaipe3A;
         lsArcMai1Oposto := lsArcanoMaior1B;
         lsArcMai2Oposto := lsArcanoMaior2B;
         lsArcMai3Oposto := lsArcanoMaior3B;
         lsArcMen1Oposto := lsArcanoMenor1B;
         lsArcMen2Oposto := lsArcanoMenor2B;
         lsArcMen3Oposto := lsArcanoMenor3B;
         lsNaipe1Oposto := lsNaipe1B;
         lsNaipe2Oposto := lsNaipe2B;
         lsNaipe3Oposto := lsNaipe3B;
      end;
      1: //comparar com time B
      begin
         lsArcMai1Filtro := lsArcanoMaior1B;
         lsArcMai2Filtro := lsArcanoMaior2B;
         lsArcMai3Filtro := lsArcanoMaior3B;
         lsArcMen1Filtro := lsArcanoMenor1B;
         lsArcMen2Filtro := lsArcanoMenor2B;
         lsArcMen3Filtro := lsArcanoMenor3B;
         lsNaipe1Filtro := lsNaipe1B;
         lsNaipe2Filtro := lsNaipe2B;
         lsNaipe3Filtro := lsNaipe3B;
         lsArcMai1Oposto := lsArcanoMaior1A;
         lsArcMai2Oposto := lsArcanoMaior2A;
         lsArcMai3Oposto := lsArcanoMaior3A;
         lsArcMen1Oposto := lsArcanoMenor1A;
         lsArcMen2Oposto := lsArcanoMenor2A;
         lsArcMen3Oposto := lsArcanoMenor3A;
         lsNaipe1Oposto := lsNaipe1A;
         lsNaipe2Oposto := lsNaipe2A;
         lsNaipe3Oposto := lsNaipe3A;
      end;
   end;

   try
      Query.Close;
      Query.SQL.Clear;

      lsSQL := 'select Vitoria, ''A'' as Equipe, '+
               'a1MA.Descricao as A1MAIOR, a1ME.Descricao as A1MENOR, '+
               'a2MA.Descricao as A2MAIOR, a2ME.Descricao as A2MENOR, '+
               'a3MA.Descricao as A3MAIOR, a3ME.Descricao as A3MENOR, '+
               'b1MA.Descricao as B1MAIOR, b1ME.Descricao as B1MENOR, '+
               'b2MA.Descricao as B2MAIOR, b2ME.Descricao as B2MENOR, '+
               'b3MA.Descricao as B3MAIOR, b3ME.Descricao as B3MENOR  '+
               'from LOTECA '+
               'join ARCANOS_MAIORES a1MA on(a1MA.Codigo = A_CASA1_MAIOR) '+
               'join ARCANOS_MENORES a1ME on(a1ME.Numero = A_CASA1_MENOR and a1ME.Naipe = A_CASA1_NAIPE) '+
               'join ARCANOS_MAIORES a2MA on(a2MA.Codigo = A_CASA2_MAIOR) '+
               'join ARCANOS_MENORES a2ME on(a2ME.Numero = A_CASA2_MENOR and a2ME.Naipe = A_CASA2_NAIPE) '+
               'join ARCANOS_MAIORES a3MA on(a3MA.Codigo = A_CASA3_MAIOR) '+
               'join ARCANOS_MENORES a3ME on(a3ME.Numero = A_CASA3_MENOR and a3ME.Naipe = A_CASA3_NAIPE) '+
               'join ARCANOS_MAIORES b1MA on(b1MA.Codigo = B_CASA1_MAIOR) '+
               'join ARCANOS_MAIORES b2MA on(b2MA.Codigo = B_CASA2_MAIOR) '+
               'join ARCANOS_MAIORES b3MA on(b3MA.Codigo = B_CASA3_MAIOR) '+
               'join ARCANOS_MENORES b1ME on(b1ME.Numero = B_CASA1_MENOR and b1ME.Naipe = B_CASA1_NAIPE) '+
               'join ARCANOS_MENORES b2ME on(b2ME.Numero = B_CASA2_MENOR and b2ME.Naipe = B_CASA2_NAIPE) '+
               'join ARCANOS_MENORES b3ME on(b3ME.Numero = B_CASA3_MENOR and b3ME.Naipe = B_CASA3_NAIPE) '+
               'WHERE Vitoria is not null ';

      //TIME A CASA 1
      if (cklbCasaA1.Checked[0]) then
         lsSQL := lsSQL + ' and A_CASA1_MAIOR = '''+lsArcMai1Filtro+'''';

      if (cklbCasaA1.Checked[1]) then
      begin
         if not (cklbCasaA1.Checked[2]) and not (cklbCasaA1.Checked[3]) then
            lsSQL := lsSQL + ' and (A_CASA1_MENOR = '''+lsArcMen1Filtro+''' and A_CASA1_NAIPE = '''+lsNaipe1Filtro+''') ';

         if (cklbCasaA1.Checked[2]) and not (cklbCasaA1.Checked[3]) then
            lsSQL := lsSQL + ' and ( (A_CASA1_MENOR = '''+lsArcMen1Filtro+''' and A_CASA1_NAIPE = '''+lsNaipe1Filtro+''') or '+
                     '       (A_CASA1_NAIPE = '''+lsNaipe1Filtro+''') )';

         if not (cklbCasaA1.Checked[2]) and (cklbCasaA1.Checked[3]) then
            lsSQL := lsSQL + ' and ( (A_CASA1_MENOR = '''+lsArcMen1Filtro+''' and A_CASA1_NAIPE = '''+lsNaipe1Filtro+''') or '+
                     '       (A_CASA1_MENOR = '''+lsArcMen1Filtro+''') )';
      end
      else
      begin
         if (cklbCasaA1.Checked[2]) and (cklbCasaA1.Checked[3]) then
            lsSQL := lsSQL + ' and (A_CASA1_MENOR = '''+lsArcMen1Filtro+''' or A_CASA1_NAIPE = +'''+lsNaipe1Filtro+''') ';

         if (cklbCasaA1.Checked[2]) and not (cklbCasaA1.Checked[3]) then
            lsSQL := lsSQL + ' and A_CASA1_NAIPE = '''+lsNaipe1Filtro+'''';

         if not(cklbCasaA1.Checked[2]) and (cklbCasaA1.Checked[3]) then
            lsSQL := lsSQL + ' and A_CASA1_MENOR = '''+lsArcMen1Filtro+'''';
      end;

      //TIME A CASA 2
      if (cklbCasaA2.Checked[0]) then
         lsSQL := lsSQL + ' and A_CASA2_MAIOR = '''+lsArcMai2Filtro+'''';

      if (cklbCasaA2.Checked[1]) then
      begin
         if not (cklbCasaA2.Checked[2]) and not (cklbCasaA2.Checked[3]) then
            lsSQL := lsSQL + ' and (A_CASA2_MENOR = '''+lsArcMen2Filtro+''' and A_CASA2_NAIPE = '''+lsNaipe2Filtro+''') ';
         if (cklbCasaA2.Checked[2]) and not (cklbCasaA2.Checked[3]) then
            lsSQL := lsSQL + ' and ( (A_CASA2_MENOR = '''+lsArcMen2Filtro+''' and A_CASA2_NAIPE = '''+lsNaipe2Filtro+''') or '+
                     '       (A_CASA2_NAIPE = '''+lsNaipe2Filtro+''') )';
         if not (cklbCasaA2.Checked[2]) and (cklbCasaA2.Checked[3]) then
            lsSQL := lsSQL + ' and ( (A_CASA2_MENOR = '''+lsArcMen2Filtro+''' and A_CASA2_NAIPE = '''+lsNaipe2Filtro+''') or '+
                     '       (A_CASA2_MENOR = '''+lsArcMen2Filtro+''') )';
      end
      else
      begin
         if (cklbCasaA2.Checked[2]) and (cklbCasaA2.Checked[3]) then
            lsSQL := lsSQL + ' and (A_CASA2_MENOR = '''+lsArcMen2Filtro+''' or A_CASA2_NAIPE = '''+lsNaipe2Filtro+''') ';

         if (cklbCasaA2.Checked[2]) and not (cklbCasaA2.Checked[3]) then
            lsSQL := lsSQL + ' and A_CASA2_NAIPE = '''+lsNaipe2Filtro+'''';

         if not(cklbCasaA2.Checked[2]) and (cklbCasaA2.Checked[3]) then
            lsSQL := lsSQL + ' and A_CASA2_MENOR = '''+lsArcMen2Filtro+'''';
      end;

      //TIME A CASA 3
      if (cklbCasaA3.Checked[0]) then
         lsSQL := lsSQL + ' and A_CASA3_MAIOR = '''+lsArcMai3Filtro+'''';

      if (cklbCasaA3.Checked[1]) then
      begin
         if not (cklbCasaA3.Checked[2]) and not (cklbCasaA3.Checked[3]) then
            lsSQL := lsSQL + ' and (A_CASA3_MENOR = '''+lsArcMen3Filtro+''' and A_CASA3_NAIPE = '''+lsNaipe3Filtro+''') ';

         if (cklbCasaA3.Checked[2]) and not (cklbCasaA3.Checked[3]) then
            lsSQL := lsSQL + ' and ( (A_CASA3_MENOR = '''+lsArcMen3Filtro+''' and A_CASA3_NAIPE = '''+lsNaipe3Filtro+''') or '+
                     '       (A_CASA3_NAIPE = '''+lsNaipe3Filtro+''') )';

         if not (cklbCasaA3.Checked[2]) and (cklbCasaA3.Checked[3]) then
            lsSQL := lsSQL + ' and ( (A_CASA3_MENOR = '''+lsArcMen3Filtro+''' and A_CASA3_NAIPE = '''+lsNaipe3Filtro+''') or '+
                     '       (A_CASA3_MENOR = '''+lsArcMen3Filtro+''') )';
      end
      else
      begin
         if (cklbCasaA3.Checked[2]) and (cklbCasaA3.Checked[3]) then
            lsSQL := lsSQL + ' and (A_CASA3_MENOR = '''+lsArcMen3Filtro+''' or A_CASA3_NAIPE = '''+lsNaipe3Filtro+''') ';

         if (cklbCasaA3.Checked[2]) and not (cklbCasaA3.Checked[3]) then
            lsSQL := lsSQL + ' and A_CASA3_NAIPE = '''+lsNaipe3Filtro+'''';

         if not(cklbCasaA3.Checked[2]) and (cklbCasaA3.Checked[3]) then
            lsSQL := lsSQL + ' and A_CASA3_MENOR = '''+lsArcMen3Filtro+'''';
      end;

      //TIME B CASA 1
      if (cklbCasaB1.Checked[0]) then
         lsSQL := lsSQL + ' and B_CASA1_MAIOR = '''+lsArcMai1Oposto+'''';

      if (cklbCasaB1.Checked[1]) then
      begin
         if not (cklbCasaB1.Checked[2]) and not (cklbCasaB1.Checked[3]) then
            lsSQL := lsSQL + ' and (B_CASA1_MENOR = '''+lsArcMen1Oposto+''' and B_CASA1_NAIPE = '''+lsNaipe1Oposto+''') ';

         if (cklbCasaB1.Checked[2]) and not (cklbCasaB1.Checked[3]) then
            lsSQL := lsSQL + ' and ( (B_CASA1_MENOR = '''+lsArcMen1Oposto+''' and B_CASA1_NAIPE = '''+lsNaipe1Oposto+''') or '+
                     '       (B_CASA1_NAIPE = '''+lsNaipe1Oposto+''') )';

         if not (cklbCasaB1.Checked[2]) and (cklbCasaB1.Checked[3]) then
            lsSQL := lsSQL + ' and ( (B_CASA1_MENOR = '''+lsArcMen1Oposto+''' and B_CASA1_NAIPE = '''+lsNaipe1Oposto+''') or '+
                     '       (B_CASA1_MENOR = '''+lsArcMen1Oposto+''') )';
      end
      else
      begin
         if (cklbCasaB1.Checked[2]) and (cklbCasaB1.Checked[3]) then
            lsSQL := lsSQL + ' and (B_CASA1_MENOR = '''+lsArcMen1Oposto+''' or B_CASA1_NAIPE = '''+lsNaipe1Oposto+''') ';

         if (cklbCasaB1.Checked[2]) and not (cklbCasaB1.Checked[3]) then
            lsSQL := lsSQL + ' and B_CASA1_NAIPE = '''+lsNaipe1Oposto+'''';

         if not(cklbCasaB1.Checked[2]) and (cklbCasaB1.Checked[3]) then
            lsSQL := lsSQL + ' and B_CASA1_MENOR = '''+lsArcMen1Oposto+'''';
      end;

      //TIME B CASA 2
      if (cklbCasaB2.Checked[0]) then
         lsSQL := lsSQL + ' and B_CASA2_MAIOR = '''+lsArcMai2Oposto+'''';

      if (cklbCasaB2.Checked[1]) then
      begin
         if not (cklbCasaB2.Checked[2]) and not (cklbCasaB2.Checked[3]) then
            lsSQL := lsSQL + ' and (B_CASA2_MENOR = '''+lsArcMen2Oposto+''' and B_CASA2_NAIPE = '''+lsNaipe2Oposto+''') ';

         if (cklbCasaB2.Checked[2]) and not (cklbCasaB2.Checked[3]) then
            lsSQL := lsSQL + ' and ( (B_CASA2_MENOR = '''+lsArcMen2Oposto+''' and B_CASA2_NAIPE = '''+lsNaipe2Oposto+''') or '+
                     '       (B_CASA2_NAIPE = '''+lsNaipe2Oposto+''') )';

         if not (cklbCasaB2.Checked[2]) and (cklbCasaB2.Checked[3]) then
            lsSQL := lsSQL + ' and ( (B_CASA2_MENOR = '''+lsArcMen2Oposto+''' and B_CASA2_NAIPE = '''+lsNaipe2Oposto+''') or '+
                     '       (B_CASA2_MENOR = '''+lsArcMen2Oposto+''') )';
      end
      else
      begin
         if (cklbCasaB2.Checked[2]) and (cklbCasaB2.Checked[3]) then
            lsSQL := lsSQL + ' and (B_CASA2_MENOR = '''+lsArcMen2Oposto+''' or B_CASA2_NAIPE = '''+lsNaipe2Oposto+''') ';

         if (cklbCasaB2.Checked[2]) and not (cklbCasaB2.Checked[3]) then
            lsSQL := lsSQL + ' and B_CASA2_NAIPE = '''+lsNaipe2Oposto+'''';

         if not(cklbCasaB2.Checked[2]) and (cklbCasaB2.Checked[3]) then
            lsSQL := lsSQL + ' and B_CASA2_MENOR = '''+lsArcMen2Oposto+'''';
      end;

      //TIME B CASA 3
      if (cklbCasaB3.Checked[0]) then
         lsSQL := lsSQL + ' and B_CASA3_MAIOR = '''+lsArcMai3Oposto+'''';

      if (cklbCasaB3.Checked[1]) then
      begin
         if not (cklbCasaB3.Checked[2]) and not (cklbCasaB3.Checked[3]) then
            lsSQL := lsSQL + ' and (B_CASA3_MENOR = '''+lsArcMen3Oposto+''' and B_CASA3_NAIPE = '''+lsNaipe3Oposto+''') ';

         if (cklbCasaB3.Checked[2]) and not (cklbCasaB3.Checked[3]) then
            lsSQL := lsSQL + ' and ( (B_CASA3_MENOR = '''+lsArcMen3Oposto+''' and B_CASA3_NAIPE = '''+lsNaipe3Oposto+''') or '+
                     '       (B_CASA3_NAIPE = '''+lsNaipe3Oposto+''') )';

         if not (cklbCasaB3.Checked[2]) and (cklbCasaB3.Checked[3]) then
            lsSQL := lsSQL + ' and ( (B_CASA3_MENOR = '''+lsArcMen3Oposto+''' and B_CASA3_NAIPE = '''+lsNaipe3Oposto+''') or '+
                     '       (B_CASA3_MENOR = '''+lsArcMen3Oposto+''') )';
      end
      else
      begin
         if (cklbCasaB3.Checked[2]) and (cklbCasaB3.Checked[3]) then
            lsSQL := lsSQL + ' and (B_CASA3_MENOR = '''+lsArcMen3Oposto+''' or B_CASA3_NAIPE = '''+lsNaipe3Oposto+''') ';

         if (cklbCasaB3.Checked[2]) and not (cklbCasaB3.Checked[3]) then
            lsSQL := lsSQL + ' and B_CASA3_NAIPE = '''+lsNaipe3Oposto+'''';

         if not(cklbCasaB3.Checked[2]) and (cklbCasaB3.Checked[3]) then
            lsSQL := lsSQL + ' and B_CASA3_MENOR = '''+lsArcMen3Oposto+'''';
      end;

      lsSQL := lssQL + ' UNION '+
               'select Vitoria, ''B'' as Equipe, '+
               'a1MA.Descricao as A1MAIOR, a1ME.Descricao as A1MENOR, '+
               'a2MA.Descricao as A2MAIOR, a2ME.Descricao as A2MENOR, '+
               'a3MA.Descricao as A3MAIOR, a3ME.Descricao as A3MENOR, '+
               'b1MA.Descricao as B1MAIOR, b1ME.Descricao as B1MENOR, '+
               'b2MA.Descricao as B2MAIOR, b2ME.Descricao as B2MENOR, '+
               'b3MA.Descricao as B3MAIOR, b3ME.Descricao as B3MENOR '+
               'from LOTECA '+
               'join ARCANOS_MAIORES a1MA on(a1MA.Codigo = A_CASA1_MAIOR) '+
               'join ARCANOS_MENORES a1ME on(a1ME.Numero = A_CASA1_MENOR and a1ME.Naipe = A_CASA1_NAIPE) '+
               'join ARCANOS_MAIORES a2MA on(a2MA.Codigo = A_CASA2_MAIOR) '+
               'join ARCANOS_MENORES a2ME on(a2ME.Numero = A_CASA2_MENOR and a2ME.Naipe = A_CASA2_NAIPE) '+
               'join ARCANOS_MAIORES a3MA on(a3MA.Codigo = A_CASA3_MAIOR) '+
               'join ARCANOS_MENORES a3ME on(a3ME.Numero = A_CASA3_MENOR and a3ME.Naipe = A_CASA3_NAIPE) '+
               'join ARCANOS_MAIORES b1MA on(b1MA.Codigo = B_CASA1_MAIOR) '+
               'join ARCANOS_MAIORES b2MA on(b2MA.Codigo = B_CASA2_MAIOR) '+
               'join ARCANOS_MAIORES b3MA on(b3MA.Codigo = B_CASA3_MAIOR) '+
               'join ARCANOS_MENORES b1ME on(b1ME.Numero = B_CASA1_MENOR and b1ME.Naipe = B_CASA1_NAIPE) '+
               'join ARCANOS_MENORES b2ME on(b2ME.Numero = B_CASA2_MENOR and b2ME.Naipe = B_CASA2_NAIPE) '+
               'join ARCANOS_MENORES b3ME on(b3ME.Numero = B_CASA3_MENOR and b3ME.Naipe = B_CASA3_NAIPE) '+
               'WHERE Vitoria is not null ';

      //TIME B CASA 1
      if (cklbCasaB1.Checked[0]) then
         lsSQL := lsSQL + ' and B_CASA1_MAIOR = '''+lsArcMai1Filtro+'''';

      if (cklbCasaB1.Checked[1]) then
      begin
         if not (cklbCasaB1.Checked[2]) and not (cklbCasaB1.Checked[3]) then
            lsSQL := lsSQL + ' and (B_CASA1_MENOR = '''+lsArcMen1Filtro+''' and B_CASA1_NAIPE = '''+lsNaipe1Filtro+''') ';

         if (cklbCasaB1.Checked[2]) and not (cklbCasaB1.Checked[3]) then
            lsSQL := lsSQL + ' and ( (B_CASA1_MENOR = '''+lsArcMen1Filtro+''' and B_CASA1_NAIPE = '''+lsNaipe1Filtro+''') or '+
                     '       (B_CASA1_NAIPE = '''+lsNaipe1Filtro+''') )';
         if not (cklbCasaB1.Checked[2]) and (cklbCasaB1.Checked[3]) then
            lsSQL := lsSQL + ' and ( (B_CASA1_MENOR = '''+lsArcMen1Filtro+''' and B_CASA1_NAIPE = '''+lsNaipe1Filtro+''') or '+
                     '       (B_CASA1_MENOR = '''+lsArcMen1Filtro+''') )';
      end
      else
      begin
         if (cklbCasaB1.Checked[2]) and (cklbCasaB1.Checked[3]) then
            lsSQL := lsSQL + ' and (B_CASA1_MENOR = '''+lsArcMen1Filtro+''' or B_CASA1_NAIPE = '''+lsNaipe1Filtro+''') ';

         if (cklbCasaB1.Checked[2]) and not (cklbCasaB1.Checked[3]) then
            lsSQL := lsSQL + ' and B_CASA1_NAIPE = '''+lsNaipe1Filtro+'''';

         if not(cklbCasaB1.Checked[2]) and (cklbCasaB1.Checked[3]) then
            lsSQL := lsSQL + ' and B_CASA1_MENOR = '''+lsArcMen1Filtro+'''';
      end;

      //TIME A CASA 2
      if (cklbCasaB2.Checked[0]) then
         lsSQL := lsSQL + ' and B_CASA2_MAIOR = '''+lsArcMai2Filtro+'''';

      if (cklbCasaB2.Checked[1]) then
      begin
         if not (cklbCasaB2.Checked[2]) and not (cklbCasaB2.Checked[3]) then
            lsSQL := lsSQL + ' and (B_CASA2_MENOR = '''+lsArcMen2Filtro+''' and B_CASA2_NAIPE = '''+lsNaipe2Filtro+''') ';

         if (cklbCasaB2.Checked[2]) and not (cklbCasaB2.Checked[3]) then
            lsSQL := lsSQL + ' and ( (B_CASA2_MENOR = '''+lsArcMen2Filtro+''' and B_CASA2_NAIPE = '''+lsNaipe2Filtro+''') or '+
                     '       (B_CASA2_NAIPE = '''+lsNaipe2Filtro+''') )';
         if not (cklbCasaB2.Checked[2]) and (cklbCasaB2.Checked[3]) then
            lsSQL := lsSQL + ' and ( (B_CASA2_MENOR = '''+lsArcMen2Filtro+''' and B_CASA2_NAIPE = '''+lsNaipe2Filtro+''') or '+
                     '       (B_CASA2_MENOR = '''+lsArcMen2Filtro+''') )';
      end
      else
      begin
         if (cklbCasaB2.Checked[2]) and (cklbCasaB2.Checked[3]) then
            lsSQL := lsSQL + ' and (B_CASA2_MENOR = '''+lsArcMen2Filtro+''' or B_CASA2_NAIPE = '''+lsNaipe2Filtro+''') ';

         if (cklbCasaB2.Checked[2]) and not (cklbCasaB2.Checked[3]) then
         begin
            lsSQL := lsSQL + ' and B_CASA2_NAIPE = '''+lsNaipe2Filtro+'''';
            Query.ParamByName('Naipe2Filtro').AsString := lsNaipe2Filtro;
         end;

         if not(cklbCasaB2.Checked[2]) and (cklbCasaB2.Checked[3]) then
            lsSQL := lsSQL + ' and B_CASA2_MENOR = '''+lsArcMen2Filtro+'''';
      end;

      //TIME B CASA 3
      if (cklbCasaB3.Checked[0]) then
         lsSQL := lsSQL + ' and B_CASA3_MAIOR = '''+lsArcMai3Filtro+'''';

      if (cklbCasaB3.Checked[1]) then
      begin
         if not (cklbCasaB3.Checked[2]) and not (cklbCasaB3.Checked[3]) then
            lsSQL := lsSQL + ' and (B_CASA3_MENOR = '''+lsArcMen3Filtro+''' and B_CASA3_NAIPE = '''+lsNaipe3Filtro+''') ';

         if (cklbCasaB3.Checked[2]) and not (cklbCasaB3.Checked[3]) then
            lsSQL := lsSQL + ' and ( (B_CASA3_MENOR = '''+lsArcMen3Filtro+''' and B_CASA3_NAIPE = '''+lsNaipe3Filtro+''') or '+
                     '       (B_CASA3_NAIPE = '''+lsNaipe3Filtro+''') )';

         if not (cklbCasaB3.Checked[2]) and (cklbCasaB3.Checked[3]) then
            lsSQL := lsSQL + ' and ( (B_CASA3_MENOR = '''+lsArcMen3Filtro+''' and B_CASA3_NAIPE = '''+lsNaipe3Filtro+''') or '+
                     '       (B_CASA3_MENOR = '''+lsArcMen3Filtro+''') )';
      end
      else
      begin
         if (cklbCasaB3.Checked[2]) and (cklbCasaB3.Checked[3]) then
            lsSQL := lsSQL + ' and (B_CASA3_MENOR = '''+lsArcMen3Filtro+''' or B_CASA3_NAIPE = '''+lsNaipe3Filtro+''') ';

         if (cklbCasaB3.Checked[2]) and not (cklbCasaB3.Checked[3]) then
            lsSQL := lsSQL + ' and B_CASA3_NAIPE = '''+lsNaipe3Filtro+'''';

         if not(cklbCasaB3.Checked[2]) and (cklbCasaB3.Checked[3]) then
            lsSQL := lsSQL + ' and B_CASA3_MENOR = '''+lsArcMen3Filtro+'''';
      end;

      //TIME A CASA 1
      if (cklbCasaA1.Checked[0]) then
         lsSQL := lsSQL + ' and A_CASA1_MAIOR = '''+lsArcMai1Oposto+'''';

      if (cklbCasaA1.Checked[1]) then
      begin
         if not (cklbCasaA1.Checked[2]) and not (cklbCasaA1.Checked[3]) then
            lsSQL := lsSQL + ' and (A_CASA1_MENOR = '''+lsArcMen1Oposto+''' and A_CASA1_NAIPE = '''+lsNaipe1Oposto+''') ';

         if (cklbCasaA1.Checked[2]) and not (cklbCasaA1.Checked[3]) then
            lsSQL := lsSQL + ' and ( (A_CASA1_MENOR = '''+lsArcMen1Oposto+''' and A_CASA1_NAIPE = '''+lsNaipe1Oposto+''') or '+
                     '       (A_CASA1_NAIPE = '''+lsNaipe1Oposto+''') )';

         if not (cklbCasaA1.Checked[2]) and (cklbCasaA1.Checked[3]) then
            lsSQL := lsSQL + ' and ( (A_CASA1_MENOR = '''+lsArcMen1Oposto+''' and A_CASA1_NAIPE = '''+lsNaipe1Oposto+''') or '+
                     '       (A_CASA1_MENOR = '''+lsArcMen1Oposto+''') )';
      end
      else
      begin
         if (cklbCasaA1.Checked[2]) and (cklbCasaA1.Checked[3]) then
            lsSQL := lsSQL + ' and (A_CASA1_MENOR = '''+lsArcMen1Oposto+''' or A_CASA1_NAIPE = '''+lsNaipe1Oposto+''') ';

         if (cklbCasaA1.Checked[2]) and not (cklbCasaA1.Checked[3]) then
            lsSQL := lsSQL + ' and A_CASA1_NAIPE = '''+lsNaipe1Oposto+'''';

         if not(cklbCasaA1.Checked[2]) and (cklbCasaA1.Checked[3]) then
            lsSQL := lsSQL + ' and A_CASA1_MENOR = '''+lsArcMen1Oposto+'''';
      end;

      //TIME A CASA 2
      if (cklbCasaA2.Checked[0]) then
         lsSQL := lsSQL + ' and A_CASA2_MAIOR = '''+lsArcMai2Oposto+'''';

      if (cklbCasaA2.Checked[1]) then
      begin
         if not (cklbCasaA2.Checked[2]) and not (cklbCasaA2.Checked[3]) then
            lsSQL := lsSQL + ' and (A_CASA2_MENOR = '''+lsArcMen2Oposto+''' and A_CASA2_NAIPE = '''+lsNaipe2Oposto+''') ';

         if (cklbCasaA2.Checked[2]) and not (cklbCasaA2.Checked[3]) then
            lsSQL := lsSQL + ' and ( (A_CASA2_MENOR = '''+lsArcMen2Oposto+''' and A_CASA2_NAIPE = '''+lsNaipe2Oposto+''') or '+
                     '       (A_CASA2_NAIPE = '''+lsNaipe2Oposto+''') )';

         if not (cklbCasaA2.Checked[2]) and (cklbCasaA2.Checked[3]) then
            lsSQL := lsSQL + ' and ( (A_CASA2_MENOR = '''+lsArcMen2Oposto+''' and A_CASA2_NAIPE = '''+lsNaipe2Oposto+''') or '+
                     '       (A_CASA2_MENOR = '''+lsArcMen2Oposto+''') )';
      end
      else
      begin
         if (cklbCasaA2.Checked[2]) and (cklbCasaA2.Checked[3]) then
            lsSQL := lsSQL + ' and (A_CASA2_MENOR = '''+lsArcMen2Oposto+''' or A_CASA2_NAIPE = '''+lsNaipe2Oposto+''') ';

         if (cklbCasaA2.Checked[2]) and not (cklbCasaA2.Checked[3]) then
            lsSQL := lsSQL + ' and A_CASA2_NAIPE = '''+lsNaipe2Oposto+'''';

         if not(cklbCasaA2.Checked[2]) and (cklbCasaA2.Checked[3]) then
            lsSQL := lsSQL + ' and A_CASA2_MENOR = '''+lsArcMen2Oposto+'''';
      end;

      //TIME A CASA 3
      if (cklbCasaA3.Checked[0]) then
         lsSQL := lsSQL + ' and A_CASA3_MAIOR = '''+lsArcMai3Oposto+'''';

      if (cklbCasaA3.Checked[1]) then
      begin
         if not (cklbCasaA3.Checked[2]) and not (cklbCasaA3.Checked[3]) then
            lsSQL := lsSQL + ' and (A_CASA3_MENOR = '''+lsArcMen3Oposto+''' and A_CASA3_NAIPE = '''+lsNaipe3Oposto+''') ';

         if (cklbCasaA3.Checked[2]) and not (cklbCasaA3.Checked[3]) then
            lsSQL := lsSQL + ' and ( (A_CASA3_MENOR = '''+lsArcMen3Oposto+''' and A_CASA3_NAIPE = '''+lsNaipe3Oposto+''') or '+
                     '       (A_CASA3_NAIPE = '''+lsNaipe3Oposto+''') )';

         if not (cklbCasaA3.Checked[2]) and (cklbCasaA3.Checked[3]) then
            lsSQL := lsSQL + ' and ( (A_CASA3_MENOR = '''+lsArcMen3Oposto+''' and A_CASA3_NAIPE = '''+lsNaipe3Oposto+''') or '+
                  '       (A_CASA3_MENOR = '''+lsArcMen3Oposto+''') )';
      end
      else
      begin
         if (cklbCasaA3.Checked[2]) and (cklbCasaA3.Checked[3]) then
            lsSQL := lsSQL + ' and (A_CASA3_MENOR = '''+lsArcMen3Oposto+''' or A_CASA3_NAIPE = '''+lsNaipe3Oposto+''') ';

         if (cklbCasaA3.Checked[2]) and not (cklbCasaA3.Checked[3]) then
            lsSQL := lsSQL + ' and A_CASA3_NAIPE = '''+lsNaipe3Oposto+'''';

         if not(cklbCasaA3.Checked[2]) and (cklbCasaA3.Checked[3]) then
            lsSQL := lsSQL + ' and A_CASA3_MENOR = '''+lsArcMen3Oposto+'''';
      end;

      lsSQL := lsSQL + 'Order by VITORIA, Equipe ';

      Query.SQL.Add(lsSQL);
      Query.Open;
   except
      Screen.Cursor := crDefault;
      Query.Close;
      MessageDlg('Erro consulta '+#13+#10+lsSQL, mtError,[mbOk],0);
      Exit;
   end;

   lbPrivez := True;
   if not(Query.bof and Query.Eof) then
   begin
      //agora preenche o StringGrid
      while not Query.Eof do
      begin
         if (lbPrivez) then
         begin
            //coloca o cabeçalho com os dados de cada jogo
            PreencherNiceGrid(NiceGrid1,FDQHeader, True);
            PreencherStringGrid(FDQHeader,Query, StringGrid1, True);
            lbPrivez := False;
         end;
         PreencherNiceGrid(NiceGrid1, Query, False);
         //Preenche o StringGrid que define quais campos serão pintados
         PreencherStringGrid(FDQHeader, Query, StringGrid1, False);
         Query.Next;
      end;

(*      try
         //contabiliza vitórias, derrotas e empates
         QueryCount.Close;
               QueryCount.ParamByName('ArcMai1Filtro').AsString := lsArcMai1Filtro;
               QueryCount.ParamByName('ArcMai2Filtro').AsString := lsArcMai2Filtro;
               QueryCount.ParamByName('ArcMai3Filtro').AsString := lsArcMai3Filtro;
               QueryCount.ParamByName('ArcMen1Filtro').AsString := lsArcMen1Filtro;
               QueryCount.ParamByName('ArcMen2Filtro').AsString := lsArcMen2Filtro;
               QueryCount.ParamByName('ArcMen3Filtro').AsString := lsArcMen3Filtro;
               QueryCount.ParamByName('Naipe1Filtro').AsString := lsNaipe1Filtro;
               QueryCount.ParamByName('Naipe2Filtro').AsString := lsNaipe2Filtro;
               QueryCount.ParamByName('Naipe3Filtro').AsString := lsNaipe3Filtro;
               QueryCount.ParamByName('ArcMai1Oposto').AsString := lsArcMai1Oposto;
               QueryCount.ParamByName('ArcMai2Oposto').AsString := lsArcMai2Oposto;
               QueryCount.ParamByName('ArcMai3Oposto').AsString := lsArcMai3Oposto;
               QueryCount.ParamByName('ArcMen1Oposto').AsString := lsArcMen1Oposto;
               QueryCount.ParamByName('ArcMen2Oposto').AsString := lsArcMen2Oposto;
               QueryCount.ParamByName('ArcMen3Oposto').AsString := lsArcMen3Oposto;
               QueryCount.ParamByName('Naipe1Oposto').AsString := lsNaipe1Oposto;
               QueryCount.ParamByName('Naipe2Oposto').AsString := lsNaipe2Oposto;
               QueryCount.ParamByName('Naipe3Oposto').AsString := lsNaipe3Oposto;
         QueryCount.Open;

         //efetua as estatísticas
         while not QueryCount.Eof do
         begin
            if (Trim(QueryCount.FieldByName('Vitoria').AsString) <> '') then
            begin
               case QueryCount.FieldByName('Equipe').AsString[1] of
                  'A': //significa que o time A é quem tem as cartas escolhidas
                  begin
                        case QueryCount.FieldByName('Vitoria').AsString[1] of
                           'A': gTotais.QtdVitoria := gTotais.QtdVitoria + QueryCount.FieldByName('QTD').AsInteger; //time com as cartas venceu
                           'B': gTotais.QtdDerrota := gTotais.QtdDerrota + QueryCount.FieldByName('QTD').AsInteger; //time com as cartas perdeu
                           'E': gTotais.QtdEmpate  := gTotais.QtdEmpate  + QueryCount.FieldByName('QTD').AsInteger; //time com as cartas empatou
                        end; //case
                  end;
                  'B': //significa que o time B é quem tem as cartas escolhidas
                  begin
                     case QueryCount.FieldByName('Vitoria').AsString[1] of
                        'A': gTotais.QtdDerrota := gTotais.QtdDerrota + QueryCount.FieldByName('QTD').AsInteger; //time com as cartas perdeu
                        'B': gTotais.QtdVitoria := gTotais.QtdVitoria + QueryCount.FieldByName('QTD').AsInteger; //time com as cartas venceu
                        'E': gTotais.QtdEmpate  := gTotais.QtdEmpate  + QueryCount.FieldByName('QTD').AsInteger; //time com as cartas empatou
                     end; //case
                  end;
               end; //case
               gTotais.QtdTotal := gTotais.QtdTotal + QueryCount.FieldByName('QTD').AsInteger;
            end;
            QueryCount.Next;
         end;
      except
         Screen.Cursor := crDefault;
         QueryCount.Close;
         MessageDlg('Erro consulta Padrão 01 (totais).'+#13+#10+lsSQL, mtError,[mbOk],0);
         Exit;
      end;
      *)
   end;
   Query.Close;
   QueryCount.Close;
end;

procedure TFAnalisePadroes.PreencherNiceGrid(NiceGrid: TNiceGrid; Query: TFDQuery; bHeader: Boolean);
begin
   with NiceGrid do
   begin
      RowCount := RowCount + 1;
      if (bHeader) then
      begin
         Cells[00,RowCount-1] := Query.FieldByName('Vitoria').AsString;
         Cells[01,RowCount-1] := Copy(Query.FieldByName('A1MAIOR').AsString,6,Length(Query.FieldByName('A1MAIOR').AsString));
         Cells[02,RowCount-1] := Query.FieldByName('A1MENOR').AsString;
         Cells[03,RowCount-1] := Copy(Query.FieldByName('A2MAIOR').AsString,6,Length(Query.FieldByName('A2MAIOR').AsString));
         Cells[04,RowCount-1] := Query.FieldByName('A2MENOR').AsString;
         Cells[05,RowCount-1] := Copy(Query.FieldByName('A3MAIOR').AsString,6,Length(Query.FieldByName('A3MAIOR').AsString));
         Cells[06,RowCount-1] := Query.FieldByName('A3MENOR').AsString;
         Cells[07,RowCount-1] := Copy(Query.FieldByName('B1MAIOR').AsString,6,Length(Query.FieldByName('B1MAIOR').AsString));
         Cells[08,RowCount-1] := Query.FieldByName('B1MENOR').AsString;
         Cells[09,RowCount-1] := Copy(Query.FieldByName('B2MAIOR').AsString,6,Length(Query.FieldByName('B2MAIOR').AsString));
         Cells[10,RowCount-1] := Query.FieldByName('B2MENOR').AsString;
         Cells[11,RowCount-1] := Copy(Query.FieldByName('B3MAIOR').AsString,6,Length(Query.FieldByName('B3MAIOR').AsString));
         Cells[12,RowCount-1] := Query.FieldByName('B3MENOR').AsString;
         Cells[13,RowCount-1] := Query.FieldByName('Equipe').AsString;
      end
      else
      begin
         case RadioGroupTime.ItemIndex of
            0: //time A selecionado
            begin
               //significa que vamos analisar pelos arcanos do time A e que encontramos padrão em um time A,
               //ou seja, fica tudo do lado certo esquerdo e direito
               if (Query.FieldByName('Equipe').AsString = 'A') then
               begin
                  Cells[00,RowCount-1] := Query.FieldByName('Vitoria').AsString;
                  Cells[01,RowCount-1] := Copy(Query.FieldByName('A1MAIOR').AsString,6,Length(Query.FieldByName('A1MAIOR').AsString));
                  Cells[02,RowCount-1] := Query.FieldByName('A1MENOR').AsString;
                  Cells[03,RowCount-1] := Copy(Query.FieldByName('A2MAIOR').AsString,6,Length(Query.FieldByName('A2MAIOR').AsString));
                  Cells[04,RowCount-1] := Query.FieldByName('A2MENOR').AsString;
                  Cells[05,RowCount-1] := Copy(Query.FieldByName('A3MAIOR').AsString,6,Length(Query.FieldByName('A3MAIOR').AsString));
                  Cells[06,RowCount-1] := Query.FieldByName('A3MENOR').AsString;
                  Cells[07,RowCount-1] := Copy(Query.FieldByName('B1MAIOR').AsString,6,Length(Query.FieldByName('B1MAIOR').AsString));
                  Cells[08,RowCount-1] := Query.FieldByName('B1MENOR').AsString;
                  Cells[09,RowCount-1] := Copy(Query.FieldByName('B2MAIOR').AsString,6,Length(Query.FieldByName('B2MAIOR').AsString));
                  Cells[10,RowCount-1] := Query.FieldByName('B2MENOR').AsString;
                  Cells[11,RowCount-1] := Copy(Query.FieldByName('B3MAIOR').AsString,6,Length(Query.FieldByName('B3MAIOR').AsString));
                  Cells[12,RowCount-1] := Query.FieldByName('B3MENOR').AsString;
                  Cells[13,RowCount-1] := Query.FieldByName('Equipe').AsString;
               end;

               //significa que vamos analisar pelos arcanos do time A e que encontramos padrão em um time B,
               //ou seja, B vai para o lado esquerdo e A para o direito e muda o time da vitória, pois mudou de lado
               if (Query.FieldByName('Equipe').AsString = 'B') then
               begin
                  if (Query.FieldByName('Vitoria').AsString = 'A') then
                     Cells[00,RowCount-1] := 'B'
                  else
                     if (Query.FieldByName('Vitoria').AsString = 'B') then
                        Cells[00,RowCount-1] := 'A'
                     else
                        if (Query.FieldByName('Vitoria').AsString = 'E') then
                           Cells[00,RowCount-1] := 'E';

                  Cells[01,RowCount-1] := Copy(Query.FieldByName('B1MAIOR').AsString,6,Length(Query.FieldByName('B1MAIOR').AsString));
                  Cells[02,RowCount-1] := Query.FieldByName('B1MENOR').AsString;
                  Cells[03,RowCount-1] := Copy(Query.FieldByName('B2MAIOR').AsString,6,Length(Query.FieldByName('B2MAIOR').AsString));
                  Cells[04,RowCount-1] := Query.FieldByName('B2MENOR').AsString;
                  Cells[05,RowCount-1] := Copy(Query.FieldByName('B3MAIOR').AsString,6,Length(Query.FieldByName('B3MAIOR').AsString));
                  Cells[06,RowCount-1] := Query.FieldByName('B3MENOR').AsString;
                  Cells[07,RowCount-1] := Copy(Query.FieldByName('A1MAIOR').AsString,6,Length(Query.FieldByName('A1MAIOR').AsString));
                  Cells[08,RowCount-1] := Query.FieldByName('A1MENOR').AsString;
                  Cells[09,RowCount-1] := Copy(Query.FieldByName('A2MAIOR').AsString,6,Length(Query.FieldByName('A2MAIOR').AsString));
                  Cells[10,RowCount-1] := Query.FieldByName('A2MENOR').AsString;
                  Cells[11,RowCount-1] := Copy(Query.FieldByName('A3MAIOR').AsString,6,Length(Query.FieldByName('A3MAIOR').AsString));
                  Cells[12,RowCount-1] := Query.FieldByName('A3MENOR').AsString;
                  Cells[13,RowCount-1] := Query.FieldByName('Equipe').AsString;
               end;
            end;
            1: //time B selecionado
            begin
               //significa que vamos analisar pelos arcanos do time B e que encontramos padrão em um time A,
               //ou seja, fica tudo do lado contrário
               if (Query.FieldByName('Equipe').AsString = 'A') then
               begin
                  if (Query.FieldByName('Vitoria').AsString = 'A') then
                     Cells[00,RowCount-1] := 'B'
                  else
                     if (Query.FieldByName('Vitoria').AsString = 'B') then
                        Cells[00,RowCount-1] := 'A'
                     else
                        if (Query.FieldByName('Vitoria').AsString = 'E') then
                           Cells[00,RowCount-1] := 'E';

                  Cells[01,RowCount-1] := Copy(Query.FieldByName('B1MAIOR').AsString,6,Length(Query.FieldByName('B1MAIOR').AsString));
                  Cells[02,RowCount-1] := Query.FieldByName('B1MENOR').AsString;
                  Cells[03,RowCount-1] := Copy(Query.FieldByName('B2MAIOR').AsString,6,Length(Query.FieldByName('B2MAIOR').AsString));
                  Cells[04,RowCount-1] := Query.FieldByName('B2MENOR').AsString;
                  Cells[05,RowCount-1] := Copy(Query.FieldByName('B3MAIOR').AsString,6,Length(Query.FieldByName('B3MAIOR').AsString));
                  Cells[06,RowCount-1] := Query.FieldByName('B3MENOR').AsString;
                  Cells[07,RowCount-1] := Copy(Query.FieldByName('A1MAIOR').AsString,6,Length(Query.FieldByName('A1MAIOR').AsString));
                  Cells[08,RowCount-1] := Query.FieldByName('A1MENOR').AsString;
                  Cells[09,RowCount-1] := Copy(Query.FieldByName('A2MAIOR').AsString,6,Length(Query.FieldByName('A2MAIOR').AsString));
                  Cells[10,RowCount-1] := Query.FieldByName('A2MENOR').AsString;
                  Cells[11,RowCount-1] := Copy(Query.FieldByName('A3MAIOR').AsString,6,Length(Query.FieldByName('A3MAIOR').AsString));
                  Cells[12,RowCount-1] := Query.FieldByName('A3MENOR').AsString;
                  Cells[13,RowCount-1] := Query.FieldByName('Equipe').AsString;
               end;

               //significa que vamos analisar pelos arcanos do time B e que encontramos padrão em um time B,
               //ou seja, fica tudo do lado certo esquerdo e direito
               if (Query.FieldByName('Equipe').AsString = 'B') then
               begin
                  Cells[00,RowCount-1] := Query.FieldByName('Vitoria').AsString;
                  Cells[01,RowCount-1] := Copy(Query.FieldByName('A1MAIOR').AsString,6,Length(Query.FieldByName('A1MAIOR').AsString));
                  Cells[02,RowCount-1] := Query.FieldByName('A1MENOR').AsString;
                  Cells[03,RowCount-1] := Copy(Query.FieldByName('A2MAIOR').AsString,6,Length(Query.FieldByName('A2MAIOR').AsString));
                  Cells[04,RowCount-1] := Query.FieldByName('A2MENOR').AsString;
                  Cells[05,RowCount-1] := Copy(Query.FieldByName('A3MAIOR').AsString,6,Length(Query.FieldByName('A3MAIOR').AsString));
                  Cells[06,RowCount-1] := Query.FieldByName('A3MENOR').AsString;
                  Cells[07,RowCount-1] := Copy(Query.FieldByName('B1MAIOR').AsString,6,Length(Query.FieldByName('B1MAIOR').AsString));
                  Cells[08,RowCount-1] := Query.FieldByName('B1MENOR').AsString;
                  Cells[09,RowCount-1] := Copy(Query.FieldByName('B2MAIOR').AsString,6,Length(Query.FieldByName('B2MAIOR').AsString));
                  Cells[10,RowCount-1] := Query.FieldByName('B2MENOR').AsString;
                  Cells[11,RowCount-1] := Copy(Query.FieldByName('B3MAIOR').AsString,6,Length(Query.FieldByName('B3MAIOR').AsString));
                  Cells[12,RowCount-1] := Query.FieldByName('B3MENOR').AsString;
                  Cells[13,RowCount-1] := Query.FieldByName('Equipe').AsString;
               end;
            end;
         end; //case
      end;
   end;
end;

procedure TFAnalisePadroes.PreencherStringGrid(QueryHeader: TFDQuery; QueryDetail: TFDQuery; Grid: TStringGrid; bHeader: Boolean);
var lsNaipeD, lsNaipeH, lsNumD, lsNumH: string;
begin
   with Grid do
   begin
      if not((RowCount = 1) and (Cells[0,0] = '')) then
         RowCount := RowCount + 1;

      if (bHeader) then //cabeçalho
      begin
         Cells[00,RowCount-1] := 'G'; // color Gray
         Cells[01,RowCount-1] := 'G'; // color Gray
         Cells[02,RowCount-1] := 'G'; // color Gray
         Cells[03,RowCount-1] := 'G'; // color Gray
         Cells[04,RowCount-1] := 'G'; // color Gray
         Cells[05,RowCount-1] := 'G'; // color Gray
         Cells[06,RowCount-1] := 'G'; // color Gray
         Cells[07,RowCount-1] := 'G'; // color Gray
         Cells[08,RowCount-1] := 'G'; // color Gray
         Cells[09,RowCount-1] := 'G'; // color Gray
         Cells[10,RowCount-1] := 'G'; // color Gray
         Cells[11,RowCount-1] := 'G'; // color Gray
         Cells[12,RowCount-1] := 'G'; // color Gray
         Cells[13,RowCount-1] := 'G'; // color Gray
      end
      else
      begin
         Cells[00,RowCount-1] := QueryDetail.FieldByName('Equipe').AsString;

         case RadioGroupTime.ItemIndex of
            0: //time A selecionado
            begin
               //pesquisa pelos arcanos do Time A e o filtro veio pelo time A
               //A do lado esquerdo e B do lado direito
               if (Cells[00,RowCount-1] = 'A') then
               begin
                  if (QueryDetail.FieldByName('A1MAIOR').AsString = QueryHeader.FieldByName('A1MAIOR').AsString) then
                     Cells[01,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('A1MENOR').AsString = QueryHeader.FieldByName('A1MENOR').AsString) then
                     Cells[02,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('A1MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('A1MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('A1MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('A1MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[02,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('A2MAIOR').AsString = QueryHeader.FieldByName('A2MAIOR').AsString) then
                     Cells[03,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('A2MENOR').AsString = QueryHeader.FieldByName('A2MENOR').AsString) then
                     Cells[04,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('A2MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('A2MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('A2MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('A2MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[04,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('A3MAIOR').AsString = QueryHeader.FieldByName('A3MAIOR').AsString) then
                     Cells[05,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('A3MENOR').AsString = QueryHeader.FieldByName('A3MENOR').AsString) then
                     Cells[06,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('A3MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('A3MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('A3MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('A3MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[06,RowCount-1] := 'B'
                  end;


                  //time B
                  if (QueryDetail.FieldByName('B1MAIOR').AsString = QueryHeader.FieldByName('B1MAIOR').AsString) then
                     Cells[07,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('B1MENOR').AsString = QueryHeader.FieldByName('B1MENOR').AsString) then
                     Cells[08,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('B1MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('B1MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('B1MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('B1MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[08,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('B2MAIOR').AsString = QueryHeader.FieldByName('B2MAIOR').AsString) then
                     Cells[09,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('B2MENOR').AsString = QueryHeader.FieldByName('B2MENOR').AsString) then
                     Cells[10,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('B2MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('B2MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('B2MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('B2MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[10,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('B3MAIOR').AsString = QueryHeader.FieldByName('B3MAIOR').AsString) then
                     Cells[11,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('B3MENOR').AsString = QueryHeader.FieldByName('B3MENOR').AsString) then
                     Cells[12,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('B3MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('B3MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('B3MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('B3MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[12,RowCount-1] := 'B'
                  end;
               end
               else
               begin
                  //pesquisa pelos arcanos do Time A e o filtro veio pelo time B
                  //B está do lado esquerdo e A está do lado direito
                  //compara o cabeçalho do time B com o filtro de A e vice versa

                  //time B
                  if (QueryDetail.FieldByName('B1MAIOR').AsString = QueryHeader.FieldByName('A1MAIOR').AsString) then
                     Cells[01,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('B1MENOR').AsString = QueryHeader.FieldByName('A1MENOR').AsString) then
                     Cells[02,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('B1MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('A1MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('B1MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('A1MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[02,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('B2MAIOR').AsString = QueryHeader.FieldByName('A2MAIOR').AsString) then
                     Cells[03,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('B2MENOR').AsString = QueryHeader.FieldByName('A2MENOR').AsString) then
                     Cells[04,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('B2MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('A2MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('B2MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('A2MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[04,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('B3MAIOR').AsString = QueryHeader.FieldByName('A3MAIOR').AsString) then
                     Cells[05,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('B3MENOR').AsString = QueryHeader.FieldByName('A3MENOR').AsString) then
                     Cells[06,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('B3MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('A3MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('B3MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('A3MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[06,RowCount-1] := 'B'
                  end;

                  //time A
                  if (QueryDetail.FieldByName('A1MAIOR').AsString = QueryHeader.FieldByName('B1MAIOR').AsString) then
                     Cells[07,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('A1MENOR').AsString = QueryHeader.FieldByName('B1MENOR').AsString) then
                     Cells[08,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('A1MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('B1MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('A1MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('B1MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[08,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('A2MAIOR').AsString = QueryHeader.FieldByName('B2MAIOR').AsString) then
                     Cells[09,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('A2MENOR').AsString = QueryHeader.FieldByName('B2MENOR').AsString) then
                     Cells[10,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('A2MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('B2MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('A2MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('B2MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[10,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('A3MAIOR').AsString = QueryHeader.FieldByName('B3MAIOR').AsString) then
                     Cells[11,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('A3MENOR').AsString = QueryHeader.FieldByName('B3MENOR').AsString) then
                     Cells[12,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('A3MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('B3MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('A3MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('B3MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[12,RowCount-1] := 'B'
                  end;

               end;
            end;
            1: //time B selecionado
            begin
               //pesquisa pelos arcanos do Time B e o filtro veio pelo time A
               //B do lado esquerdo e A do lado direito
               if (Cells[00,RowCount-1] = 'A') then
               begin
                  if (QueryDetail.FieldByName('A1MAIOR').AsString = QueryHeader.FieldByName('B1MAIOR').AsString) then
                     Cells[07,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('A1MENOR').AsString = QueryHeader.FieldByName('B1MENOR').AsString) then
                     Cells[08,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('A1MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('B1MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('A1MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('B1MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[08,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('A2MAIOR').AsString = QueryHeader.FieldByName('B2MAIOR').AsString) then
                     Cells[09,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('A2MENOR').AsString = QueryHeader.FieldByName('B2MENOR').AsString) then
                     Cells[10,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('A2MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('B2MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('A2MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('B2MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[10,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('A3MAIOR').AsString = QueryHeader.FieldByName('B3MAIOR').AsString) then
                     Cells[11,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('A3MENOR').AsString = QueryHeader.FieldByName('B3MENOR').AsString) then
                     Cells[12,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('A3MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('B3MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('A3MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('B3MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[12,RowCount-1] := 'B'
                  end;

                  //time B
                  if (QueryDetail.FieldByName('B1MAIOR').AsString = QueryHeader.FieldByName('A1MAIOR').AsString) then
                     Cells[01,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('B1MENOR').AsString = QueryHeader.FieldByName('A1MENOR').AsString) then
                     Cells[02,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('B1MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('A1MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('B1MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('A1MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[02,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('B2MAIOR').AsString = QueryHeader.FieldByName('A2MAIOR').AsString) then
                     Cells[03,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('B2MENOR').AsString = QueryHeader.FieldByName('A2MENOR').AsString) then
                     Cells[04,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('B2MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('A2MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('B2MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('A2MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[04,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('B3MAIOR').AsString = QueryHeader.FieldByName('A3MAIOR').AsString) then
                     Cells[05,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('B3MENOR').AsString = QueryHeader.FieldByName('A3MENOR').AsString) then
                     Cells[06,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('B3MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('A3MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('B3MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('A3MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[06,RowCount-1] := 'B'
                  end;
               end
               else
               begin
                  //pesquisa pelos arcanos do Time B e o filtro veio pelo time B
                  //A do lado esquerdo e B do lado direito
                  if (QueryDetail.FieldByName('A1MAIOR').AsString = QueryHeader.FieldByName('A1MAIOR').AsString) then
                     Cells[01,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('A1MENOR').AsString = QueryHeader.FieldByName('A1MENOR').AsString) then
                     Cells[02,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('A1MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('A1MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('A1MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('A1MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[02,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('A2MAIOR').AsString = QueryHeader.FieldByName('A2MAIOR').AsString) then
                     Cells[03,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('A2MENOR').AsString = QueryHeader.FieldByName('A2MENOR').AsString) then
                     Cells[04,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('A2MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('A2MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('A2MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('A2MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[04,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('A3MAIOR').AsString = QueryHeader.FieldByName('A3MAIOR').AsString) then
                     Cells[05,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('A3MENOR').AsString = QueryHeader.FieldByName('A3MENOR').AsString) then
                     Cells[06,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('A3MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('A3MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('A3MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('A3MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[06,RowCount-1] := 'B'
                  end;

                  //time B
                  if (QueryDetail.FieldByName('B1MAIOR').AsString = QueryHeader.FieldByName('B1MAIOR').AsString) then
                     Cells[07,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('B1MENOR').AsString = QueryHeader.FieldByName('B1MENOR').AsString) then
                     Cells[08,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('B1MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('B1MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('B1MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('B1MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[08,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('B2MAIOR').AsString = QueryHeader.FieldByName('B2MAIOR').AsString) then
                     Cells[09,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('B2MENOR').AsString = QueryHeader.FieldByName('B2MENOR').AsString) then
                     Cells[10,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('B2MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('B2MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('B2MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('B2MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[10,RowCount-1] := 'B'
                  end;

                  if (QueryDetail.FieldByName('B3MAIOR').AsString = QueryHeader.FieldByName('B3MAIOR').AsString) then
                     Cells[11,RowCount-1] := 'X';

                  if (QueryDetail.FieldByName('B3MENOR').AsString = QueryHeader.FieldByName('B3MENOR').AsString) then
                     Cells[12,RowCount-1] := 'X'
                  else //verificar se número ou naipe é igual
                  begin
                     lsNumD   := QueryDetail.FieldByName('B3MENOR').AsString;
                     lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
                     lsNumH   := QueryHeader.FieldByName('B3MENOR').AsString;
                     lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
                     lsNaipeD := QueryDetail.FieldByName('B3MENOR').AsString;
                     lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
                     lsNaipeH := QueryHeader.FieldByName('B3MENOR').AsString;
                     lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

                     if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                        Cells[12,RowCount-1] := 'B'
                  end;
               end;
            end;
         end;
      end;
   end;
end;

procedure TFAnalisePadroes.LimparGrids(var NiceGrid: TNiceGrid; var SGrid: TStringGrid);
var liLin, liCol: integer;
begin
   for liLin := 0 to NiceGrid.RowCount-1 do
      for liCol := 0 to NiceGrid.ColCount-1 do
         NiceGrid.Cells[liCol,liLin] := '';
   NiceGrid.RowCount := 0;

   for liLin := 0 to SGrid.RowCount-1 do
      for liCol := 0 to SGrid.ColCount-1 do
         SGrid.Cells[liCol,liLin] := '';
   SGrid.RowCount := 1;
end;

procedure TFAnalisePadroes.BitBtnLimparClick(Sender: TObject);
begin
   //limpa o StringGrid
   NiceGrid1.RowCount := 0;
   RadioGroupTime.ItemIndex := 0;
   LimparEdits;
end;

procedure TFAnalisePadroes.LimparEdits;
begin
   gTotais.QtdVitoria := 0;
   gTotais.QtdDerrota := 0;
   gTotais.QtdEmpate  := 0;
   gTotais.QtdTotal   := 0;

//   EdVitorias1.Text := '';
//   EdDerrotas1.Text := '';
//   EdEmpates1.Text := '';
end;

procedure TFAnalisePadroes.NiceGrid1DrawCell(Sender: TObject; ACanvas: TCanvas;
  X, Y: Integer; Rc: TRect; var Handled: Boolean);
begin
   if (NiceGrid1.RowCount = 1) and (NiceGrid1.Cells[0,0] = '') then Exit;

   //cabeçalho
   if (StringGrid1.Cells[X, Y] = 'G') then
   begin
      ACanvas.Brush.Color := clScrollBar;
      ACanvas.FillRect(Rc);
      Exit
   end;

   ACanvas.Font.Color := clBlack;
   if (X = 0) then
   begin
      ACanvas.Brush.Color := clWhite;
   end
   else
   begin
      if (StringGrid1.Cells[X, Y] = 'X') then
      begin
         ACanvas.Brush.Color := $00A8FFFF;
         ACanvas.FillRect(Rc);
      end;

      if (StringGrid1.Cells[X, Y] = 'B') then
      begin
         ACanvas.Brush.Color := $00FFC993;
         ACanvas.FillRect(Rc);
      end;
   end;
end;

end.
