unit UInformarPartida;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.UITypes,
  Vcl.ComCtrls, Vcl.Mask, Vcl.ExtCtrls, uDM, uInformarTime, Vcl.ExtDlgs,
  Vcl.FileCtrl;

type
  TFInformarPartida = class(TForm)
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    LabelA1: TLabel;
    RadioGroupSelection: TRadioGroup;
    LabelB1: TLabel;
    LabelB2: TLabel;
    mkDataJogo: TMaskEdit;
    ComboBoxPartidas: TComboBox;
    LabelB3: TLabel;
    mkNovoJogo: TMaskEdit;
    OpenPictureDialog1: TOpenPictureDialog;
    GroupBoxTimeA: TGroupBox;
    ImageTimeA: TImage;
    edTimeA: TEdit;
    SpeedButtonTimeA: TSpeedButton;
    SpeedButtonImgA: TSpeedButton;
    Shape1: TShape;
    GroupBoxTimeB: TGroupBox;
    Shape2: TShape;
    ImageTimeB: TImage;
    edTimeB: TEdit;
    SpeedButtonTimeB: TSpeedButton;
    SpeedButtonImgB: TSpeedButton;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroupSelectionClick(Sender: TObject);
    procedure mkDataJogoChange(Sender: TObject);
    procedure mkNovoJogoEnter(Sender: TObject);
    procedure SpeedButtonTimeAClick(Sender: TObject);
    procedure SpeedButtonTimeBClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButtonImgAClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButtonImgBClick(Sender: TObject);
    procedure ComponentEnter(Sender: TObject);
    procedure ComponentExit(Sender: TObject);
  private
    { Private declarations }
   procedure Copia(fOrigem, fDestino: string);
  public
    { Public declarations }
    giPartida: integer;
    gsTimeA, gsTimeB, gsData, gsImgA, gsImgB: string;
    function TimeASel: string;
    function TimeBSel: string;
    function DataSel : string;
    function PartidaSel: integer;
    function ImagemTimeASel: string;
    function ImagemTimeBSel: string;
  end;

var
  FInformarPartida: TFInformarPartida;

const ap = Chr(39);

implementation


{$R *.dfm}

procedure TFInformarPartida.FormShow(Sender: TObject);
begin
   RadioGroupSelection.ItemIndex := -1;
   edTimeA.Clear;
   edTimeB.Clear;
   mkNovoJogo.Text := DateToStr(Date);
   RadioGroupSelection.SetFocus;
   Height := 173;
end;

procedure TFInformarPartida.btnOkClick(Sender: TObject);
var lsSQL, lsNameImg, lsTipoImg, lsPartida: string;
    liInd: integer;
begin
   if (RadioGroupSelection.ItemIndex = -1) then
   begin
      MessageDlg('Selecione o tipo de jogo!',mtWarning,[mbOk],0);
      RadioGroupSelection.SetFocus;
      ModalResult := mrNone;
      Exit;
   end;

   if (RadioGroupSelection.ItemIndex = 0) then
   begin
      if (mkNovoJogo.Text = '  /  /    ') then
      begin
         MessageDlg('Informe a data do jogo!', mtWarning,[mbOk],0);
         mkNovoJogo.SetFocus;
         ModalResult := mrNone;
         Exit;
      end;

      try
         StrToDate(mkNovoJogo.Text);
      except
         MessageDlg('Data inválida!',mtWarning,[mbOk],0);
         mkNovoJogo.SetFocus;
         ModalResult := mrNone;
         Exit;
      end;

      if (Trim(edTimeA.Text) = '') then
      begin
         MessageDlg('Informe o nome do Time A!',mtWarning,[mbOk],0);
         edTimeA.SetFocus;
         ModalResult := mrNone;
         Exit;
      end;

      if (Trim(edTimeB.Text) = '') then
      begin
         MessageDlg('Informe o nome do Time B!',mtWarning,[mbOk],0);
         edTimeB.SetFocus;
         ModalResult := mrNone;
         Exit;
      end;

      if (edTimeB.Text = edTimeA.Text) then
      begin
         MessageDlg('Time A não pode ser igual ao time B!',mtWarning,[mbOk],0);
         edTimeB.SetFocus;
         ModalResult := mrNone;
         Exit;
      end;

      if (edTimeA.Tag = 0) then //novo time
      begin
         if (edTimeA.Hint <> '') then //informou nova imagem, gravar
         begin
            try
               //pegar o último índice
               DM.FDQuery1.Close;
               DM.FDQuery1.SQL.Clear;
               DM.FDQuery1.SQL.Add('select MAX(Idtime) as MaxId from TIMES');
               DM.FDQuery1.Open;
               liInd := DM.FDQuery1.FieldByName('MaxId').AsInteger+1;
               DM.FDQuery1.Close;

               //agora salva a nova imagem com o nome do time informado
               lsTipoImg := Copy(edTimeA.Hint,Pos('.',edTimeA.Hint),length(edTimeA.Hint));
               lsNameImg := FormatFloat('00', liInd)+'_'+edTimeA.Text+lsTipoImg;
               lsSQL := 'insert into TIMES values('+IntToStr(liInd)+
                        ', '''+edTimeA.Text+''', '''+lsNameImg+''')';
               DM.FDQuery1.SQL.Clear;
               DM.FDQuery1.SQL.Add(lsSQL);
               DM.FDQuery1.ExecSQL;
               DM.FDQuery1.Close;

               //copia a imagem para o diretório padrão
               Copia(gsImgA+edTimeA.Hint, ExtractFilePath(Application.ExeName)+'timeimg\'+lsNameImg);
               gsImgA := lsNameImg;
            except
               Screen.Cursor := crDefault;
               DM.FDConnection1.Rollback;
               MessageDlg('Erro na gravação das imagens.',mtError,[mbOk],0);
               Exit;
            end;
         end;
      end;

      if (edTimeB.Tag = 0) then //novo time
      begin
         if (edTimeB.Hint <> '') then //informou nova imagem, gravar
         begin
            try
               //pegar o último índice
               DM.FDQuery1.Close;
               DM.FDQuery1.SQL.Clear;
               DM.FDQuery1.SQL.Add('select MAX(Idtime) as MaxId from TIMES');
               DM.FDQuery1.Open;
               liInd := DM.FDQuery1.FieldByName('MaxId').AsInteger+1;
               DM.FDQuery1.Close;

               //agora salva a nova imagem com o nome do time informado
               lsTipoImg := Copy(edTimeB.Hint,Pos('.',edTimeB.Hint),length(edTimeB.Hint));
               lsNameImg := FormatFloat('00', liInd)+'_'+edTimeB.Text+lsTipoImg;
               lsSQL := 'insert into TIMES values('+IntToStr(liInd)+
                        ', '''+edTimeB.Text+''', '''+lsNameImg+''')';
               DM.FDQuery1.SQL.Clear;
               DM.FDQuery1.SQL.Add(lsSQL);
               DM.FDQuery1.ExecSQL;
               DM.FDQuery1.Close;

               //copia a imagem para o diretório padrão
               Copia(gsImgB+edTimeB.Hint, ExtractFilePath(Application.ExeName)+'timeimg\'+lsNameImg);
               gsImgB := lsNameImg;
            except
               Screen.Cursor := crDefault;
               DM.FDConnection1.Rollback;
               MessageDlg('Erro na gravação das imagens.',mtError,[mbOk],0);
               Exit;
            end;
         end;
      end;
   end;

   if (RadioGroupSelection.ItemIndex = 1) then
   begin
      if (mkDataJogo.Text = '  /  /    ') then
      begin
         MessageDlg('Informe a data do jogo!', mtWarning,[mbOk],0);
         mkDataJogo.SetFocus;
         ModalResult := mrNone;
         Exit;
      end;

      try
         StrToDate(mkDataJogo.Text);
      except
         MessageDlg('Data inválida!',mtWarning,[mbOk],0);
         mkDataJogo.SelStart := 0;
         mkDataJogo.SelectAll;
         mkDataJogo.SetFocus;
         ModalResult := mrNone;
         Exit;
      end;

      if (ComboBoxPartidas.ItemIndex = -1) then
      begin
         MessageDlg('Escolha uma partida!', mtWarning, [mbOk], 0);
         ComboBoxPartidas.SetFocus;
         ModalResult := mrNone;
         Exit;
      end;

      lsPartida := ComboBoxPartidas.Items[ComboBoxPartidas.ItemIndex];
      lsPartida := Copy(lsPartida,1,Pos(' - ',lsPartida)-1);

      Screen.Cursor := crHourGlass;
      //encontra A PARTIDA
      try
         lsSQL := 'select * from PARTIDAS where idPartida = '+lsPartida;
         DM.FDQuery1.Close;
         DM.FDQuery1.SQL.Clear;
         DM.FDQuery1.SQL.Add(lsSQL);
         DM.FDQuery1.Open;
      except
         MessageDlg('Erro consulta à tabela LOTECA'+#13#10+'SQL = '+lsSQL, mtError, [mbOk], 0);
         DM.FDQuery1.Close;
         Screen.Cursor := crDefault;
         ModalResult := mrNone;
         Exit;
      end;

      gsTimeA := DM.FDQuery1.FieldByName('timeA').AsString;
      gsTimeB := DM.FDQuery1.FieldByName('timeB').AsString;
      gsData  := DM.FDQuery1.FieldByName('data_partida').AsString;
      giPartida := DM.FDQuery1.FieldByName('idPartida').AsInteger;
   end;
end;

procedure TFInformarPartida.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TFInformarPartida.FormCreate(Sender: TObject);
begin
   FormatSettings.ShortDateFormat := 'DD/MM/YYYY';
end;

procedure TFInformarPartida.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (key = #13) then
   begin
      Perform(wm_NextDlgCtl,0,0);
   end;
end;

procedure TFInformarPartida.mkDataJogoChange(Sender: TObject);
var lsSQL, lsData: string;
begin
   if (Length(Trim(mkDataJogo.Text)) <> 10) then Exit;

   if (mkDataJogo.Text = '  /  /    ') then
   begin
      MessageDlg('Informe a data do jogo!', mtWarning,[mbOk],0);
      mkDataJogo.SelStart := 0;
      mkDataJogo.SelectAll;
      mkDataJogo.SetFocus;
      Exit;
   end;

   try
      StrToDate(mkDataJogo.Text);
   except
      MessageDlg('Data inválida!', mtWarning,[mbOk],0);
      mkDataJogo.SelStart := 0;
      mkDataJogo.SelectAll;
      mkDataJogo.SetFocus;
      Exit;
   end;

   lsData := mkDataJogo.Text;
   lsData := Copy(lsData,7,4)+'-'+Copy(lsData,4,2)+'-'+Copy(lsData,1,2);

   try
      lsSQL := 'select * from PARTIDAS where data_partida = '+AP+lsData+AP+
               ' order by idPartida';
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.Open;

      ComboBoxPartidas.Items.Clear;
      if not (DM.FDQuery1.Eof and DM.FDQuery1.Bof) then
         ComboBoxPartidas.SetFocus
      else
      begin
         MessageDlg('Não há jogos na data informada!',mtWarning,[mbOk],0);
         mkDataJogo.Text := '  /  /    ';
         mkDataJogo.SelStart := 0;
         mkDataJogo.SelectAll;
         mkDataJogo.SetFocus;
         Exit;
      end;

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

procedure TFInformarPartida.mkNovoJogoEnter(Sender: TObject);
begin
   mkNovoJogo.SelStart := 0;
   mkNovoJogo.SelectAll;
   mkNovoJogo.Color := clYellow;
end;

procedure TFInformarPartida.RadioGroupSelectionClick(Sender: TObject);
begin
   edTimeA.Hint := '';
   edTimeA.Clear;
   edTimeB.Hint := '';
   edTimeB.Clear;
   mkDataJogo.Clear;
   mkNovoJogo.Text := DateToStr(Date);

   case RadioGroupSelection.ItemIndex of
      0: //novo jogo
      begin
         FInformarPartida.Height := 472;
         LabelA1.Visible := True;
         GroupBoxTimeA.Visible := True;
         GroupBoxTimeB.Visible := True;
         mkNovoJogo.Visible := True;
(*         edTimeA.Visible := True;
         edTimeB.Visible := True;
         SpeedButtonTimeA.Visible := True;
         SpeedButtonTimeB.Visible := True;
*)
         mkNovoJogo.SetFocus;

         LabelB1.Visible := False;
         LabelB2.Visible := False;
         LabelB3.Visible := False;
         mkDataJogo.Visible := False;
         ComboBoxPartidas.Visible := False;

         LabelB1.Top := 368;
         LabelB2.Top := 394;
         LabelB3.Top := 394;
         mkDataJogo.Top := 414;
         ComboBoxPartidas.Top := 414;
      end;
      1: //jogo existente
      begin
         FInformarPartida.Height := 276;
         LabelA1.Visible := False;
         GroupBoxTimeA.Visible := False;
         GroupBoxTimeB.Visible := False;
         mkNovoJogo.Visible := False;
(*         edTimeA.Visible := False;
         edTimeB.Visible := False;
         SpeedButtonTimeA.Visible := False;
         SpeedButtonTimeB.Visible := False;
*)
         LabelB1.Visible := True;
         LabelB2.Visible := True;
         LabelB3.Visible := True;
         mkDataJogo.Visible := True;
         ComboBoxPartidas.Visible := True;

         LabelB1.Top := 156;
         LabelB2.Top := 182;
         LabelB3.Top := 182;
         mkDataJogo.Top := 202;
         ComboBoxPartidas.Top := 202;
         mkDataJogo.SetFocus;
      end;
   end;
end;

procedure TFInformarPartida.SpeedButtonImgAClick(Sender: TObject);
begin
   if (Trim(edTimeA.Text) = '') then
   begin
      MessageDlg('Informe o nome do time!', mtWarning,[mbOk],0);
      edTimeA.Color := clYellow;
      edTimeA.SetFocus;
   end
   else
   begin
      edTimeA.Color := clWhite;

      if (OpenPictureDialog1.Execute) then
      begin
         if FileExists(OpenPictureDialog1.FileName) then
         begin
            gsImgA := ExtractFilePath(OpenPictureDialog1.FileName);
            edTimeA.Hint := ExtractFileName(OpenPictureDialog1.FileName);
            ImageTimeA.Picture.LoadFromFile(OpenPictureDialog1.FileName);
         end;
      end;
   end;
end;

procedure TFInformarPartida.SpeedButtonImgBClick(Sender: TObject);
begin
   if (Trim(edTimeB.Text) = '') then
   begin
      MessageDlg('Informe o nome do time!', mtWarning,[mbOk],0);
      edTimeB.Color := clYellow;
      edTimeB.SetFocus;
   end
   else
   begin
      edTimeB.Color := clWhite;

      if (OpenPictureDialog1.Execute) then
      begin
         if FileExists(OpenPictureDialog1.FileName) then
         begin
            gsImgB := ExtractFilePath(OpenPictureDialog1.FileName);
            edTimeB.Hint := ExtractFileName(OpenPictureDialog1.FileName);
            ImageTimeB.Picture.LoadFromFile(OpenPictureDialog1.FileName);
         end;
      end;
   end;
end;

procedure TFInformarPartida.SpeedButtonTimeAClick(Sender: TObject);
begin
   FInformarTime := TFInformarTime.Create(Self);
   FInformarTime.ShowModal;
   if (FInformarTime.ModalResult = mrOk) then
   begin
      edTimeA.Text := FInformarTime.TimeSelecionado;
      edTimeA.Hint := FInformarTime.ImagemSelecionada;
      edTimeA.Tag  := FInformarTime.IndiceSelecionado;
      ImageTimeA.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'timeimg\'+edTimeA.Hint);
      gsImgA := edTimeA.Hint;
      FInformarTime.Close;
   end;
end;

procedure TFInformarPartida.SpeedButtonTimeBClick(Sender: TObject);
begin
   FInformarTime := TFInformarTime.Create(Self);
   FInformarTime.ShowModal;
   if (FInformarTime.ModalResult = mrOk) then
   begin
      edTimeB.Text := FInformarTime.TimeSelecionado;
      edTimeB.Hint := FInformarTime.ImagemSelecionada;
      edTimeB.Tag  := FInformarTime.IndiceSelecionado;
      ImageTimeB.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'timeimg\'+edTimeB.Hint);
      gsImgB := edTimeB.Hint;
      FInformarTime.Close;
   end;
end;

function TFInformarPartida.TimeASel: string;
begin
   case RadioGroupSelection.ItemIndex of
      0: result := edTimeA.Text;
      1: result := gsTimeA;
   end;
end;

function TFInformarPartida.TimeBSel: string;
begin
   case RadioGroupSelection.ItemIndex of
      0: result := edTimeB.Text;
      1: result := gsTimeB;
   end;
end;

function TFInformarPartida.DataSel: string;
begin
   case RadioGroupSelection.ItemIndex of
      0: result := Copy(mkNovoJogo.Text,7,4)+'-'+Copy(mkNovoJogo.Text,4,2)+'-'+Copy(mkNovoJogo.Text,1,2);
      1: result := gsData;
   end;
end;

procedure TFInformarPartida.ComponentEnter(Sender: TObject);
begin
   if (Sender is TEdit) then
      (Sender as TEdit).Color := clYellow;

   if (Sender is TMaskEdit) then
      (Sender as TMaskEdit).Color := clYellow;
end;

procedure TFInformarPartida.ComponentExit(Sender: TObject);
begin
   if (Sender is TEdit) then
      (Sender as TEdit).Color := clWhite;

   if (Sender is TMaskEdit) then
      (Sender as TMaskEdit).Color := clWhite;
end;

function TFInformarPartida.PartidaSel: integer;
begin
   case RadioGroupSelection.ItemIndex of
      0: result := 0;
      1: result := giPartida;
   end;
end;

function TFInformarPartida.ImagemTimeASel: string;
begin
   result := gsImgA;
end;

function TFInformarPartida.ImagemTimeBSel: string;
begin
   result := gsImgB;
end;

procedure TFInformarPartida.Copia(fOrigem, fDestino: string);
var
  FName:string;
  CopyBuffer: Pointer; { buffer for copying }
  TimeStamp, BytesCopied: Longint;
  Source, Dest: Integer; { handles }
label
  TentaAbrir,TentaCriar,TentaCopiar, Termina;
const
  ChunkSize: Longint = 32768;
begin
   {Screen.Cursor:=crHourGlass;}
   Fname := fOrigem;

   if FileExists(FName) then
     goto TentaAbrir
   else
   begin
     MessageDlg('Arquivo '+fOrigem+' nao Existe...', mtConfirmation,[mbOK],0);
     goto Termina;
   end;

   TentaAbrir:
   GetMem(CopyBuffer, ChunkSize); {  allocate the buffer }
   Source := FileOpen(FName, fmShareDenyWrite); { open source file }
   if Source < 0 then
   begin
      MessageDlg('Erro Abrindo o Banco '#13#10+FName,mtError,[mbOK],0);
      goto Termina;
   end
   else
      goto TentaCriar;

   TentaCriar:
   Dest := FileCreate(FDestino); { create output file}
   if Dest < 0 then
   begin
      MessageDlg('Error na criação do Destino '+fDestino,mtError,[mbOK],0);
      goto Termina;
   end
   else
      goto TentaCopiar;

   TentaCopiar:
{     try}
   repeat
     {$I-}
     BytesCopied := FileRead(Source, CopyBuffer^, ChunkSize); { read chunk }
     {$I+}
     if IOResult <> 0 then
     begin
       MessageDlg('Error Lendo Origem...'#13#10+FName,mtError,[mbOK],0);
       goto Termina;
     end;

     if BytesCopied > 0 then
     begin{ se consiguiu ler algo... }
       {$I-}
       FileWrite(Dest, CopyBuffer^, BytesCopied); { ...write chunk }
       {$I+}
       if IOResult <> 0 then
       begin
         MessageDlg('Erro Escrevendo no Temporário...'#13#10+FName,mtError,[mbOK],0);
         goto Termina;
       end;
     end;
   until BytesCopied < ChunkSize; { until we run out of chunks }

   FileSetDate(Dest, TimeStamp);
   FileClose(Dest); { close the destination file }
   FileClose(Source); { close the destination file }
   FreeMem(CopyBuffer, ChunkSize);
   Screen.Cursor:=crDefault;
   Termina:
end;

end.
