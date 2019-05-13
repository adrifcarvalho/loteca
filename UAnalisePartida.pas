unit UAnalisePartida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, SqlExpr, Buttons, Grids, DBGrids,
  ExtCtrls, uDM, ComCtrls, NiceGrid, FireDAC.UI.Intf, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, System.UITypes, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, XPman;

type
  TFAnalisePartida = class(TForm)
    Panel1: TPanel;
    RadioGroupTime: TRadioGroup;
    BitBtnPrever: TBitBtn;
    Label13: TLabel;
    PageControl1: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel51: TPanel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    EdVitorias2: TEdit;
    EdDerrotas2: TEdit;
    EdEmpates2: TEdit;
    BitBtnLimpar: TBitBtn;
    NiceGrid2: TNiceGrid;
    NiceGrid1: TNiceGrid;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    StringGrid4: TStringGrid;
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
    FDQuery1Count: TFDQuery;
    FDQuery2Count: TFDQuery;
    Panel5: TPanel;
    Label43: TLabel;
    ComboBoxPartidas: TComboBox;
    Label44: TLabel;
    MaskEditData: TMaskEdit;
    Label45: TLabel;
    FDQHeader: TFDQuery;
    ProgressBar1: TProgressBar;
    Panel50: TPanel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    EdVitorias1: TEdit;
    EdDerrotas1: TEdit;
    EdEmpates1: TEdit;
    procedure BitBtnPreverClick(Sender: TObject);
    procedure BitBtnLimparClick(Sender: TObject);
    procedure NiceGrid2DrawCell(Sender: TObject; ACanvas: TCanvas; X,
      Y: Integer; Rc: TRect; var Handled: Boolean);
    procedure NiceGrid1DrawCell(Sender: TObject; ACanvas: TCanvas; X,
      Y: Integer; Rc: TRect; var Handled: Boolean);
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

    procedure MontarSQLPadrao(iPadrao: integer; Query: TFDQuery; QueryCount: TFDQuery);
    procedure PreencherNiceGrid(sNiceGrid: string; Query: TFDQuery; bHeader: Boolean);
    procedure PreencherStringGrid(QueryHeader: TFDQuery; QueryDetail: TFDQuery; sGrid: string; bHeader: Boolean);
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
     QtdVitoria: array[1..2] of real;
     QtdDerrota: array[1..2] of real;
     QtdEmpate : array[1..2] of real;
     QtdTotal:   array[1..2] of real;
  end;

var
  FAnalisePartida: TFAnalisePartida;
  gTotais: TTotais;

const ap = Chr(39);

implementation

{$R *.dfm}

procedure TFAnalisePartida.FormCreate(Sender: TObject);
begin
   //limpa o StringGrid
   NiceGrid1.RowCount := 0;
   NiceGrid2.RowCount := 0;
   ComboBoxPartidas.Enabled := False;
end;

procedure TFAnalisePartida.BitBtnPreverClick(Sender: TObject);
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

   lsPartida := ComboBoxPartidas.Items[ComboBoxPartidas.ItemIndex];
   lsPartida := Copy(lsPartida,1,Pos(' - ',lsPartida)-1);

   LimparEdits;
   LimparGrids(NiceGrid1,StringGrid1);
   LimparGrids(NiceGrid2,StringGrid2);

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


   ProgressBar1.Min := 0;
   ProgressBar1.Position := 0;
   ProgressBar1.Max := DM.FDQuery1.RecordCount;

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
      //PADRÃO 1
      MontarSQLPadrao(1,FDQuery1, FDQuery1Count);
      //PADRÃO 2
      MontarSQLPadrao(2,FDQuery2, FDQuery2Count);
      ProgressBar1.Position := ProgressBar1.Position + 1;
      DM.FDQuery1.Next;
   end;

   //agora coloca em forma de percentagem
   if (gTotais.QtdTotal[1] <> 0) then
   begin
      gTotais.QtdVitoria[1] := ((gTotais.QtdVitoria[1] * 100)/gTotais.QtdTotal[1]);
      gTotais.QtdDerrota[1] := ((gTotais.QtdDerrota[1] * 100)/gTotais.QtdTotal[1]);
      gTotais.QtdEmpate[1]  := ((gTotais.QtdEmpate[1] * 100)/gTotais.QtdTotal[1]);
      EdVitorias1.Text := FormatFloat('#0.00',gTotais.QtdVitoria[1]) + '%';
      EdDerrotas1.Text := FormatFloat('#0.00',gTotais.QtdDerrota[1]) + '%';
      EdEmpates1.Text  := FormatFloat('#0.00',gTotais.QtdEmpate[1]) + '%';
   end;

   if (gTotais.QtdTotal[2] <> 0) then
   begin
      gTotais.QtdVitoria[2] := ((gTotais.QtdVitoria[2] * 100)/gTotais.QtdTotal[2]);
      gTotais.QtdDerrota[2] := ((gTotais.QtdDerrota[2] * 100)/gTotais.QtdTotal[2]);
      gTotais.QtdEmpate[2]  := ((gTotais.QtdEmpate[2] * 100)/gTotais.QtdTotal[2]);
      EdVitorias2.Text := FormatFloat('#0.00',gTotais.QtdVitoria[2]) + '%';
      EdDerrotas2.Text := FormatFloat('#0.00',gTotais.QtdDerrota[2]) + '%';
      EdEmpates2.Text  := FormatFloat('#0.00',gTotais.QtdEmpate[2]) + '%';
   end;

   Screen.Cursor := crDefault;
end;

procedure TFAnalisePartida.MaskEditDataChange(Sender: TObject);
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

{*****************************************************************************
*                                                                            *
**********                     MontarSQLPadrao                      **********
*                                                                            *
*****************************************************************************}
procedure TFAnalisePartida.MontarSQLPadrao(iPadrao: integer; Query: TFDQuery; QueryCount: TFDQuery);
var lsSQL: string;
    lbPrivez: Boolean;
    lsArcMai1Filtro, lsArcMai2Filtro, lsArcMai3Filtro, lsArcMen1Filtro,
    lsArcMen2Filtro, lsArcMen3Filtro, lsNaipe1Filtro, lsNaipe2Filtro, lsNaipe3Filtro: string;
    lsArcMai1Oposto, lsArcMai2Oposto, lsArcMai3Oposto, lsArcMen1Oposto,
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
      Query.ParamByName('ArcMai1Filtro').AsString := lsArcMai1Filtro;
      Query.ParamByName('ArcMai2Filtro').AsString := lsArcMai2Filtro;
      Query.ParamByName('ArcMai3Filtro').AsString := lsArcMai3Filtro;
      Query.ParamByName('ArcMen1Filtro').AsString := lsArcMen1Filtro;
      Query.ParamByName('ArcMen2Filtro').AsString := lsArcMen2Filtro;
      Query.ParamByName('ArcMen3Filtro').AsString := lsArcMen3Filtro;
      Query.ParamByName('Naipe1Filtro').AsString := lsNaipe1Filtro;
      Query.ParamByName('Naipe2Filtro').AsString := lsNaipe2Filtro;
      Query.ParamByName('Naipe3Filtro').AsString := lsNaipe3Filtro;
      Query.ParamByName('ArcMai1Oposto').AsString := lsArcMai1Oposto;
      Query.ParamByName('ArcMai2Oposto').AsString := lsArcMai2Oposto;
      Query.ParamByName('ArcMai3Oposto').AsString := lsArcMai3Oposto;
      Query.ParamByName('ArcMen1Oposto').AsString := lsArcMen1Oposto;
      Query.ParamByName('ArcMen2Oposto').AsString := lsArcMen2Oposto;
      Query.ParamByName('ArcMen3Oposto').AsString := lsArcMen3Oposto;
      Query.ParamByName('Naipe1Oposto').AsString := lsNaipe1Oposto;
      Query.ParamByName('Naipe2Oposto').AsString := lsNaipe2Oposto;
      Query.ParamByName('Naipe3Oposto').AsString := lsNaipe3Oposto;
      Query.Open;
   except
      Screen.Cursor := crDefault;
      Query.Close;
      MessageDlg('Erro consulta Padrão '+IntToStr(iPadrao)+#13+#10+lsSQL, mtError,[mbOk],0);
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
            PreencherNiceGrid('NiceGrid'+IntToStr(iPadrao),FDQHeader, True);
            PreencherStringGrid(FDQHeader,Query, 'StringGrid'+IntToStr(iPadrao), True);
            lbPrivez := False;
         end;
         PreencherNiceGrid('NiceGrid'+IntToStr(iPadrao), Query, False);
         //Preenche o StringGrid que define quais campos serão pintados
         PreencherStringGrid(FDQHeader, Query, 'StringGrid'+IntToStr(iPadrao), False);
         Query.Next;
      end;

      try
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
                           'A': gTotais.QtdVitoria[iPadrao] := gTotais.QtdVitoria[iPadrao] + QueryCount.FieldByName('QTD').AsInteger; //time com as cartas venceu
                           'B': gTotais.QtdDerrota[iPadrao] := gTotais.QtdDerrota[iPadrao] + QueryCount.FieldByName('QTD').AsInteger; //time com as cartas perdeu
                           'E': gTotais.QtdEmpate[iPadrao]  := gTotais.QtdEmpate[iPadrao]  + QueryCount.FieldByName('QTD').AsInteger; //time com as cartas empatou
                        end; //case
                  end;
                  'B': //significa que o time B é quem tem as cartas escolhidas
                  begin
                     case QueryCount.FieldByName('Vitoria').AsString[1] of
                        'A': gTotais.QtdDerrota[iPadrao] := gTotais.QtdDerrota[iPadrao] + QueryCount.FieldByName('QTD').AsInteger; //time com as cartas perdeu
                        'B': gTotais.QtdVitoria[iPadrao] := gTotais.QtdVitoria[iPadrao] + QueryCount.FieldByName('QTD').AsInteger; //time com as cartas venceu
                        'E': gTotais.QtdEmpate[iPadrao]  := gTotais.QtdEmpate[iPadrao]  + QueryCount.FieldByName('QTD').AsInteger; //time com as cartas empatou
                     end; //case
                  end;
               end; //case
               gTotais.QtdTotal[iPadrao] := gTotais.QtdTotal[iPadrao] + QueryCount.FieldByName('QTD').AsInteger;
            end;
            QueryCount.Next;
         end;
      except
         Screen.Cursor := crDefault;
         QueryCount.Close;
         MessageDlg('Erro consulta Padrão 01 (totais).'+#13+#10+lsSQL, mtError,[mbOk],0);
         Exit;
      end;
   end;
   Query.Close;
   QueryCount.Close;
end;

procedure TFAnalisePartida.PreencherNiceGrid(sNiceGrid: string; Query: TFDQuery; bHeader: Boolean);
begin
   with TNiceGrid(FindComponent(sNiceGrid)) do
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

procedure TFAnalisePartida.PreencherStringGrid(QueryHeader: TFDQuery; QueryDetail: TFDQuery; sGrid: string; bHeader: Boolean);
var lsNaipeD, lsNaipeH, lsNumD, lsNumH: string;
begin
   with TStringGrid(FindComponent(sGrid)) do
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

                     if (lsNumD = lsNumH) then
                        Cells[02,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[02,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[04,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[04,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[06,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[06,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[08,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[08,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[10,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[10,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[12,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[12,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[02,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[02,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[04,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[04,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[06,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[06,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[08,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[08,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[10,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[10,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[12,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[12,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[08,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[08,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[10,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[10,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[12,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[12,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[02,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[02,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[04,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[04,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[06,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[06,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[02,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[02,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[04,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[04,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[06,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[06,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[08,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[08,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[10,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[10,RowCount-1] := 'B';
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

                     if (lsNumD = lsNumH) then
                        Cells[12,RowCount-1] := 'V';

                     if (lsNaipeD = lsNaipeH) then
                        Cells[12,RowCount-1] := 'B';
                  end;
               end;
            end;
         end;
      end;
   end;
end;

procedure TFAnalisePartida.LimparGrids(var NiceGrid: TNiceGrid; var SGrid: TStringGrid);
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

procedure TFAnalisePartida.BitBtnLimparClick(Sender: TObject);
begin
   MaskEditData.Text := '  /  /    ';
   ComboBoxPartidas.Items.Clear;
   ComboBoxPartidas.Enabled := False;
   ComboBoxPartidas.ItemIndex := -1;

   //limpa o StringGrid
   NiceGrid1.RowCount := 0;
   NiceGrid2.RowCount := 0;

   RadioGroupTime.ItemIndex := 0;
   LimparEdits;
end;

procedure TFAnalisePartida.LimparEdits;
var liLin: integer;
begin
   for liLin := 1 to 2 do
   begin
      gTotais.QtdVitoria[liLin] := 0;
      gTotais.QtdDerrota[liLin] := 0;
      gTotais.QtdEmpate[liLin]  := 0;
      gTotais.QtdTotal[liLin]   := 0;
   end;

   EdVitorias1.Text := '';
   EdVitorias2.Text := '';
   EdDerrotas1.Text := '';
   EdDerrotas2.Text := '';
   EdEmpates1.Text := '';
   EdEmpates2.Text := '';
end;

procedure TFAnalisePartida.NiceGrid1DrawCell(Sender: TObject; ACanvas: TCanvas;
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

      if (StringGrid1.Cells[X, Y] = 'V') then
      begin
         ACanvas.Brush.Color := $00B7FFB7;
         ACanvas.FillRect(Rc);
      end;
   end;
end;

procedure TFAnalisePartida.NiceGrid2DrawCell(Sender: TObject; ACanvas: TCanvas;
  X, Y: Integer; Rc: TRect; var Handled: Boolean);
begin
   //Setar DefaultDrawing = False
   if (NiceGrid2.RowCount = 1) and (NiceGrid2.Cells[0,0] = '') then Exit;

   //cabeçalho
   if (StringGrid2.Cells[X, Y] = 'G') then
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
      if (StringGrid2.Cells[X, Y] = 'X') then
      begin
         ACanvas.Brush.Color := $00A8FFFF;
         ACanvas.FillRect(Rc);
      end;

      if (StringGrid2.Cells[X, Y] = 'B') then
      begin
         ACanvas.Brush.Color := $00FFC993;
         ACanvas.FillRect(Rc);
      end;

      if (StringGrid2.Cells[X, Y] = 'V') then
      begin
         ACanvas.Brush.Color := $00B7FFB7;
         ACanvas.FillRect(Rc);
      end;
   end;
end;

end.
