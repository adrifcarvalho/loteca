unit UConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, SqlExpr, Buttons, Grids, DBGrids,
  ExtCtrls, uDM, ComCtrls,  System.UITypes, FireDAC.UI.Intf,
  FireDAC.FMXUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI;

type
  TFConsulta = class(TForm)
    Panel52: TPanel;
    Label34: TLabel;
    Label1: TLabel;
    btnExcluir: TBitBtn;
    EditId: TEdit;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    btnFiltrar: TBitBtn;
    btnLimpar: TBitBtn;
    StringGrid1: TStringGrid;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel12: TPanel;
    Panel10: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    procedure CarregarGrid;
    procedure LimparGrids;
  public
    { Public declarations }
  end;

var
  FConsulta: TFConsulta;

implementation

{$R *.dfm}

procedure TFConsulta.FormShow(Sender: TObject);
begin
   CarregarGrid;
end;


procedure TFConsulta.btnFiltrarClick(Sender: TObject);
var liLin: integer;
    lbAchou: Boolean;
begin
   try
      StrToInt(EditId.Text);
   except
      MessageDlg('Informe um número válido!',mtWarning,[mbOk],0);
      EditId.SetFocus;
      Exit;
   end;

   lbAchou := False;
   for liLin := 0 to StringGrid1.RowCount-1 do
   begin
      StringGrid1.Row := liLin;
      if (StrToInt(EditId.Text) = StrToInt(StringGrid1.Cells[13,liLin])) then
      begin
         StringGrid1.Col := 0;
         StringGrid1.ScrollBy(0,liLin);
         StringGrid1.Perform(EM_LINESCROLL,0,StringGrid1.Row);
         StringGrid1.SetFocus;
         Exit;
      end;
   end;

   if not(lbAchou) then
   begin
      MessageDlg('Jogo não encontrado!',mtInformation,[mbOk],0);
      EditId.SetFocus;
   end;
end;

procedure TFConsulta.btnLimparClick(Sender: TObject);
begin
   EditId.Clear;
   CarregarGrid;
end;

procedure TFConsulta.LimparGrids;
var liLin,liCol: integer;
begin
   for liLin := 0 to StringGrid1.RowCount-1 do
      for liCol := 0 to StringGrid1.ColCount-1 do
         StringGrid1.Cells[liCol,liLin] := '';
   StringGrid1.RowCount := 1;
end;

procedure TFConsulta.CarregarGrid;
var lsSQL: string;
begin
   //limpa o StringGrid
   LimparGrids;

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
            'order by Id DESC';

   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add(lsSQL);
   DM.FDQuery1.Open;

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
         DM.FDQuery1.Next;
      end;
      Screen.Cursor := crDefault;
   EditId.SetFocus;
end;

procedure TFConsulta.btnExcluirClick(Sender: TObject);
var lsSQL: string;
begin
   if (Trim(EditId.Text) = '') then
   begin
      MessageDlg('Informe o Id do jogo a ser excluído!',mtWarning,[mbOk],0);
      EditId.SetFocus;
      Exit;
   end;

   if (StrToIntDef(EditId.Text,0) = 0) then
   begin
      MessageDlg('Digite um número válido!',mtWarning,[mbOk],0);
      EditId.SetFocus;
      Exit;
   end;

  if (MessageDlg('Tem certeza que deseja excluir o jogo de número '+EditId.Text+'?',mtConfirmation,[mbYes,mbNo],0) = mrNo) then
     Exit;

   Screen.Cursor := crSQLWait;
   //prepara o SQL
   lsSQL := 'DELETE FROM LOTECA_2019 where Id = '+EditId.Text;

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

procedure TFConsulta.StringGrid1Click(Sender: TObject);
begin
   if (StringGrid1.Cells[08,StringGrid1.Row] = 'X') then
      StringGrid1.Cells[08,StringGrid1.Row] := ''
   else
      StringGrid1.Cells[08,StringGrid1.Row] := 'X';
   EditId.SetFocus;
end;

procedure TFConsulta.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
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

end.


