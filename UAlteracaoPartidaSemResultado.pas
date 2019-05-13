unit UAlteracaoPartidaSemResultado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, SqlExpr, Buttons, Grids, DBGrids,
  ExtCtrls, uDM, ComCtrls, System.UITypes, FireDAC.UI.Intf,
  FireDAC.FMXUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI, Vcl.Imaging.GIFImg,
  Vcl.Mask;

type
  TFAlteracaoPartidaSemResultado = class(TForm)
    Panel52: TPanel;
    Label34: TLabel;
    RadioGroupResultado: TRadioGroup;
    BitBtnAlterar: TBitBtn;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Label43: TLabel;
    Label44: TLabel;
    MaskEditData: TMaskEdit;
    ComboBoxPartidas: TComboBox;
    Label45: TLabel;
    Panel5: TPanel;
    Panel7: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    StringGrid1: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure MaskEditDataChange(Sender: TObject);
    procedure ComboBoxPartidasChange(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarGrid;
    procedure LimparGrid;
  public
    { Public declarations }
  end;

var
  FAlteracaoPartidaSemResultado: TFAlteracaoPartidaSemResultado;

implementation

{$R *.dfm}

procedure TFAlteracaoPartidaSemResultado.FormShow(Sender: TObject);
begin
   LimparGrid;
end;


procedure TFAlteracaoPartidaSemResultado.MaskEditDataChange(Sender: TObject);
var lsSQL, lsData: string;
begin
   LimparGrid;

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
      lsSQL := 'select * from PARTIDAS where data_partida = '''+lsData+''''+
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

procedure TFAlteracaoPartidaSemResultado.CarregarGrid;
var lsSQL, lsPartida: string;
begin
   LimparGrid;
   Screen.Cursor := crSQLWait;

   lsPartida := ComboBoxPartidas.Items[ComboBoxPartidas.ItemIndex];
   lsPartida := Copy(lsPartida,1,Pos(' - ',lsPartida)-1);

   lsSQL := 'select Id, Vitoria, '+
            'a1ME.Descricao as A1MENOR, a2ME.Descricao as A2MENOR, a3ME.Descricao as A3MENOR, '+
            'b1ME.Descricao as B1MENOR, b2ME.Descricao as B2MENOR, b3ME.Descricao as B3MENOR  '+
            'from LOTECA_2019 '+
            'join ARCANOS_MENORES a1ME on(a1ME.Numero = A_CASA1_MENOR and a1ME.Naipe = A_CASA1_NAIPE) '+
            'join ARCANOS_MENORES a2ME on(a2ME.Numero = A_CASA2_MENOR and a2ME.Naipe = A_CASA2_NAIPE) '+
            'join ARCANOS_MENORES a3ME on(a3ME.Numero = A_CASA3_MENOR and a3ME.Naipe = A_CASA3_NAIPE) '+
            'join ARCANOS_MENORES b1ME on(b1ME.Numero = B_CASA1_MENOR and b1ME.Naipe = B_CASA1_NAIPE) '+
            'join ARCANOS_MENORES b2ME on(b2ME.Numero = B_CASA2_MENOR and b2ME.Naipe = B_CASA2_NAIPE) '+
            'join ARCANOS_MENORES b3ME on(b3ME.Numero = B_CASA3_MENOR and b3ME.Naipe = B_CASA3_NAIPE) '+
            'WHERE Id in (select idJogo from JOGOS_PARTIDAS where idPartida = '+lsPartida+')'+
            'order by Id';

   try
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.Open;
   except
      DM.FDQuery1.Close;
      Screen.Cursor := crDefault;
      MessageDlg('Erro consulta tabela LOTECA_2019.'+#13#10+'SQL = '+lsSQL,mtError,[mbOk],0);
      Exit;
   end;

   if (DM.FDQuery1.bof and DM.FDQuery1.Eof) then
   begin
      Screen.Cursor := crDefault;
      MessageDlg('Não há nenhum jogo sem resultado!',mtInformation,[mbOk],0);
      Exit;
   end
   else
   begin
      RadioGroupResultado.ItemIndex := -1;

      //agora preenche o StringGrid
      while not DM.FDQuery1.Eof do
      begin
         StringGrid1.RowCount := StringGrid1.RowCount + 1;
         StringGrid1.Cells[00,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('Vitoria').AsString;
         StringGrid1.Cells[01,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('A1MENOR').AsString;
         StringGrid1.Cells[02,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('A2MENOR').AsString;
         StringGrid1.Cells[03,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('A3MENOR').AsString;
         StringGrid1.Cells[04,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('B1MENOR').AsString;
         StringGrid1.Cells[05,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('B2MENOR').AsString;
         StringGrid1.Cells[06,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('B3MENOR').AsString;
         StringGrid1.Cells[07,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('Id').AsString;
         DM.FDQuery1.Next;
      end;
      Screen.Cursor := crDefault;
   end;
   Screen.Cursor := crDefault;
end;

procedure TFAlteracaoPartidaSemResultado.ComboBoxPartidasChange(
  Sender: TObject);
begin
   CarregarGrid;
end;

procedure TFAlteracaoPartidaSemResultado.BitBtnAlterarClick(Sender: TObject);
var lsSQL, lsPartida: string;
    lsVitoria: string;
begin
   if (RadioGroupResultado.ItemIndex = -1) then
   begin
      MessageDlg('Escolha um resultado para os jogos a serem alterados!',mtWarning,[mbOk],0);
      RadioGroupResultado.SetFocus;
      Exit;
   end;

   case RadioGroupResultado.ItemIndex of
      0: lsVitoria := 'Time A';
      1: lsVitoria := 'Time B';
      2: lsVitoria := 'Empate';
      3: lsVitoria := 'sem resultado';
   end;

   if (MessageDlg('Tem certeza que quer alterar os jogos selecionados para vitória = '+lsVitoria+'?',mtConfirmation,[mbYes,mbNo],0) = mrNo) then
   begin
      Exit;
   end;

   Screen.Cursor := crSQLWait;

   lsPartida := ComboBoxPartidas.Items[ComboBoxPartidas.ItemIndex];
   lsPartida := Copy(lsPartida,1,Pos(' - ',lsPartida)-1);

   //prepara o SQL
   case RadioGroupResultado.ItemIndex of
      0: lsSQL := 'UPDATE LOTECA_2019 set VITORIA = ''A'' ';
      1: lsSQL := 'UPDATE LOTECA_2019 set VITORIA = ''B'' ';
      2: lsSQL := 'UPDATE LOTECA_2019 set VITORIA = ''E'' ';
      3: lsSQL := 'UPDATE LOTECA_2019 set VITORIA = null ';
   end; //case

   lsSQL := lsSQL + 'where Id in (select idJogo from JOGOS_PARTIDAS where idPartida = '+lsPartida+')';

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
   CarregarGrid;
end;

procedure TFAlteracaoPartidaSemResultado.LimparGrid;
var liLin, liCol: integer;
begin
   //limpar dados
   RadioGroupResultado.ItemIndex := -1;

   for liLin := 0 to StringGrid1.RowCount-1 do
      for liCol := 0 to StringGrid1.ColCount-1 do
         StringGrid1.Cells[liCol, liLin] := '';
   StringGrid1.RowCount := 1;
end;

end.


