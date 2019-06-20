unit UInclusao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, SqlExpr, Buttons, Grids, DBGrids,
  ExtCtrls, uDM, ComCtrls, FireDAC.UI.Intf, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, System.UITypes, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFInclusao = class(TForm)
    GroupBoxTimeA: TGroupBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    ComboBoxArcMenorA1: TComboBox;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    ComboBoxArcMenorA3: TComboBox;
    GroupBoxTimeB: TGroupBox;
    GroupBox5: TGroupBox;
    Label8: TLabel;
    ComboBoxArcMenorB1: TComboBox;
    GroupBox6: TGroupBox;
    Label10: TLabel;
    ComboBoxArcMenorB2: TComboBox;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    ComboBoxArcMenorB3: TComboBox;
    Panel1: TPanel;
    RadioGroupTime: TRadioGroup;
    BitBtnPrever: TBitBtn;
    Label13: TLabel;
    Panel52: TPanel;
    Label34: TLabel;
    RadioGroupResultado: TRadioGroup;
    BitBtnInserir: TBitBtn;
    BitBtnLimpar: TBitBtn;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    SG1: TStringGrid;
    SG2: TStringGrid;
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
    FDQuery1Count: TFDQuery;
    FDQuery2Count: TFDQuery;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    ComboBoxArcMenorA2: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel50: TPanel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    EdVitorias1: TEdit;
    EdDerrotas1: TEdit;
    EdEmpates1: TEdit;
    Panel5: TPanel;
    Panel7: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    TabSheet2: TTabSheet;
    Panel51: TPanel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    EdVitorias2: TEdit;
    EdDerrotas2: TEdit;
    EdEmpates2: TEdit;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Panel25: TPanel;
    StringGrid01: TStringGrid;
    StringGrid02: TStringGrid;
    TabSheet3: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel11: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel26: TPanel;
    Panel27: TPanel;
    StringGrid03: TStringGrid;
    Panel28: TPanel;
    SG3: TStringGrid;
    FDQuery3: TFDQuery;
    FDQuery3Count: TFDQuery;
    Panel29: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    EdVitorias3: TEdit;
    EdDerrotas3: TEdit;
    EdEmpates3: TEdit;
    procedure BitBtnPreverClick(Sender: TObject);
    procedure BitBtnInserirClick(Sender: TObject);
    procedure BitBtnLimparClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid01DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid02DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid03DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    lsArcanoMenor1A, lsNaipe1A: string;
    lsArcanoMenor2A, lsNaipe2A: string;
    lsArcanoMenor3A, lsNaipe3A: string;
    lsArcanoMenor1B, lsNaipe1B: string;
    lsArcanoMenor2B, lsNaipe2B: string;
    lsArcanoMenor3B, lsNaipe3B: string;

    procedure LimparGrids;
    procedure MontarSQLPadrao_01;
    procedure MontarSQLPadrao_02;
    procedure MontarSQLPadrao_03;
    procedure PreencherStringGrid01(Grid: TStringGrid; var GridOculto: TStringGrid);
    procedure PreencherStringGrid02(Grid: TStringGrid; var GridOculto: TStringGrid);
    procedure PreencherStringGrid03(Grid: TStringGrid; var GridOculto: TStringGrid);
    procedure PreencherGridTela(var Grid: TStringGrid; Query: TFDQuery);
  public
    { Public declarations }
    gs1AMenor, gs1ANaipe,
    gs2AMenor, gs2ANaipe,
    gs3AMenor, gs3ANaipe,
    gs1BMenor, gs1BNaipe,
    gs2BMenor, gs2BNaipe,
    gs3BMenor, gs3BNaipe: string;
    procedure CarregarCombos;
  end;

var
  FInclusao: TFInclusao;

const ap = Chr(39);

implementation

{$R *.dfm}

procedure TFInclusao.LimparGrids;
var liLin,liCol: integer;
begin
   for liLin := 0 to StringGrid01.RowCount-1 do
      for liCol := 0 to StringGrid01.ColCount-1 do
         StringGrid01.Cells[liCol,liLin] := '';
   StringGrid01.RowCount := 1;

   for liLin := 0 to StringGrid02.RowCount-1 do
      for liCol := 0 to StringGrid02.ColCount-1 do
         StringGrid02.Cells[liCol,liLin] := '';
   StringGrid02.RowCount := 1;

   for liLin := 0 to StringGrid03.RowCount-1 do
      for liCol := 0 to StringGrid03.ColCount-1 do
         StringGrid03.Cells[liCol,liLin] := '';
   StringGrid03.RowCount := 1;

   for liLin := 0 to SG1.RowCount-1 do
      for liCol := 0 to SG1.ColCount-1 do
         SG1.Cells[liCol,liLin] := '';
   SG1.RowCount := 1;

   for liLin := 0 to SG2.RowCount-1 do
      for liCol := 0 to SG2.ColCount-1 do
         SG2.Cells[liCol,liLin] := '';
   SG2.RowCount := 1;

   for liLin := 0 to SG3.RowCount-1 do
      for liCol := 0 to SG3.ColCount-1 do
         SG3.Cells[liCol,liLin] := '';
   SG3.RowCount := 1;
end;

procedure TFInclusao.CarregarCombos;
var lsSQL: string;
    liInd: integer;
begin
   try
      //time A casa 1 arcano menor
      lsSQL := 'select Descricao from ARCANOS_MENORES where Numero = '+AP+gs1AMenor+AP+
               ' and Naipe = '+AP+gs1ANaipe+AP;
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.Open;
      //encontra a descricao no combo
      for liInd := 0 to ComboBoxArcMenorA1.Items.Count-1 do
      begin
         if (ComboBoxArcMenorA1.Items[liInd] = DM.FDQuery1.FieldByName('Descricao').AsString) then
         begin
            ComboBoxArcMenorA1.ItemIndex := liInd;
         end;
      end;

      //time A casa 2 arcano menor
      lsSQL := 'select Descricao from ARCANOS_MENORES where Numero = '+AP+gs2AMenor+AP+
               ' and Naipe = '+AP+gs2ANaipe+AP;
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.Open;
      //encontra a descricao no combo
      for liInd := 0 to ComboBoxArcMenorA2.Items.Count-1 do
      begin
         if (ComboBoxArcMenorA2.Items[liInd] = DM.FDQuery1.FieldByName('Descricao').AsString) then
         begin
            ComboBoxArcMenorA2.ItemIndex := liInd;
         end;
      end;

      //time A casa 3 arcano menor
      lsSQL := 'select Descricao from ARCANOS_MENORES where Numero = '+AP+gs3AMenor+AP+
               ' and Naipe = '+AP+gs3ANaipe+AP;
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.Open;
      //encontra a descricao no combo
      for liInd := 0 to ComboBoxArcMenorA3.Items.Count-1 do
      begin
         if (ComboBoxArcMenorA3.Items[liInd] = DM.FDQuery1.FieldByName('Descricao').AsString) then
         begin
            ComboBoxArcMenorA3.ItemIndex := liInd;
         end;
      end;

      //time B casa 1 arcano menor
      lsSQL := 'select Descricao from ARCANOS_MENORES where Numero = '+AP+gs1BMenor+AP+
               ' and Naipe = '+AP+gs1BNaipe+AP;
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.Open;
      //encontra a descricao no combo
      for liInd := 0 to ComboBoxArcMenorB1.Items.Count-1 do
      begin
         if (ComboBoxArcMenorB1.Items[liInd] = DM.FDQuery1.FieldByName('Descricao').AsString) then
         begin
            ComboBoxArcMenorB1.ItemIndex := liInd;
         end;
      end;

      //time B casa 2 arcano menor
      lsSQL := 'select Descricao from ARCANOS_MENORES where Numero = '+AP+gs2BMenor+AP+
               ' and Naipe = '+AP+gs2BNaipe+AP;
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.Open;
      //encontra a descricao no combo
      for liInd := 0 to ComboBoxArcMenorB2.Items.Count-1 do
      begin
         if (ComboBoxArcMenorB2.Items[liInd] = DM.FDQuery1.FieldByName('Descricao').AsString) then
         begin
            ComboBoxArcMenorB2.ItemIndex := liInd;
         end;
      end;

      //time B casa 3 arcano menor
      lsSQL := 'select Descricao from ARCANOS_MENORES where Numero = '+AP+gs3BMenor+AP+
               ' and Naipe = '+AP+gs3BNaipe+AP;
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.Open;
      //encontra a descricao no combo
      for liInd := 0 to ComboBoxArcMenorB3.Items.Count-1 do
      begin
         if (ComboBoxArcMenorB3.Items[liInd] = DM.FDQuery1.FieldByName('Descricao').AsString) then
         begin
            ComboBoxArcMenorB3.ItemIndex := liInd;
         end;
      end;
   except
      MessageDlg('Erro consulta à tabela ARCANOS_MENORES'+#13#10+'SQL = '+lsSQL, mtError, [mbOk], 0);
      DM.FDQuery1.Close;
      Screen.Cursor := crDefault;
      Exit;
   end;
end;

procedure TFInclusao.FormCreate(Sender: TObject);
begin
   //limpa o StringGrid
   LimparGrids;

   try
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add('select Descricao from ARCANOS_MENORES');
      DM.FDQuery1.Open;
   except
      MessageDlg('Erro consulta à tabela ARCANOS_MENORES'+#13#10+'SQL = select Descricao from ARCANOS_MENORES', mtError, [mbOk], 0);
      DM.FDQuery1.Close;
      Screen.Cursor := crDefault;
      Exit;
   end;

   ComboBoxArcMenorA1.Items.Clear;
   ComboBoxArcMenorA2.Items.Clear;
   ComboBoxArcMenorA3.Items.Clear;

   ComboBoxArcMenorB1.Items.Clear;
   ComboBoxArcMenorB2.Items.Clear;
   ComboBoxArcMenorB3.Items.Clear;

   while not DM.FDQuery1.Eof do
   begin
      ComboBoxArcMenorA1.Items.Add(DM.FDQuery1.FieldByName('Descricao').AsString);
      ComboBoxArcMenorA2.Items.Add(DM.FDQuery1.FieldByName('Descricao').AsString);
      ComboBoxArcMenorA3.Items.Add(DM.FDQuery1.FieldByName('Descricao').AsString);
      ComboBoxArcMenorB1.Items.Add(DM.FDQuery1.FieldByName('Descricao').AsString);
      ComboBoxArcMenorB2.Items.Add(DM.FDQuery1.FieldByName('Descricao').AsString);
      ComboBoxArcMenorB3.Items.Add(DM.FDQuery1.FieldByName('Descricao').AsString);
      DM.FDQuery1.Next;
   end;
   DM.FDQuery1.Close;
end;

procedure TFInclusao.BitBtnPreverClick(Sender: TObject);
var lsSQL: string;
begin
   LimparGrids;

   if (RadioGroupTime.ItemIndex = -1) then
   begin
      MessageDlg('Escolha um filtro!', mtWarning, [mbOk], 0);
      Exit;
   end;

   if (ComboBoxArcMenorA1.ItemIndex = -1) or
      (ComboBoxArcMenorA2.ItemIndex = -1) or
      (ComboBoxArcMenorA3.ItemIndex = -1) or
      (ComboBoxArcMenorB1.ItemIndex = -1) or
      (ComboBoxArcMenorB2.ItemIndex = -1) or
      (ComboBoxArcMenorB3.ItemIndex = -1) then
   begin
      MessageDlg('Selecione todos os arcanos!', mtWarning, [mbOk], 0);
      Exit;
   end;

   lsArcanoMenor1A := ComboBoxArcMenorA1.Text;
   lsArcanoMenor2A := ComboBoxArcMenorA2.Text;
   lsArcanoMenor3A := ComboBoxArcMenorA3.Text;

   lsArcanoMenor1B := ComboBoxArcMenorB1.Text;
   lsArcanoMenor2B := ComboBoxArcMenorB2.Text;
   lsArcanoMenor3B := ComboBoxArcMenorB3.Text;

   Screen.Cursor := crSQLWait;
   try
      //arcano menor aparece pela descrição, encontrar seu código, ou o número
      lsSQL := 'select Numero, Naipe from ARCANOS_MENORES where Descricao = :descricao';
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.ParamByName('descricao').AsString := lsArcanoMenor1A;
      DM.FDQuery1.Open;
      lsArcanoMenor1A := DM.FDQuery1.FieldByName('Numero').AsString;
      lsNaipe1A       := DM.FDQuery1.FieldByName('Naipe').AsString;
   except
      MessageDlg('Erro consulta à tabela ARCANOS_MENORES'+#13#10+'SQL = '+lsSQL, mtError, [mbOk], 0);
      DM.FDQuery1.Close;
      Screen.Cursor := crDefault;
      Exit;
   end;
   DM.FDQuery1.Close;

   try
      lsSQL := 'select Numero, Naipe from ARCANOS_MENORES where Descricao =:descricao';
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.ParamByName('descricao').AsString := lsArcanoMenor1B;
      DM.FDQuery1.Open;
      lsArcanoMenor1B := DM.FDQuery1.FieldByName('Numero').AsString;
      lsNaipe1B       := DM.FDQuery1.FieldByName('Naipe').AsString;
      DM.FDQuery1.Close;
   except
      MessageDlg('Erro consulta à tabela ARCANOS_MENORES'+#13#10+'SQL = '+lsSQL, mtError, [mbOk], 0);
      DM.FDQuery1.Close;
      Screen.Cursor := crDefault;
      Exit;
   end;

   try
      lsSQL := 'select Numero, Naipe from ARCANOS_MENORES where Descricao =:descricao';
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.ParamByName('descricao').AsString := lsArcanoMenor2A;
      DM.FDQuery1.Open;
      lsArcanoMenor2A := DM.FDQuery1.FieldByName('Numero').AsString;
      lsNaipe2A       := DM.FDQuery1.FieldByName('Naipe').AsString;
      DM.FDQuery1.Close;
   except
      MessageDlg('Erro consulta à tabela ARCANOS_MENORES'+#13#10+'SQL = '+lsSQL, mtError, [mbOk], 0);
      DM.FDQuery1.Close;
      Screen.Cursor := crDefault;
      Exit;
   end;

   try
      lsSQL := 'select Numero, Naipe from ARCANOS_MENORES where Descricao =:descricao';
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.ParamByName('descricao').AsString := lsArcanoMenor2B;
      DM.FDQuery1.Open;
      lsArcanoMenor2B := DM.FDQuery1.FieldByName('Numero').AsString;
      lsNaipe2B       := DM.FDQuery1.FieldByName('Naipe').AsString;
      DM.FDQuery1.Close;
   except
      MessageDlg('Erro consulta à tabela ARCANOS_MENORES'+#13#10+'SQL = '+lsSQL, mtError, [mbOk], 0);
      DM.FDQuery1.Close;
      Screen.Cursor := crDefault;
      Exit;
   end;

   try
      lsSQL := 'select Numero, Naipe from ARCANOS_MENORES where Descricao =:descricao';
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.ParamByName('descricao').AsString := lsArcanoMenor3A;
      DM.FDQuery1.Open;
      lsArcanoMenor3A := DM.FDQuery1.FieldByName('Numero').AsString;
      lsNaipe3A       := DM.FDQuery1.FieldByName('Naipe').AsString;
      DM.FDQuery1.Close;
   except
      MessageDlg('Erro consulta à tabela ARCANOS_MENORES'+#13#10+'SQL = '+lsSQL, mtError, [mbOk], 0);
      DM.FDQuery1.Close;
      Screen.Cursor := crDefault;
      Exit;
   end;

   try
      lsSQL := 'select Numero, Naipe from ARCANOS_MENORES where Descricao =:descricao';
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.ParamByName('descricao').AsString := lsArcanoMenor3B;
      DM.FDQuery1.Open;
      lsArcanoMenor3B := DM.FDQuery1.FieldByName('Numero').AsString;
      lsNaipe3B       := DM.FDQuery1.FieldByName('Naipe').AsString;
      DM.FDQuery1.Close;
   except
      MessageDlg('Erro consulta à tabela ARCANOS_MENORES'+#13#10+'SQL = '+lsSQL, mtError, [mbOk], 0);
      DM.FDQuery1.Close;
      Screen.Cursor := crDefault;
      Exit;
   end;

   MontarSQLPadrao_01;
   MontarSQLPadrao_02;
   MontarSQLPadrao_03;
   Screen.Cursor := crDefault;
end;

procedure TFInclusao.BitBtnInserirClick(Sender: TObject);
var lsSQL: string;
begin
   if (ComboBoxArcMenorA1.ItemIndex = -1) or
      (ComboBoxArcMenorA2.ItemIndex = -1) or
      (ComboBoxArcMenorA3.ItemIndex = -1) or
      (ComboBoxArcMenorB1.ItemIndex = -1) or
      (ComboBoxArcMenorB2.ItemIndex = -1) or
      (ComboBoxArcMenorB3.ItemIndex = -1) then
   begin
      MessageDlg('Selecione todos os arcanos!', mtWarning, [mbOk], 0);
      Exit;
   end;

   Screen.Cursor := crSQLWait;

   try
      //pega o último número da tabela
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add('select MAX(Id) as MAIOR from LOTECA_2019');
      DM.FDQuery1.Open;

      //prepara o SQL
      lsSQL := 'INSERT INTO LOTECA_2019 (Id, VITORIA, A_CASA1_MENOR, A_CASA1_NAIPE, '+
               'A_CASA2_MENOR, A_CASA2_NAIPE, A_CASA3_MENOR, A_CASA3_NAIPE, '+
               'B_CASA1_MENOR, B_CASA1_NAIPE, B_CASA2_MENOR, B_CASA2_NAIPE, '+
               'B_CASA3_MENOR, B_CASA3_NAIPE) '+
               'VALUES '+
               '('+IntToStr(DM.FDQuery1.FieldByName('MAIOR').AsInteger+1)+', ';

      case RadioGroupResultado.ItemIndex of
         0: lsSQL := lsSQL + '''A'', ';
         1: lsSQL := lsSQL + '''B'', ';
         2: lsSQL := lsSQL + '''E'', ';
         3: lsSQL := lsSQL + 'null, ';
      end; //case

      //arcano menor aparece pela descrição, encontrar seu código, ou o número
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add('select Numero, Naipe from ARCANOS_MENORES where Descricao = :descricao');
      DM.FDQuery1.ParamByName('descricao').AsString := ComboBoxArcMenorA1.Text;
      DM.FDQuery1.Open;
      lsSQL := lsSQL +
               ''''+DM.FDQuery1.FieldByName('Numero').AsString+''', '+
               ''''+DM.FDQuery1.FieldByName('Naipe').AsString +''', ';
      DM.FDQuery1.Close;

      //arcano menor aparece pela descrição, encontrar seu código, ou o número
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add('select Numero, Naipe from ARCANOS_MENORES where Descricao = '''+ComboBoxArcMenorA2.Text+'''');
      DM.FDQuery1.Open;
      lsSQL := lsSQL +
               ''''+DM.FDQuery1.FieldByName('Numero').AsString+''', '+
               ''''+DM.FDQuery1.FieldByName('Naipe').AsString +''', ';
      DM.FDQuery1.Close;

      //arcano menor aparece pela descrição, encontrar seu código, ou o número
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add('select Numero, Naipe from ARCANOS_MENORES where Descricao = '''+ComboBoxArcMenorA3.Text+'''');
      DM.FDQuery1.Open;
      lsSQL := lsSQL +
               ''''+DM.FDQuery1.FieldByName('Numero').AsString+''', '+
               ''''+DM.FDQuery1.FieldByName('Naipe').AsString +''', ';
      DM.FDQuery1.Close;

      //arcano menor aparece pela descrição, encontrar seu código, ou o número
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add('select Numero, Naipe from ARCANOS_MENORES where Descricao = '''+ComboBoxArcMenorB1.Text+'''');
      DM.FDQuery1.Open;
      lsSQL := lsSQL +
               ''''+DM.FDQuery1.FieldByName('Numero').AsString+''', '+
               ''''+DM.FDQuery1.FieldByName('Naipe').AsString +''', ';
      DM.FDQuery1.Close;

      //arcano menor aparece pela descrição, encontrar seu código, ou o número
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add('select Numero, Naipe from ARCANOS_MENORES where Descricao = '''+ComboBoxArcMenorB2.Text+'''');
      DM.FDQuery1.Open;
      lsSQL := lsSQL +
               ''''+DM.FDQuery1.FieldByName('Numero').AsString+''', '+
               ''''+DM.FDQuery1.FieldByName('Naipe').AsString +''', ';
      DM.FDQuery1.Close;

      //arcano menor aparece pela descrição, encontrar seu código, ou o número
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add('select Numero, Naipe from ARCANOS_MENORES where Descricao = '''+ComboBoxArcMenorB3.Text+'''');
      DM.FDQuery1.Open;
      lsSQL := lsSQL +
               ''''+DM.FDQuery1.FieldByName('Numero').AsString+''', '+
               ''''+DM.FDQuery1.FieldByName('Naipe').AsString +''')';
      DM.FDQuery1.Close;
   except
      Screen.Cursor := crDefault;
      MessageDlg('Erro na inclusão.', mtError,[mbOk],0);
      Exit;
   end;

   try
      DM.FDConnection1.StartTransaction;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.ExecSQL;
   except
      Screen.Cursor := crDefault;
      DM.FDConnection1.Rollback;
      MessageDlg('Erro na inclusão'+#13+#10+lsSQL, mtError,[mbOk],0);
      Exit;
   end;

   Screen.Cursor := crDefault;
   MessageDlg('Inclusão efetuada com sucesso!',mtInformation,[mbOk],0);
   DM.FDConnection1.Commit;
   BitBtnLimparClick(Sender);
end;

{*****************************************************************************
*                                                                            *
**********                   MontarSQLPadrao_01                     **********
*                                                                            *
*****************************************************************************}
procedure TFInclusao.MontarSQLPadrao_01;
var liLin, liCol: integer;
    liQtdVitoria, liQtdDerrota,liQtdEmpate, liTotal: real;
    lsSQL: string;
begin
   for liLin := 0 to SG1.RowCount-1 do
      for liCol := 0 to SG1.ColCount-1 do
         SG1.Cells[liCol,liLin] := '';
   SG1.RowCount := 1;

   //PADRÃO 1: Todos os arcanos menores (casa 1, 2 e 3) iguais
   try
      FDQuery1.Close;
      FDQuery1.ParamByName('lsArcanoMenor1A').AsString := lsArcanoMenor1A;
      FDQuery1.ParamByName('lsArcanoMenor2A').AsString := lsArcanoMenor2A;
      FDQuery1.ParamByName('lsArcanoMenor3A').AsString := lsArcanoMenor3A;
      FDQuery1.ParamByName('lsNaipe1A').AsString := lsNaipe1A;
      FDQuery1.ParamByName('lsNaipe2A').AsString := lsNaipe2A;
      FDQuery1.ParamByName('lsNaipe3A').AsString := lsNaipe3A;
      FDQuery1.ParamByName('lsArcanoMenor1B').AsString := lsArcanoMenor1B;
      FDQuery1.ParamByName('lsArcanoMenor2B').AsString := lsArcanoMenor2B;
      FDQuery1.ParamByName('lsArcanoMenor3B').AsString := lsArcanoMenor3B;
      FDQuery1.ParamByName('lsNaipe1B').AsString := lsNaipe1B;
      FDQuery1.ParamByName('lsNaipe2B').AsString := lsNaipe2B;
      FDQuery1.ParamByName('lsNaipe3B').AsString := lsNaipe3B;
      FDQuery1.Open;
   except
      Screen.Cursor := crDefault;
      FDQuery1.Close;
      MessageDlg('Erro consulta Padrão 01.'+#13+#10+lsSQL, mtError,[mbOk],0);
      Exit;
   end;

   if (FDQuery1.bof and FDQuery1.Eof) then
   begin
      EdVitorias1.Text := '';
      EdDerrotas1.Text := '';
      EdEmpates1.Text  := '';
   end
   else
   begin
      //agora preenche o StringGrid
      while not FDQuery1.Eof do
      begin
         PreencherGridTela(StringGrid01, FDQuery1);
         //Preenche o StringGrid que define quais campos serão pintados
         PreencherStringGrid01(StringGrid01, SG1);
         FDQuery1.Next;
      end;

      try
         //contabiliza vitórias, derrotas e empates
         FDQuery1Count.Close;
         FDQuery1Count.ParamByName('lsArcanoMenor1A').AsString := lsArcanoMenor1A;
         FDQuery1Count.ParamByName('lsArcanoMenor2A').AsString := lsArcanoMenor2A;
         FDQuery1Count.ParamByName('lsArcanoMenor3A').AsString := lsArcanoMenor3A;
         FDQuery1Count.ParamByName('lsNaipe1A').AsString := lsNaipe1A;
         FDQuery1Count.ParamByName('lsNaipe2A').AsString := lsNaipe2A;
         FDQuery1Count.ParamByName('lsNaipe3A').AsString := lsNaipe3A;
         FDQuery1Count.ParamByName('lsArcanoMenor1B').AsString := lsArcanoMenor1B;
         FDQuery1Count.ParamByName('lsArcanoMenor2B').AsString := lsArcanoMenor2B;
         FDQuery1Count.ParamByName('lsArcanoMenor3B').AsString := lsArcanoMenor3B;
         FDQuery1Count.ParamByName('lsNaipe1B').AsString := lsNaipe1B;
         FDQuery1Count.ParamByName('lsNaipe2B').AsString := lsNaipe2B;
         FDQuery1Count.ParamByName('lsNaipe3B').AsString := lsNaipe3B;
         FDQuery1Count.Open;

         liQtdVitoria := 0;
         liQtdDerrota := 0;
         liQtdEmpate  := 0;
         liTotal      := 0;

         //efetua as estatísticas
         while not FDQuery1Count.Eof do
         begin
            if (Trim(FDQuery1Count.FieldByName('Vitoria').AsString) <> '') then
            begin
               case RadioGroupTime.ItemIndex of
                  0: //significa que o time A é quem tem as cartas escolhidas
                  begin
                        case FDQuery1Count.FieldByName('Vitoria').AsString[1] of
                           'A': liQtdVitoria := liQtdVitoria + FDQuery1Count.FieldByName('QTD').AsInteger; //time com as cartas venceu
                           'B': liQtdDerrota := liQtdDerrota + FDQuery1Count.FieldByName('QTD').AsInteger; //time com as cartas perdeu
                           'E': liQtdEmpate  := liQtdEmpate  + FDQuery1Count.FieldByName('QTD').AsInteger; //time com as cartas empatou
                        end; //case
                  end;
                  1: //significa que o time B é quem tem as cartas escolhidas
                  begin
                     case FDQuery1Count.FieldByName('Vitoria').AsString[1] of
                        'A': liQtdDerrota := liQtdDerrota + FDQuery1Count.FieldByName('QTD').AsInteger; //time com as cartas perdeu
                        'B': liQtdVitoria := liQtdVitoria + FDQuery1Count.FieldByName('QTD').AsInteger; //time com as cartas venceu
                        'E': liQtdEmpate  := liQtdEmpate  + FDQuery1Count.FieldByName('QTD').AsInteger; //time com as cartas empatou
                     end; //case
                  end;
               end; //case
               liTotal := liTotal + FDQuery1Count.FieldByName('QTD').AsInteger;
            end;
            FDQuery1Count.Next;
         end;
      except
         Screen.Cursor := crDefault;
         FDQuery1Count.Close;
         MessageDlg('Erro consulta Padrão 01 (totais).'+#13+#10+lsSQL, mtError,[mbOk],0);
         Exit;
      end;

      //agora coloca em forma de percentagem
      liQtdVitoria    := ((liQtdVitoria * 100)/liTotal);
      EdVitorias1.Text := FormatFloat('#0.00',liQtdVitoria) + '%';
      liQtdDerrota    := ((liQtdDerrota * 100)/liTotal);
      EdDerrotas1.Text := FormatFloat('#0.00',liQtdDerrota) + '%';
      liQtdEmpate     := ((liQtdEmpate * 100)/liTotal);
      EdEmpates1.Text  := FormatFloat('#0.00',liQtdEmpate) + '%';
   end;
end;

{*****************************************************************************
*                                                                            *
**********                   MontarSQLPadrao_02                     **********
*                                                                            *
*****************************************************************************}
procedure TFInclusao.MontarSQLPadrao_02;
var liQtdVitoria, liQtdDerrota,liQtdEmpate, liTotal: real;
    lsSQL: string;
    liLin, liCol: integer;
begin
   for liLin := 0 to SG2.RowCount-1 do
      for liCol := 0 to SG2.ColCount-1 do
         SG2.Cells[liCol,liLin] := '';
   SG2.RowCount := 1;
   try
      FDQuery2.Close;
      case RadioGroupTime.ItemIndex of
         0: //time A
         begin
            FDQuery2.ParamByName('lsArcanoMenor1').AsString := lsArcanoMenor1A;
            FDQuery2.ParamByName('lsNaipe1').AsString := lsNaipe1A;
            FDQuery2.ParamByName('lsArcanoMenor2').AsString := lsArcanoMenor2A;
            FDQuery2.ParamByName('lsNaipe2').AsString := lsNaipe2A;
            FDQuery2.ParamByName('lsArcanoMenor3').AsString := lsArcanoMenor3A;
            FDQuery2.ParamByName('lsNaipe3').AsString := lsNaipe3A;
         end;
         1: //time B
         begin
            FDQuery2.ParamByName('lsArcanoMenor1').AsString := lsArcanoMenor1B;
            FDQuery2.ParamByName('lsNaipe1').AsString := lsNaipe1B;
            FDQuery2.ParamByName('lsArcanoMenor2').AsString := lsArcanoMenor2B;
            FDQuery2.ParamByName('lsNaipe2').AsString := lsNaipe2B;
            FDQuery2.ParamByName('lsArcanoMenor3').AsString := lsArcanoMenor3B;
            FDQuery2.ParamByName('lsNaipe3').AsString := lsNaipe3B;
         end;
      end;
      FDQuery2.Open;
   except
      Screen.Cursor := crDefault;
      FDQuery2.Close;
      MessageDlg('Erro consulta Padrão 02.'+#13+#10+lsSQL, mtError,[mbOk],0);
      Exit;
   end;

   if (FDQuery2.bof and FDQuery2.Eof) then
   begin
      EdVitorias2.Text := '';
      EdDerrotas2.Text := '';
      EdEmpates2.Text  := '';
      Exit;
   end;

   //agora preenche o StringGrid
   while not FDQuery2.Eof do
   begin
      PreencherGridTela(StringGrid02, FDQuery2);
      //Preenche o StringGrid que define quais campos serão pintados
      PreencherStringGrid02(StringGrid02, SG2);
      FDQuery2.Next;
   end;

   //contabiliza vitórias, derrotas e empates
   try
      FDQuery2Count.Close;
      case RadioGroupTime.ItemIndex of
         0: //time A
         begin
            FDQuery2Count.ParamByName('lsArcanoMenor1').AsString := lsArcanoMenor1A;
            FDQuery2Count.ParamByName('lsNaipe1').AsString := lsNaipe1A;
            FDQuery2Count.ParamByName('lsArcanoMenor2').AsString := lsArcanoMenor2A;
            FDQuery2Count.ParamByName('lsNaipe2').AsString := lsNaipe2A;
            FDQuery2Count.ParamByName('lsArcanoMenor3').AsString := lsArcanoMenor3A;
            FDQuery2Count.ParamByName('lsNaipe3').AsString := lsNaipe3A;
         end;
         1: //time B
         begin
            FDQuery2Count.ParamByName('lsArcanoMenor1').AsString := lsArcanoMenor1B;
            FDQuery2Count.ParamByName('lsNaipe1').AsString := lsNaipe1B;
            FDQuery2Count.ParamByName('lsArcanoMenor2').AsString := lsArcanoMenor2B;
            FDQuery2Count.ParamByName('lsNaipe2').AsString := lsNaipe2B;
            FDQuery2Count.ParamByName('lsArcanoMenor3').AsString := lsArcanoMenor3B;
            FDQuery2Count.ParamByName('lsNaipe3').AsString := lsNaipe3B;
         end;
      end;
      FDQuery2Count.Open;
   except
      Screen.Cursor := crDefault;
      FDQuery2Count.Close;
      MessageDlg('Erro consulta Padrão 02 (totais).'+#13+#10+lsSQL, mtError,[mbOk],0);
      Exit;
   end;

   liQtdVitoria := 0;
   liQtdDerrota := 0;
   liQtdEmpate  := 0;
   liTotal      := 0;

   //efetua as estatísticas
   while not FDQuery2Count.Eof do
   begin
      if (Trim(FDQuery2Count.FieldByName('Vitoria').AsString) <> '') then
      begin
         case FDQuery2Count.FieldByName('Equipe').AsString[1] of
            'A': //significa que o time A é quem tem as cartas escolhidas
            begin
               case FDQuery2Count.FieldByName('Vitoria').AsString[1] of
                  'A': liQtdVitoria := liQtdVitoria + FDQuery2Count.FieldByName('QTD').AsInteger; //time com as cartas venceu
                  'B': liQtdDerrota := liQtdDerrota + FDQuery2Count.FieldByName('QTD').AsInteger; //time com as cartas perdeu
                  'E': liQtdEmpate  := liQtdEmpate  + FDQuery2Count.FieldByName('QTD').AsInteger; //time com as cartas empatou
               end; //case
            end;
            'B': //significa que o time B é quem tem as cartas escolhidas
            begin
               case FDQuery2Count.FieldByName('Vitoria').AsString[1] of
                  'A': liQtdDerrota := liQtdDerrota + FDQuery2Count.FieldByName('QTD').AsInteger; //time com as cartas perdeu
                  'B': liQtdVitoria := liQtdVitoria + FDQuery2Count.FieldByName('QTD').AsInteger; //time com as cartas venceu
                  'E': liQtdEmpate  := liQtdEmpate  + FDQuery2Count.FieldByName('QTD').AsInteger; //time com as cartas empatou
               end; //case
            end;
         end; //case
      liTotal := liTotal + FDQuery2Count.FieldByName('QTD').AsInteger;
      end;
      FDQuery2Count.Next;
   end;

   //agora coloca em forma de percentagem
   liQtdVitoria    := ((liQtdVitoria * 100)/liTotal);
   EdVitorias2.Text := FormatFloat('#0.00',liQtdVitoria) + '%';
   liQtdDerrota    := ((liQtdDerrota * 100)/liTotal);
   EdDerrotas2.Text := FormatFloat('#0.00',liQtdDerrota) + '%';
   liQtdEmpate     := ((liQtdEmpate * 100)/liTotal);
   EdEmpates2.Text  := FormatFloat('#0.00',liQtdEmpate) + '%';
end;

{*****************************************************************************
*                                                                            *
**********                   MontarSQLPadrao_03                     **********
*                                                                            *
*****************************************************************************}
procedure TFInclusao.MontarSQLPadrao_03;
var liQtdVitoria, liQtdDerrota,liQtdEmpate, liTotal: real;
    lsSQL: string;
    liLin, liCol: integer;
begin
   for liLin := 0 to SG3.RowCount-1 do
      for liCol := 0 to SG3.ColCount-1 do
         SG3.Cells[liCol,liLin] := '';
   SG3.RowCount := 1;

   try
      FDQuery3.Close;
      case (RadioGroupTime.ItemIndex) of
         0: begin
            FDQuery3.ParamByName('lsArcanoMenor1A').AsString := lsArcanoMenor1A;
            FDQuery3.ParamByName('lsArcanoMenor2A').AsString := lsArcanoMenor2A;
            FDQuery3.ParamByName('lsArcanoMenor3A').AsString := lsArcanoMenor3A;
            FDQuery3.ParamByName('lsArcanoMenor1B').AsString := lsArcanoMenor1B;
            FDQuery3.ParamByName('lsNaipe1B').AsString := lsNaipe1B;
            FDQuery3.ParamByName('lsArcanoMenor2B').AsString := lsArcanoMenor2B;
            FDQuery3.ParamByName('lsNaipe2B').AsString := lsNaipe2B;
            FDQuery3.ParamByName('lsArcanoMenor3B').AsString := lsArcanoMenor3B;
            FDQuery3.ParamByName('lsNaipe3B').AsString := lsNaipe3B;
         end;
         1: begin
            FDQuery3.ParamByName('lsArcanoMenor1A').AsString := lsArcanoMenor1B;
            FDQuery3.ParamByName('lsArcanoMenor2A').AsString := lsArcanoMenor2B;
            FDQuery3.ParamByName('lsArcanoMenor3A').AsString := lsArcanoMenor3B;
            FDQuery3.ParamByName('lsArcanoMenor1B').AsString := lsArcanoMenor1A;
            FDQuery3.ParamByName('lsNaipe1B').AsString := lsNaipe1A;
            FDQuery3.ParamByName('lsArcanoMenor2B').AsString := lsArcanoMenor2A;
            FDQuery3.ParamByName('lsNaipe2B').AsString := lsNaipe2A;
            FDQuery3.ParamByName('lsArcanoMenor3B').AsString := lsArcanoMenor3A;
            FDQuery3.ParamByName('lsNaipe3B').AsString := lsNaipe3A;
         end;
      end;
      FDQuery3.Open;
   except
      Screen.Cursor := crDefault;
      FDQuery3.Close;
      MessageDlg('Erro consulta Padrão 03.'+#13+#10+lsSQL, mtError,[mbOk],0);
      Exit;
   end;

   if (FDQuery3.RecordCount = 0) then
   begin
      EdVitorias3.Text := '';
      EdDerrotas3.Text := '';
      EdEmpates3.Text  := '';
      Exit;
   end;

   //agora preenche o StringGrid
   while not FDQuery3.Eof do
   begin
      PreencherGridTela(StringGrid03, FDQuery3);
      //Preenche o StringGrid que define quais campos serão pintados
      PreencherStringGrid03(StringGrid03, SG3);
      FDQuery3.Next;
   end;

   //contabiliza vitórias, derrotas e empates
   try
      FDQuery3Count.Close;
      case (RadioGroupTime.ItemIndex) of
         0: begin
            FDQuery3.ParamByName('lsArcanoMenor1A').AsString := lsArcanoMenor1A;
            FDQuery3.ParamByName('lsArcanoMenor2A').AsString := lsArcanoMenor2A;
            FDQuery3.ParamByName('lsArcanoMenor3A').AsString := lsArcanoMenor3A;
            FDQuery3.ParamByName('lsArcanoMenor1B').AsString := lsArcanoMenor1B;
            FDQuery3.ParamByName('lsNaipe1B').AsString := lsNaipe1B;
            FDQuery3.ParamByName('lsArcanoMenor2B').AsString := lsArcanoMenor2B;
            FDQuery3.ParamByName('lsNaipe2B').AsString := lsNaipe2B;
            FDQuery3.ParamByName('lsArcanoMenor3B').AsString := lsArcanoMenor3B;
            FDQuery3.ParamByName('lsNaipe3B').AsString := lsNaipe3B;
         end;
         1: begin
            FDQuery3.ParamByName('lsArcanoMenor1A').AsString := lsArcanoMenor1B;
            FDQuery3.ParamByName('lsArcanoMenor2A').AsString := lsArcanoMenor2B;
            FDQuery3.ParamByName('lsArcanoMenor3A').AsString := lsArcanoMenor3B;
            FDQuery3.ParamByName('lsArcanoMenor1B').AsString := lsArcanoMenor1A;
            FDQuery3.ParamByName('lsNaipe1B').AsString := lsNaipe1A;
            FDQuery3.ParamByName('lsArcanoMenor2B').AsString := lsArcanoMenor2A;
            FDQuery3.ParamByName('lsNaipe2B').AsString := lsNaipe2A;
            FDQuery3.ParamByName('lsArcanoMenor3B').AsString := lsArcanoMenor3A;
            FDQuery3.ParamByName('lsNaipe3B').AsString := lsNaipe3A;
         end;
      end;

      FDQuery3Count.Open;
   except
      Screen.Cursor := crDefault;
      FDQuery3Count.Close;
      MessageDlg('Erro consulta Padrão 03 (totais).'+#13+#10+lsSQL, mtError,[mbOk],0);
      Exit;
   end;

   liQtdVitoria := 0;
   liQtdDerrota := 0;
   liQtdEmpate  := 0;
   liTotal      := 0;

   //efetua as estatísticas
   if not (FDQuery3Count.RecordCount = 0) then
   begin
      while not (FDQuery3Count.Eof) do
      begin
         if (Trim(FDQuery3Count.FieldByName('Vitoria').AsString) <> '') then
         begin
            case FDQuery3Count.FieldByName('Equipe').AsString[1] of
               'A': //significa que o time A é quem tem as cartas escolhidas
               begin
                  case FDQuery3Count.FieldByName('Vitoria').AsString[1] of
                     'A': liQtdVitoria := liQtdVitoria + FDQuery3Count.FieldByName('QTD').AsInteger; //time com as cartas venceu
                     'B': liQtdDerrota := liQtdDerrota + FDQuery3Count.FieldByName('QTD').AsInteger; //time com as cartas perdeu
                     'E': liQtdEmpate  := liQtdEmpate  + FDQuery3Count.FieldByName('QTD').AsInteger; //time com as cartas empatou
                  end; //case
               end;
               'B': //significa que o time B é quem tem as cartas escolhidas
               begin
                  case FDQuery3Count.FieldByName('Vitoria').AsString[1] of
                     'A': liQtdDerrota := liQtdDerrota + FDQuery3Count.FieldByName('QTD').AsInteger; //time com as cartas perdeu
                     'B': liQtdVitoria := liQtdVitoria + FDQuery3Count.FieldByName('QTD').AsInteger; //time com as cartas venceu
                     'E': liQtdEmpate  := liQtdEmpate  + FDQuery3Count.FieldByName('QTD').AsInteger; //time com as cartas empatou
                  end; //case
               end;
            end; //case
         liTotal := liTotal + FDQuery3Count.FieldByName('QTD').AsInteger;
         end;
         FDQuery3Count.Next;
      end;

      //agora coloca em forma de percentagem
      liQtdVitoria    := ((liQtdVitoria * 100)/liTotal);
      EdVitorias3.Text := FormatFloat('#0.00',liQtdVitoria) + '%';
      liQtdDerrota    := ((liQtdDerrota * 100)/liTotal);
      EdDerrotas3.Text := FormatFloat('#0.00',liQtdDerrota) + '%';
      liQtdEmpate     := ((liQtdEmpate * 100)/liTotal);
      EdEmpates3.Text  := FormatFloat('#0.00',liQtdEmpate) + '%';
   end;
end;

procedure TFInclusao.PreencherGridTela(var Grid: TStringGrid; Query: TFDQuery);
begin
   if not((Grid.RowCount = 1) and (Grid.Cells[0,0] = '')) then
      Grid.RowCount := Grid.RowCount + 1;

   Grid.Cells[00,Grid.RowCount-1] := Query.FieldByName('Vitoria').AsString;
   Grid.Cells[01,Grid.RowCount-1] := Query.FieldByName('A1MENOR').AsString;
   Grid.Cells[02,Grid.RowCount-1] := Query.FieldByName('A2MENOR').AsString;
   Grid.Cells[03,Grid.RowCount-1] := Query.FieldByName('A3MENOR').AsString;
   Grid.Cells[04,Grid.RowCount-1] := Query.FieldByName('B1MENOR').AsString;
   Grid.Cells[05,Grid.RowCount-1] := Query.FieldByName('B2MENOR').AsString;
   Grid.Cells[06,Grid.RowCount-1] := Query.FieldByName('B3MENOR').AsString;
   Grid.Cells[07,Grid.RowCount-1] := Query.FieldByName('Equipe').AsString;
end;

procedure TFInclusao.PreencherStringGrid01(Grid: TStringGrid; var SGrid: TStringGrid);
var lsNaipeD, lsNaipeH, lsNumD, lsNumH: string;
begin
   if not((SGrid.RowCount = 1) and (SGrid.Cells[0,0] = '')) then
      SGrid.RowCount := SGrid.RowCount + 1;
         SGrid.Cells[00,SGrid.RowCount-1] := Grid.Cells[07,Grid.RowCount-1];

         if (SGrid.Cells[00,SGrid.RowCount-1] = 'A') then
         begin
            if (Grid.Cells[01,Grid.RowCount-1] = ComboBoxArcMenorA1.Text) then
                SGrid.Cells[01,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[01,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[01,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[01,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[01,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[02,Grid.RowCount-1] = ComboBoxArcMenorA2.Text) then
               SGrid.Cells[02,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[02,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[02,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[02,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[02,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[03,Grid.RowCount-1] = ComboBoxArcMenorA3.Text) then
               SGrid.Cells[03,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[03,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[03,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[03,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[03,SGrid.RowCount-1] := 'Y';
            end;

            //time B
            if (Grid.Cells[04,Grid.RowCount-1] = ComboBoxArcMenorB1.Text) then
               SGrid.Cells[04,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[04,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[04,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[04,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[04,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[05,Grid.RowCount-1] = ComboBoxArcMenorB2.Text) then
               SGrid.Cells[05,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[05,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[05,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[05,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[05,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[06,Grid.RowCount-1] = ComboBoxArcMenorB3.Text) then
               SGrid.Cells[06,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[06,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[06,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[06,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[06,SGrid.RowCount-1] := 'Y';
            end;
         end
         else
         begin
            if (Grid.Cells[01,Grid.RowCount-1] = ComboBoxArcMenorB1.Text) then
               SGrid.Cells[01,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[01,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[01,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[01,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[01,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[02,Grid.RowCount-1] = ComboBoxArcMenorB2.Text) then
               SGrid.Cells[02,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[02,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[02,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[02,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[02,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[03,Grid.RowCount-1] = ComboBoxArcMenorB3.Text) then
               SGrid.Cells[03,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[03,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[03,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[03,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[03,SGrid.RowCount-1] := 'Y';
            end;

            //time B
            if (Grid.Cells[04,Grid.RowCount-1] = ComboBoxArcMenorA1.Text) then
               SGrid.Cells[04,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[04,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[04,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[04,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[04,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[05,Grid.RowCount-1] = ComboBoxArcMenorA2.Text) then
               SGrid.Cells[05,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[05,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[05,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[05,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[05,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[06,Grid.RowCount-1] = ComboBoxArcMenorA3.Text) then
               SGrid.Cells[06,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[06,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[06,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[06,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[06,SGrid.RowCount-1] := 'Y';
            end;
         end;
end;

procedure TFInclusao.PreencherStringGrid02(Grid: TStringGrid; var SGrid: TStringGrid);
var lsNaipeD, lsNaipeH, lsNumD, lsNumH: string;
begin
   if not((SGrid.RowCount = 1) and (SGrid.Cells[0,0] = '')) then
      SGrid.RowCount := SGrid.RowCount + 1;
         SGrid.Cells[00,SGrid.RowCount-1] := Grid.Cells[07,Grid.RowCount-1];

   case RadioGroupTime.ItemIndex of
      0: //time A selecionado
      begin
         if (SGrid.Cells[00,SGrid.RowCount-1] = 'A') then
         begin
            if (Grid.Cells[01,Grid.RowCount-1] = ComboBoxArcMenorA1.Text) then
                SGrid.Cells[01,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[01,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[01,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[01,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[01,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[02,Grid.RowCount-1] = ComboBoxArcMenorA2.Text) then
               SGrid.Cells[02,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[02,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[02,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[02,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[02,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[03,Grid.RowCount-1] = ComboBoxArcMenorA3.Text) then
               SGrid.Cells[03,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[03,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[03,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[03,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[03,SGrid.RowCount-1] := 'Y';
            end;

            //time B
            if (Grid.Cells[04,Grid.RowCount-1] = ComboBoxArcMenorB1.Text) then
               SGrid.Cells[04,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[04,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[04,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[04,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[04,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[05,Grid.RowCount-1] = ComboBoxArcMenorB2.Text) then
               SGrid.Cells[05,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[05,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[05,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[05,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[05,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[06,Grid.RowCount-1] = ComboBoxArcMenorB3.Text) then
               SGrid.Cells[06,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[06,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[06,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[06,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[06,SGrid.RowCount-1] := 'Y';
            end;
         end
         else
         begin
            if (Grid.Cells[01,Grid.RowCount-1] = ComboBoxArcMenorB1.Text) then
               SGrid.Cells[01,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[01,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[01,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[01,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[01,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[02,Grid.RowCount-1] = ComboBoxArcMenorB2.Text) then
               SGrid.Cells[02,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[02,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[02,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[02,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[02,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[03,Grid.RowCount-1] = ComboBoxArcMenorB3.Text) then
               SGrid.Cells[03,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[03,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[03,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[03,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[03,SGrid.RowCount-1] := 'Y';
            end;

            //time B
            if (Grid.Cells[04,Grid.RowCount-1] = ComboBoxArcMenorA1.Text) then
               SGrid.Cells[04,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[04,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[04,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[04,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[04,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[05,Grid.RowCount-1] = ComboBoxArcMenorA2.Text) then
               SGrid.Cells[05,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[05,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[05,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[05,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[05,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[06,Grid.RowCount-1] = ComboBoxArcMenorA3.Text) then
               SGrid.Cells[06,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[06,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[06,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[06,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[06,SGrid.RowCount-1] := 'Y';
            end;
         end;
      end;
      1: //time B selecionado
      begin
         if (SGrid.Cells[07,SGrid.RowCount-1] = 'A') then
         begin
            if (Grid.Cells[01,Grid.RowCount-1] = ComboBoxArcMenorB1.Text) then
               SGrid.Cells[01,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[01,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[01,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[01,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[02,Grid.RowCount-1] = ComboBoxArcMenorB2.Text) then
               SGrid.Cells[02,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[02,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[02,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[02,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[03,Grid.RowCount-1] = ComboBoxArcMenorB3.Text) then
               SGrid.Cells[03,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[03,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[03,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[03,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[04,Grid.RowCount-1] = ComboBoxArcMenorA1.Text) then
               SGrid.Cells[04,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[04,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[04,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[04,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[05,Grid.RowCount-1] = ComboBoxArcMenorA2.Text) then
               SGrid.Cells[05,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[05,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[05,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[05,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[06,Grid.RowCount-1] = ComboBoxArcMenorA3.Text) then
               SGrid.Cells[06,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[06,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[06,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[06,SGrid.RowCount-1] := 'Y'
            end;
         end
         else
         begin
            if (Grid.Cells[01,Grid.RowCount-1] = ComboBoxArcMenorA1.Text) then
               SGrid.Cells[01,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[01,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[01,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[01,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[02,Grid.RowCount-1] = ComboBoxArcMenorA2.Text) then
               SGrid.Cells[02,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[02,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[02,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[02,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[03,Grid.RowCount-1] = ComboBoxArcMenorA3.Text) then
               SGrid.Cells[03,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[03,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[03,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[03,SGrid.RowCount-1] := 'Y'
            end;

            //time B
            if (Grid.Cells[04,Grid.RowCount-1] = ComboBoxArcMenorB1.Text) then
               SGrid.Cells[04,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[04,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[04,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[04,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[05,Grid.RowCount-1] = ComboBoxArcMenorB2.Text) then
               SGrid.Cells[05,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[05,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[05,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[05,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[06,Grid.RowCount-1] = ComboBoxArcMenorB3.Text) then
               SGrid.Cells[06,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[06,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[06,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[06,SGrid.RowCount-1] := 'Y'
            end;
         end;
      end;
   end;
end;

procedure TFInclusao.PreencherStringGrid03(Grid: TStringGrid; var SGrid: TStringGrid);
var lsNaipeD, lsNaipeH, lsNumD, lsNumH: string;
begin
   if not((SGrid.RowCount = 1) and (SGrid.Cells[0,0] = '')) then
      SGrid.RowCount := SGrid.RowCount + 1;
         SGrid.Cells[00,SGrid.RowCount-1] := Grid.Cells[07,Grid.RowCount-1];

   case RadioGroupTime.ItemIndex of
      0: //time A selecionado
      begin
         if (SGrid.Cells[00,SGrid.RowCount-1] = 'A') then
         begin
            if (Grid.Cells[01,Grid.RowCount-1] = ComboBoxArcMenorA1.Text) then
                SGrid.Cells[01,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[01,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[01,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[01,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[01,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[02,Grid.RowCount-1] = ComboBoxArcMenorA2.Text) then
               SGrid.Cells[02,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[02,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[02,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[02,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[02,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[03,Grid.RowCount-1] = ComboBoxArcMenorA3.Text) then
               SGrid.Cells[03,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[03,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[03,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[03,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[03,SGrid.RowCount-1] := 'Y';
            end;

            //time B
            if (Grid.Cells[04,Grid.RowCount-1] = ComboBoxArcMenorB1.Text) then
               SGrid.Cells[04,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[04,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[04,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[04,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[04,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[05,Grid.RowCount-1] = ComboBoxArcMenorB2.Text) then
               SGrid.Cells[05,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[05,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[05,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[05,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[05,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[06,Grid.RowCount-1] = ComboBoxArcMenorB3.Text) then
               SGrid.Cells[06,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[06,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[06,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[06,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[06,SGrid.RowCount-1] := 'Y';
            end;
         end
         else
         begin
            if (Grid.Cells[01,Grid.RowCount-1] = ComboBoxArcMenorB1.Text) then
               SGrid.Cells[01,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[01,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[01,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[01,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[01,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[02,Grid.RowCount-1] = ComboBoxArcMenorB2.Text) then
               SGrid.Cells[02,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[02,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[02,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[02,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[02,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[03,Grid.RowCount-1] = ComboBoxArcMenorB3.Text) then
               SGrid.Cells[03,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[03,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[03,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[03,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[03,SGrid.RowCount-1] := 'Y';
            end;

            //time B
            if (Grid.Cells[04,Grid.RowCount-1] = ComboBoxArcMenorA1.Text) then
               SGrid.Cells[04,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[04,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[04,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[04,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[04,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[05,Grid.RowCount-1] = ComboBoxArcMenorA2.Text) then
               SGrid.Cells[05,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[05,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[05,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[05,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[05,SGrid.RowCount-1] := 'Y';
            end;

            if (Grid.Cells[06,Grid.RowCount-1] = ComboBoxArcMenorA3.Text) then
               SGrid.Cells[06,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[06,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[06,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if (lsNumD = lsNumH) then
                   SGrid.Cells[06,SGrid.RowCount-1] := 'Z'
               else
                  if (lsNaipeD = lsNaipeH) then
                     SGrid.Cells[06,SGrid.RowCount-1] := 'Y';
            end;
         end;
      end;
      1: //time B selecionado
      begin
         if (SGrid.Cells[00,SGrid.RowCount-1] = 'A') then
         begin
            if (Grid.Cells[01,Grid.RowCount-1] = ComboBoxArcMenorB1.Text) then
               SGrid.Cells[01,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[01,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[01,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[01,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[02,Grid.RowCount-1] = ComboBoxArcMenorB2.Text) then
               SGrid.Cells[02,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[02,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[02,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[02,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[03,Grid.RowCount-1] = ComboBoxArcMenorB3.Text) then
               SGrid.Cells[03,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[03,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[03,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[03,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[04,Grid.RowCount-1] = ComboBoxArcMenorA1.Text) then
               SGrid.Cells[04,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[04,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[04,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[04,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[05,Grid.RowCount-1] = ComboBoxArcMenorA2.Text) then
               SGrid.Cells[05,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[05,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[05,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[05,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[06,Grid.RowCount-1] = ComboBoxArcMenorA3.Text) then
               SGrid.Cells[06,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[06,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[06,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[06,SGrid.RowCount-1] := 'Y'
            end;
         end
         else
         begin
            if (Grid.Cells[01,Grid.RowCount-1] = ComboBoxArcMenorA1.Text) then
               SGrid.Cells[01,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[01,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[01,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[01,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[02,Grid.RowCount-1] = ComboBoxArcMenorA2.Text) then
               SGrid.Cells[02,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[02,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[02,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[02,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[03,Grid.RowCount-1] = ComboBoxArcMenorA3.Text) then
               SGrid.Cells[03,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[03,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorA3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[03,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorA3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[03,SGrid.RowCount-1] := 'Y'
            end;

            //time B
            if (Grid.Cells[04,Grid.RowCount-1] = ComboBoxArcMenorB1.Text) then
               SGrid.Cells[04,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[04,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB1.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[04,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB1.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[04,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[05,Grid.RowCount-1] = ComboBoxArcMenorB2.Text) then
               SGrid.Cells[05,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[05,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB2.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[05,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB2.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[05,SGrid.RowCount-1] := 'Y'
            end;

            if (Grid.Cells[06,Grid.RowCount-1] = ComboBoxArcMenorB3.Text) then
               SGrid.Cells[06,SGrid.RowCount-1] := 'X'
            else //verificar se número ou naipe é igual
            begin
               lsNumD   := Grid.Cells[06,Grid.RowCount-1];
               lsNumD   := Copy(lsNumD,1,Pos(' ',lsNumD)-1);
               lsNumH   := ComboBoxArcMenorB3.Text;
               lsNumH   := Copy(lsNumH,1,Pos(' ',lsNumH)-1);
               lsNaipeD := Grid.Cells[06,Grid.RowCount-1];
               lsNaipeD := Copy(lsNaipeD,Pos(' ',lsNaipeD)+1, Length(lsNaipeD));
               lsNaipeH := ComboBoxArcMenorB3.Text;
               lsNaipeH := Copy(lsNaipeH,Pos(' ',lsNaipeH)+1, Length(lsNaipeH));

               if ((lsNumD = lsNumH) or (lsNaipeD = lsNaipeH)) then
                  SGrid.Cells[06,SGrid.RowCount-1] := 'Y'
            end;
         end;
      end;
   end;
end;

procedure TFInclusao.BitBtnLimparClick(Sender: TObject);
begin
   //limpa o StringGrid
   LimparGrids;

   ComboBoxArcMenorA1.ItemIndex := -1;
   ComboBoxArcMenorA2.ItemIndex := -1;
   ComboBoxArcMenorA3.ItemIndex := -1;

   ComboBoxArcMenorB1.ItemIndex := -1;
   ComboBoxArcMenorB2.ItemIndex := -1;
   ComboBoxArcMenorB3.ItemIndex := -1;

   RadioGroupResultado.ItemIndex := 3;
   RadioGroupTime.ItemIndex := 0;


   EdVitorias1.Text := '';
   EdVitorias2.Text := '';

   EdDerrotas1.Text := '';
   EdDerrotas2.Text := '';

   EdEmpates1.Text := '';
   EdEmpates2.Text := '';
end;


procedure TFInclusao.StringGrid01DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
   if (StringGrid01.RowCount = 1) and (StringGrid01.Cells[0,0] = '') then Exit;

   StringGrid01.Canvas.Font.Color := clBlack;
   StringGrid01.Canvas.Brush.Color := clWhite;

   if (SG1.Cells[ACol, ARow] = 'X') then
      StringGrid01.Canvas.Brush.Color := $00A8FFFF;

   if (SG1.Cells[ACol, ARow] = 'Y') then
      StringGrid01.Canvas.Brush.Color := $00FFC993;

   if (SG1.Cells[ACol, ARow] = 'Z') then
      StringGrid01.Canvas.Brush.Color := $008080FF;

   StringGrid01.Canvas.FillRect(Rect);
   StringGrid01.Canvas.TextOut(Rect.Left+2,Rect.Top+2,StringGrid01.Cells[ACol, ARow]);
end;


procedure TFInclusao.StringGrid02DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
   if (StringGrid02.RowCount = 1) and (StringGrid02.Cells[0,0] = '') then Exit;

   StringGrid02.Canvas.Font.Color := clBlack;
   StringGrid02.Canvas.Brush.Color := clWhite;

   if (SG2.Cells[ACol, ARow] = 'X') then
      StringGrid02.Canvas.Brush.Color := $00A8FFFF;

   if (SG2.Cells[ACol, ARow] = 'Y') then
      StringGrid02.Canvas.Brush.Color := $00FFC993;

   if (SG2.Cells[ACol, ARow] = 'Z') then
      StringGrid02.Canvas.Brush.Color := $008080FF;

   StringGrid02.Canvas.FillRect(Rect);
   StringGrid02.Canvas.TextOut(Rect.Left+2,Rect.Top+2,StringGrid02.Cells[ACol, ARow]);
end;

procedure TFInclusao.StringGrid03DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
   if (StringGrid03.RowCount = 1) and (StringGrid03.Cells[0,0] = '') then Exit;

   StringGrid03.Canvas.Font.Color := clBlack;
   StringGrid03.Canvas.Brush.Color := clWhite;

   if (SG3.Cells[ACol, ARow] = 'X') then
      StringGrid03.Canvas.Brush.Color := $00A8FFFF;

   if (SG3.Cells[ACol, ARow] = 'Y') then
      StringGrid03.Canvas.Brush.Color := $00FFC993;

   if (SG3.Cells[ACol, ARow] = 'Z') then
      StringGrid03.Canvas.Brush.Color := $008080FF;

   StringGrid03.Canvas.FillRect(Rect);
   StringGrid03.Canvas.TextOut(Rect.Left+2,Rect.Top+2,StringGrid03.Cells[ACol, ARow]);
end;

end.
