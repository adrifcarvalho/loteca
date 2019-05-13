unit UAlteracaoSemResultado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, SqlExpr, Buttons, Grids, DBGrids,
  ExtCtrls, uDM, ComCtrls, System.UITypes, FireDAC.UI.Intf,
  FireDAC.FMXUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI, Vcl.Imaging.GIFImg;

type
  TFAlteracaoSemResultado = class(TForm)
    Panel52: TPanel;
    Label34: TLabel;
    RadioGroupResultado: TRadioGroup;
    BitBtnAlterar: TBitBtn;
    btnFiltrar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn2: TBitBtn;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
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
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
    procedure BitBtnInserirClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    procedure CarregarGrid;
  public
    { Public declarations }
  end;

var
  FAlteracaoSemResultado: TFAlteracaoSemResultado;

implementation

{$R *.dfm}

procedure TFAlteracaoSemResultado.FormShow(Sender: TObject);
begin
   CarregarGrid;
end;

procedure TFAlteracaoSemResultado.StringGrid1Click(Sender: TObject);
begin
   if (StringGrid1.Cells[08,StringGrid1.Row] = 'X') then
      StringGrid1.Cells[08,StringGrid1.Row] := ''
   else
      StringGrid1.Cells[08,StringGrid1.Row] := 'X';
   RadioGroupResultado.SetFocus;
end;

procedure TFAlteracaoSemResultado.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var lcColor:TColor;
begin
   StringGrid1.Canvas.Font.Color := clBlack;
   lcColor:= clWhite;

   if (StringGrid1.Cells[08, ARow] = 'X') then
   begin
      lcColor := clRed;
      if (ACol = 08) then
         StringGrid1.Canvas.Font.Color := clred
      else
         StringGrid1.Canvas.Font.Color := clWhite;
   end;
   // Fill rectangle with colour
   StringGrid1.Canvas.Brush.Color := lcColor;
   StringGrid1.Canvas.FillRect(Rect);
   StringGrid1.Canvas.TextOut(Rect.Left+2,Rect.Top+2,StringGrid1.Cells[ACol, ARow]);

end;

procedure TFAlteracaoSemResultado.CarregarGrid;
var lsSQL: string;
    liLin, liCol: integer;
begin
   //limpar dados
   RadioGroupResultado.ItemIndex := -1;

   for liLin := 0 to StringGrid1.RowCount-1 do
      for liCol := 0 to StringGrid1.ColCount-1 do
         StringGrid1.Cells[liCol, liLin] := '';
   StringGrid1.RowCount := 1;

   Screen.Cursor := crSQLWait;

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
            'WHERE vitoria is null '+
            'order by Id';

   try
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.Open;
   except
      DM.FDQuery1.Close;
      Screen.Cursor := crDefault;
      MessageDlg('Erro consulta tabela LOTECA.'+#13#10+'SQL = '+lsSQL,mtError,[mbOk],0);
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
         if not((StringGrid1.RowCount = 1) and (StringGrid1.Cells[1,0] = '')) then
            StringGrid1.RowCount := StringGrid1.RowCount + 1;

         StringGrid1.Cells[00,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('Vitoria').AsString;
         StringGrid1.Cells[01,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('A1MENOR').AsString;
         StringGrid1.Cells[02,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('A2MENOR').AsString;
         StringGrid1.Cells[03,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('A3MENOR').AsString;
         StringGrid1.Cells[04,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('B1MENOR').AsString;
         StringGrid1.Cells[05,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('B2MENOR').AsString;
         StringGrid1.Cells[06,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('B3MENOR').AsString;
         StringGrid1.Cells[07,StringGrid1.RowCount-1] := DM.FDQuery1.FieldByName('Id').AsString;
         StringGrid1.Cells[08,StringGrid1.RowCount-1] := '';

         DM.FDQuery1.Next;
      end;
      Screen.Cursor := crDefault;
   end;
   Screen.Cursor := crDefault;
end;

procedure TFAlteracaoSemResultado.BitBtnInserirClick(Sender: TObject);
var liLin: longint;
    lsSQL: string;
    lbPriVez: Boolean;
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
   end;

   if (MessageDlg('Tem certeza que quer alterar os jogos selecionados para vitória = '+lsVitoria+'?',mtConfirmation,[mbYes,mbNo],0) = mrNo) then
   begin
      Exit;
   end;

   Screen.Cursor := crSQLWait;
   //prepara o SQL
   lsSQL := 'UPDATE LOTECA_2019 set VITORIA = ';

   case RadioGroupResultado.ItemIndex of
      0: lsSQL := lsSQL + '''A'' ';
      1: lsSQL := lsSQL + '''B'' ';
      2: lsSQL := lsSQL + '''E'' ';
   end; //case

   lbPriVez := True;

   for liLin := 0 to StringGrid1.RowCount-1 do
   begin
      if (StringGrid1.Cells[08,liLin] = 'X') then
      begin
         if (lbPriVez) then
         begin
            lsSQL := lsSQL + 'where Id in('+StringGrid1.Cells[07,liLin];
            lbPriVez := False;
         end
         else
            lsSQL := lsSQL + ', '+StringGrid1.Cells[13,liLin];
      end;
   end;
   lsSQL := lsSQL + ')';

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

procedure TFAlteracaoSemResultado.btnFiltrarClick(Sender: TObject);
var liLin: integer;
    lsSQL: string;
    lbPriVez: Boolean;
begin
  if (MessageDlg('Tem certeza que deseja excluir o(s) jogo(s) selecionado(s)?',mtConfirmation,[mbYes,mbNo],0) = mrNo) then
     Exit;

   Screen.Cursor := crSQLWait;
   //prepara o SQL
   lsSQL := 'DELETE FROM LOTECA_2019 ';
   lbPriVez := True;

   for liLin := 0 to StringGrid1.RowCount-1 do
   begin
      if (StringGrid1.Cells[14,liLin] = 'X') then
      begin
         if (lbPriVez) then
         begin
            lsSQL := lsSQL + 'where Id in('+StringGrid1.Cells[13,liLin];
            lbPriVez := False;
         end
         else
            lsSQL := lsSQL + ', '+StringGrid1.Cells[13,liLin];
      end;
   end;
   lsSQL := lsSQL + ')';

   try
      DM.FDConnection1.StartTransaction;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.ExecSQL;
   except
      Screen.Cursor := crDefault;
      DM.FDConnection1.Rollback;
      MessageDlg('Erro na exclusão'+#13+#10+lsSQL, mtError,[mbOk],0);
      Exit;
   end;

   Screen.Cursor := crDefault;
   MessageDlg('Exclusão efetuada com sucesso!',mtInformation,[mbOk],0);
   DM.FDConnection1.Commit;
   CarregarGrid;
end;

procedure TFAlteracaoSemResultado.BitBtn2Click(Sender: TObject);
var lsSQL: string;
begin
  if (MessageDlg('Tem certeza que deseja excluir TODOS os jogo sem resultado?',mtConfirmation,[mbYes,mbNo],0) = mrNo) then
     Exit;

   Screen.Cursor := crSQLWait;
   //prepara o SQL
   lsSQL := 'DELETE FROM LOTECA_2019 WHERE Vitoria is null';

   try
      DM.FDConnection1.StartTransaction;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.ExecSQL;
   except
      Screen.Cursor := crDefault;
      DM.FDConnection1.Rollback;
      MessageDlg('Erro na exclusão'+#13+#10+lsSQL, mtError,[mbOk],0);
      Exit;
   end;

   Screen.Cursor := crDefault;
   MessageDlg('Exclusão efetuada com sucesso!',mtInformation,[mbOk],0);
   DM.FDConnection1.Commit;
   CarregarGrid;
end;

end.


