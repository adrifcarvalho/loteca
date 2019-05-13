unit UConsultaPartida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, SqlExpr, Buttons, Grids, DBGrids,
  ExtCtrls, uDM, ComCtrls, System.UITypes, FireDAC.UI.Intf,
  FireDAC.FMXUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI, Vcl.Mask,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFConsultaPartida = class(TForm)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Panel52: TPanel;
    btnLimpar: TBitBtn;
    btnExcluir: TBitBtn;
    ComboBoxPartidas: TComboBox;
    Label45: TLabel;
    MaskEditData: TMaskEdit;
    Label44: TLabel;
    Label43: TLabel;
    btnExibir: TBitBtn;
    FDQuery1: TFDQuery;
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
    procedure MaskEditDataChange(Sender: TObject);
    procedure btnExibirClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure ComboBoxPartidasChange(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    procedure LimparGrid;
  public
    { Public declarations }
  end;

var
  FConsultaPartida: TFConsultaPartida;

implementation

{$R *.dfm}

procedure TFConsultaPartida.btnLimparClick(Sender: TObject);
begin
   MaskEditData.Text := '  /  /    ';
   ComboBoxPartidas.Items.Clear;
   ComboBoxPartidas.Enabled := False;
   ComboBoxPartidas.ItemIndex := -1;

   LimparGrid;
end;

procedure TFConsultaPartida.ComboBoxPartidasChange(Sender: TObject);
begin
   LimparGrid;
end;

procedure TFConsultaPartida.LimparGrid;
var liLin, liCol: integer;
begin
   for liLin := 0 to StringGrid1.RowCount-1 do
      for liCol := 0 to StringGrid1.ColCount-1 do
         StringGrid1.Cells[liCol,liLin] := '';
   StringGrid1.RowCount := 1;
end;

procedure TFConsultaPartida.MaskEditDataChange(Sender: TObject);
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

procedure TFConsultaPartida.btnExibirClick(Sender: TObject);
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

   lsPartida := ComboBoxPartidas.Items[ComboBoxPartidas.ItemIndex];
   lsPartida := Copy(lsPartida,1,Pos(' - ',lsPartida)-1);

   LimparGrid;

   Screen.Cursor := crHourGlass;
   //encontra os jogos da partida. Para cada jogo, alimentar os grids com os padrões
   try
      FDQuery1.Close;
      FDQuery1.ParamByName('lsPartida').AsString := lsPartida;
      FDQuery1.Open;
   except
      MessageDlg('Erro consulta à tabela LOTECA'+#13#10+'SQL = '+lsSQL, mtError, [mbOk], 0);
      FDQuery1.Close;
      Screen.Cursor := crDefault;
      Exit;
   end;

   while not FDQuery1.Eof do
   begin
      with StringGrid1 do
      begin
         RowCount := RowCount + 1;
         Cells[00,RowCount-1] := FDQuery1.FieldByName('Vitoria').AsString;
         Cells[01,RowCount-1] := FDQuery1.FieldByName('A1MENOR').AsString;
         Cells[02,RowCount-1] := FDQuery1.FieldByName('A2MENOR').AsString;
         Cells[03,RowCount-1] := FDQuery1.FieldByName('A3MENOR').AsString;
         Cells[04,RowCount-1] := FDQuery1.FieldByName('B1MENOR').AsString;
         Cells[05,RowCount-1] := FDQuery1.FieldByName('B2MENOR').AsString;
         Cells[06,RowCount-1] := FDQuery1.FieldByName('B3MENOR').AsString;
         Cells[07,RowCount-1] := FDQuery1.FieldByName('Id').AsString;
      end;
      FDQuery1.Next;
   end;
   Screen.Cursor := crDefault;
end;

procedure TFConsultaPartida.StringGrid1DrawCell(Sender: TObject; ACol,
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

end.


