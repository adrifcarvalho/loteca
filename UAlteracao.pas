unit UAlteracao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, SqlExpr, Buttons, Grids, DBGrids,
  ExtCtrls, uDM, ComCtrls, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, System.UITypes;

type
  TFAlteracao = class(TForm)
    Panel52: TPanel;
    Label34: TLabel;
    RadioGroupResultado: TRadioGroup;
    BitBtn1: TBitBtn;
    btnFiltrar: TBitBtn;
    GroupBoxTimeA: TGroupBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    ComboBoxArcMenorA1: TComboBox;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    ComboBoxArcMenorA2: TComboBox;
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
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Panel5: TPanel;
    StringGrid1: TStringGrid;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel12: TPanel;
    Panel10: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    procedure FormShow(Sender: TObject);
    procedure BitBtnInserirClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
  private
    { Private declarations }
    lsArcanoMaior1A, lsArcanoMenor1A, lsNaipe1A: string;
    lsArcanoMaior2A, lsArcanoMenor2A, lsNaipe2A: string;
    lsArcanoMaior3A, lsArcanoMenor3A, lsNaipe3A: string;
    lsArcanoMaior1B, lsArcanoMenor1B, lsNaipe1B: string;
    lsArcanoMaior2B, lsArcanoMenor2B, lsNaipe2B: string;
    lsArcanoMaior3B, lsArcanoMenor3B, lsNaipe3B: string;
    giId: longint;
    procedure LimparGrids;

  public
    { Public declarations }
  end;

var
  FAlteracao: TFAlteracao;

implementation

{$R *.dfm}

procedure TFAlteracao.LimparGrids;
var liLin,liCol: integer;
begin
   for liLin := 0 to StringGrid1.RowCount-1 do
      for liCol := 0 to StringGrid1.ColCount-1 do
         StringGrid1.Cells[liCol,liLin] := '';
   StringGrid1.RowCount := 1;
end;

procedure TFAlteracao.FormShow(Sender: TObject);
begin
   //limpa o StringGrid
   LimparGrids;

   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add('select Descricao from ARCANOS_MENORES');
   DM.FDQuery1.Open;

   ComboBoxArcMenorA1.Items.Clear;
   ComboBoxArcMenorA2.Items.Clear;
   ComboBoxArcMenorA3.Items.Clear;

   ComboBoxArcMenorB1.Items.Clear;
   ComboBoxArcMenorB2.Items.Clear;
   ComboBoxArcMenorB3.Items.Clear;

   while not DM.FDQuery1.Eof do
   begin
      ComboBoxArcMenorA1.Items.Add(DM.FDQuery1.Fields.FieldByName('Descricao').AsString);
      ComboBoxArcMenorA2.Items.Add(DM.FDQuery1.Fields.FieldByName('Descricao').AsString);
      ComboBoxArcMenorA3.Items.Add(DM.FDQuery1.Fields.FieldByName('Descricao').AsString);
      ComboBoxArcMenorB1.Items.Add(DM.FDQuery1.Fields.FieldByName('Descricao').AsString);
      ComboBoxArcMenorB2.Items.Add(DM.FDQuery1.Fields.FieldByName('Descricao').AsString);
      ComboBoxArcMenorB3.Items.Add(DM.FDQuery1.Fields.FieldByName('Descricao').AsString);
      DM.FDQuery1.Next;
   end;
   DM.FDQuery1.Close;
end;

procedure TFAlteracao.BitBtnInserirClick(Sender: TObject);
var lsSQL: string;
begin
   if (RadioGroupResultado.ItemIndex = -1) then
   begin
      MessageDlg('Escolha um resultado para o jogo a ser alterado!',mtWarning,[mbOk],0);
      RadioGroupResultado.SetFocus;
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

   Screen.Cursor := crSQLWait;
   //prepara o SQL
   lsSQL := 'UPDATE LOTECA_2019 set VITORIA = ';

   case RadioGroupResultado.ItemIndex of
      0: lsSQL := lsSQL + '''A'' ';
      1: lsSQL := lsSQL + '''B'' ';
      2: lsSQL := lsSQL + '''E'' ';
      3: lsSQL := lsSQL + 'null ';
   end; //case

   lsSQL := lsSQL + 'where Id = '+IntToStr(giId);

   try
      DM.FDConnection1.StartTransaction;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.ExecSQL;
   except
      Screen.Cursor := crDefault;
      DM.FDConnection1.Rollback;
      MessageDlg('Erro na alteração'+#13+#10+lsSQL, mtError,[mbOk],0);
      Exit;
   end;
   Screen.Cursor := crDefault;
   MessageDlg('Alteração efetuada com sucesso!',mtInformation,[mbOk],0);
   DM.FDConnection1.Commit;
end;

procedure TFAlteracao.btnFiltrarClick(Sender: TObject);
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

   lsArcanoMenor1A := ComboBoxArcMenorA1.Text;
   lsArcanoMenor2A := ComboBoxArcMenorA2.Text;
   lsArcanoMenor3A := ComboBoxArcMenorA3.Text;
   lsArcanoMenor1B := ComboBoxArcMenorB1.Text;
   lsArcanoMenor2B := ComboBoxArcMenorB2.Text;
   lsArcanoMenor3B := ComboBoxArcMenorB3.Text;

   //arcano menor aparece pela descrição, encontrar seu código, ou o número
   lsSQL := 'select Numero, Naipe from ARCANOS_MENORES where Descricao = '''+lsArcanoMenor1A+'''';
   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add(lsSQL);
   DM.FDQuery1.Open;
   lsArcanoMenor1A := DM.FDQuery1.FieldByName('Numero').AsString;
   lsNaipe1A       := DM.FDQuery1.FieldByName('Naipe').AsString;
   DM.FDQuery1.Close;

   lsSQL := 'select Numero, Naipe from ARCANOS_MENORES where Descricao = '''+lsArcanoMenor1B+'''';
   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add(lsSQL);
   DM.FDQuery1.Open;
   lsArcanoMenor1B := DM.FDQuery1.FieldByName('Numero').AsString;
   lsNaipe1B       := DM.FDQuery1.FieldByName('Naipe').AsString;
   DM.FDQuery1.Close;

   lsSQL := 'select Numero, Naipe from ARCANOS_MENORES where Descricao = '''+lsArcanoMenor2A+'''';
   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add(lsSQL);
   DM.FDQuery1.Open;
   lsArcanoMenor2A := DM.FDQuery1.FieldByName('Numero').AsString;
   lsNaipe2A       := DM.FDQuery1.FieldByName('Naipe').AsString;
   DM.FDQuery1.Close;

   lsSQL := 'select Numero, Naipe from ARCANOS_MENORES where Descricao = '''+lsArcanoMenor2B+'''';
   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add(lsSQL);
   DM.FDQuery1.Open;
   lsArcanoMenor2B := DM.FDQuery1.FieldByName('Numero').AsString;
   lsNaipe2B       := DM.FDQuery1.FieldByName('Naipe').AsString;
   DM.FDQuery1.Close;

   lsSQL := 'select Numero, Naipe from ARCANOS_MENORES where Descricao = '''+lsArcanoMenor3A+'''';
   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add(lsSQL);
   DM.FDQuery1.Open;
   lsArcanoMenor3A := DM.FDQuery1.FieldByName('Numero').AsString;
   lsNaipe3A       := DM.FDQuery1.FieldByName('Naipe').AsString;
   DM.FDQuery1.Close;

   lsSQL := 'select Numero, Naipe from ARCANOS_MENORES where Descricao = '''+lsArcanoMenor3B+'''';
   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add(lsSQL);
   DM.FDQuery1.Open;
   lsArcanoMenor3B := DM.FDQuery1.FieldByName('Numero').AsString;
   lsNaipe3B       := DM.FDQuery1.FieldByName('Naipe').AsString;
   DM.FDQuery1.Close;

   //limpa os StringGrids
   StringGrid1.RowCount := 0;

   lsSQL := 'select Id, Vitoria, ''A'' as Equipe, '+
            'a1ME.Descricao as A1MENOR, a2ME.Descricao as A2MENOR, a3ME.Descricao as A3MENOR, '+
            'b1ME.Descricao as B1MENOR, b2ME.Descricao as B2MENOR, b3ME.Descricao as B3MENOR  '+
            'from LOTECA_2019 '+
            'join ARCANOS_MENORES a1ME on(a1ME.Numero = A_CASA1_MENOR and a1ME.Naipe = A_CASA1_NAIPE) '+
            'join ARCANOS_MENORES a2ME on(a2ME.Numero = A_CASA2_MENOR and a2ME.Naipe = A_CASA2_NAIPE) '+
            'join ARCANOS_MENORES a3ME on(a3ME.Numero = A_CASA3_MENOR and a3ME.Naipe = A_CASA3_NAIPE) '+
            'join ARCANOS_MENORES b1ME on(b1ME.Numero = B_CASA1_MENOR and b1ME.Naipe = B_CASA1_NAIPE) '+
            'join ARCANOS_MENORES b2ME on(b2ME.Numero = B_CASA2_MENOR and b2ME.Naipe = B_CASA2_NAIPE) '+
            'join ARCANOS_MENORES b3ME on(b3ME.Numero = B_CASA3_MENOR and b3ME.Naipe = B_CASA3_NAIPE) '+
            'WHERE ';

   lsSQL := lsSQL +
            ' (A_CASA1_MENOR = '''+lsArcanoMenor1A+''' and A_CASA1_NAIPE = '''+lsNaipe1A+''' and'+
            ' A_CASA2_MENOR = '''+lsArcanoMenor2A+''' and A_CASA2_NAIPE = '''+lsNaipe2A+''' and'+
            ' A_CASA3_MENOR = '''+lsArcanoMenor3A+''' and A_CASA3_NAIPE = '''+lsNaipe3A+''')';

   lsSQL := lsSQL +
            ' and (B_CASA1_MENOR = '''+lsArcanoMenor1B+''' and B_CASA1_NAIPE = '''+lsNaipe1B+''' and'+
            '  B_CASA2_MENOR = '''+lsArcanoMenor2B+''' and B_CASA2_NAIPE = '''+lsNaipe2B+''' and'+
            '  B_CASA3_MENOR = '''+lsArcanoMenor3B+''' and B_CASA3_NAIPE = '''+lsNaipe3B+''')';

   lsSQL := lsSQL + 'order by VITORIA, Equipe';
   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add(lsSQL);
   DM.FDQuery1.Open;

   if (DM.FDQuery1.bof and DM.FDQuery1.Eof) then
   begin
      MessageDlg('Não há nenhum jogo com os arcanos selecionados!',mtInformation,[mbOk],0);
      Exit;
   end
   else
   begin
      giId := DM.FDQuery1.FieldByName('Id').AsInteger;

      RadioGroupResultado.ItemIndex := 3;

      if (DM.FDQuery1.FieldByName('Vitoria').AsString = 'A') then
         RadioGroupResultado.ItemIndex := 0;

      if (DM.FDQuery1.FieldByName('Vitoria').AsString = 'B') then
         RadioGroupResultado.ItemIndex := 1;

      if (DM.FDQuery1.FieldByName('Vitoria').AsString = 'E') then
         RadioGroupResultado.ItemIndex := 2;

      //agora preenche o StringGrid
      while not DM.FDQuery1.Eof do
      begin
         if not((StringGrid1.RowCount=1) and (StringGrid1.Cells[1,0]='')) then
            StringGrid1.RowCount := StringGrid1.RowCount + 1;

         StringGrid1.Cells[00,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('Vitoria').AsString;
         StringGrid1.Cells[01,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('A1MENOR').AsString;
         StringGrid1.Cells[02,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('A2MENOR').AsString;
         StringGrid1.Cells[03,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('A3MENOR').AsString;
         StringGrid1.Cells[04,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('B1MENOR').AsString;
         StringGrid1.Cells[05,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('B2MENOR').AsString;
         StringGrid1.Cells[06,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('B3MENOR').AsString;
         DM.FDQuery1.Next;
      end;
   end;
end;

end.


