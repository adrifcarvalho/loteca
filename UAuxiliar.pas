unit UAuxiliar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, uDM, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.FMXUI.Wait, FireDAC.UI.Intf, FireDAC.Comp.UI,
  Vcl.FileCtrl;

type
  TFAuxiliar = class(TForm)
    btnArcMaior: TButton;
    btnCargaPlanilha: TButton;
    Memo1: TMemo;
    Button6: TButton;
    FDQuery1: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    btnArcMenor: TButton;
    Button1: TButton;
    FDQuery2: TFDQuery;
    Button2: TButton;
    FileListBox1: TFileListBox;
    btnCarga: TButton;
    Label1: TLabel;
    procedure btnArcMaiorClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure btnArcMenorClick(Sender: TObject);
    procedure btnCargaPlanilhaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCargaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAuxiliar: TFAuxiliar;

implementation

{$R *.dfm}

procedure TFAuxiliar.btnArcMaiorClick(Sender: TObject);
var arq: TextFile; { declarando a variável "arq" do tipo arquivo texto }
    linha: string;
    lsSQL: string;
begin
   // Associa a variável do programa "arq" ao arquivo externo "tabuada.txt"
   // na unidade de disco "d"
   AssignFile(arq, 'E:\DESENV\SISTEMAS\PREVISOES\CREATE_BD\CARGA_ARCANOS_MAIORES.txt');

   {$I-}         // desativa a diretiva de Input
   Reset(arq);   // Abre o arquivo texto para leitura
   {$I+}         // ativa a diretiva de Input

   if (IOResult <> 0) then// verifica o resultado da operação de abertura
      ShowMessage('Erro na abertura do arquivo !!!')
   else
   begin
      // verifica se o ponteiro de arquivo atingiu a marca de final de arquivo
      while (not eof(arq)) do
      begin
         try
            DM.FDConnection1.StartTransaction;
            readln(arq, linha); // Lê uma linha do arquivo
            //Memo1.Lines.Add(linha);
            lsSQL := 'insert into ARCANOS_MAIORES values ('+linha+');';
            FDQuery1.Close;
            FDQuery1.SQL.Clear;
            FDQuery1.SQL.Add(lsSQL);
            FDQuery1.ExecSQL;
         except
            DM.FDConnection1.Rollback;
         end;
         DM.FDConnection1.Commit;
      end;

      CloseFile(arq); // Fecha o arquivo texto aberto
      ShowMessage('Acabou!');
   end;
end;

procedure TFAuxiliar.btnCargaPlanilhaClick(Sender: TObject);
var arq: TextFile; { declarando a variável "arq" do tipo arquivo texto }
    linha: string;
    lsSQL: string;
    liLin: integer;
begin
   // Associa a variável do programa "arq" ao arquivo externo "tabuada.txt"
   // na unidade de disco "d"
   AssignFile(arq, 'D:\Adriana\DESENV\SISTEMAS\LOTECA\Fontes versao 2019.01\LOTECA_rest.csv');

   {$I-}         // desativa a diretiva de Input
   Reset(arq);   // Abre o arquivo texto para leitura
   {$I+}         // ativa a diretiva de Input

   if (IOResult <> 0) then// verifica o resultado da operação de abertura
      ShowMessage('Erro na abertura do arquivo !!!')
   else
   begin
      liLin := 310;
      // verifica se o ponteiro de arquivo atingiu a marca de final de arquivo
      while (not eof(arq)) do
      begin
         inc(liLin);
         try
            DM.FDConnection1.StartTransaction;
            readln(arq, linha); // Lê uma linha do arquivo
            //linha := Copy(linha,2,length(linha)-3);
            lsSQL := 'insert into LOTECA_2019 values ('+IntToStr(liLin)+','+linha+')';
            FDQuery1.Close;
            FDQuery1.SQL.Clear;
            FDQuery1.SQL.Add(lsSQL);
            FDQuery1.ExecSQL;
         except
            ShowMessage('Erro');
            CloseFile(arq); // Fecha o arquivo texto aberto
            DM.FDConnection1.Rollback;
            Exit;
         end;
         DM.FDConnection1.Commit;
      end;

      CloseFile(arq); // Fecha o arquivo texto aberto
      ShowMessage('Acabou!');
   end;end;

procedure TFAuxiliar.Button1Click(Sender: TObject);
var lsSQL, lsData: string;
begin
   try
      lsSQL := 'select idPartida, data_partida from PARTIDAS';
      FDQuery1.Close;
      FDQuery1.SQL.Clear;
      FDQuery1.SQL.Add(lsSQL);
      FDQuery1.Open;

      while not FDQuery1.Eof do
      begin
         lsData := FDQuery1.FieldByName('data_partida').AsString;
         lsData := Copy(lsData,7,4)+'-'+Copy(lsData,4,2)+'-'+Copy(lsData,1,2);

         lsSQL := 'update PARTIDAS set data_partida = '''+lsData+''' where idPartida = '+FDQuery1.FieldByName('idPartida').AsString;
         FDQuery2.Close;
         FDQuery2.SQL.Clear;
         FDQuery2.SQL.Add(lsSQL);
         FDQuery2.ExecSQL;
         FDQuery2.Close;

         FDQuery1.Next;
      end;
   finally

   end;
end;

procedure TFAuxiliar.Button2Click(Sender: TObject);
var liCont, liPos: integer;
    lsSQL, lsInd, lsTime: string;
begin
   for liCont := 0 to FileListBox1.Items.Count-1 do
   begin
      lsInd  := Copy(FileListBox1.Items[liCont],1,2);
      liPos := Pos('.',FileListBox1.Items[liCont]);
      lsTime := UpperCase(Copy(FileListBox1.Items[liCont],4,liPos-4));
      lsSQL := 'insert into TIMES values('+lsInd+', '''+lsTime+''', '''+FileListBox1.Items[liCont]+''')';
      FDQuery1.Close;
      FDQuery1.SQL.Clear;
      FDQuery1.SQL.Add(lsSQL);
      FDQuery1.ExecSQL;
   end;
   ShowMessage('Acabou!');
end;

procedure TFAuxiliar.btnCargaClick(Sender: TObject);
var liCont, liPos, liPos_: integer;
    lsSQL, lsInd, lsTime: string;
begin
   Memo1.Lines.Clear;

   for liCont := 0 to FileListBox1.Items.Count-1 do
   begin
      liPos_ := Pos('_',FileListBox1.Items[liCont]);
      lsInd  := Copy(FileListBox1.Items[liCont],1,liPos_-1);
      //verifica se já existe na tabela
      lsSQL := 'select * from times where IdTime = '+lsInd;
      FDQuery1.Close;
      FDQuery1.SQL.Clear;
      FDQuery1.SQL.Add(lsSQL);
      FDQuery1.Open;

      if (FDQuery1.Eof and FDQuery1.Bof) then
      begin
         lsTime := UpperCase(FileListBox1.Items[liCont]);
         lsTime := Copy(lsTime,liPos_+1,length(lsTime));
         liPos := Pos('.',lsTime);
         lsTime := Copy(lsTime,1,liPos-1);
         lsSQL := 'insert into TIMES values('+lsInd+', '''+lsTime+''', '''+FileListBox1.Items[liCont]+''')';
         FDQuery1.Close;
         FDQuery1.SQL.Clear;
         FDQuery1.SQL.Add(lsSQL);
         FDQuery1.ExecSQL;
         Memo1.Lines.Add('Imagem adicionada: '+FileListBox1.Items[liCont]);
      end;

   end;
   ShowMessage('Inclusão efetuada!');
end;

procedure TFAuxiliar.Button6Click(Sender: TObject);
var arq: TextFile; { declarando a variável "arq" do tipo arquivo texto }
    linha: string;
    lsSQL: string;
    liLin: integer;
begin
   Memo1.Clear;

   // Associa a variável do programa "arq" ao arquivo externo "tabuada.txt"
   // na unidade de disco "d"
   AssignFile(arq, 'E:\DESENV\SISTEMAS\PREVISOES\Loteca 2015.txt');

   {$I-}         // desativa a diretiva de Input
   Reset(arq);   // Abre o arquivo texto para leitura
   {$I+}         // ativa a diretiva de Input

   liLin := 0;
   if (IOResult <> 0) then// verifica o resultado da operação de abertura
      ShowMessage('Erro na abertura do arquivo !!!')
   else
   begin
      // verifica se o ponteiro de arquivo atingiu a marca de final de arquivo
      while (not eof(arq)) do
      begin
         inc(liLin);
         try
            DM.FDConnection1.StartTransaction;
            FDQuery1.Connection:= DM.FDConnection1;

            //pega a última sequencia da tabela e soam mais um para incluir
            FDQuery1.Close;
            FDQuery1.SQL.Clear;
            FDQuery1.SQL.Add('select MAX(Id) as MAIOR from LOTECA');
            FDQuery1.Open;
            (*
Select *
From LOTECA t1
Where exists (select A_CASA1_MAIOR, A_CASA1_MENOR, A_CASA1_NAIPE, A_CASA2_MAIOR, A_CASA2_MENOR, A_CASA2_NAIPE, A_CASA3_MAIOR, A_CASA3_MENOR, A_CASA3_NAIPE,
B_CASA1_MAIOR, B_CASA1_MENOR, B_CASA1_NAIPE, B_CASA2_MAIOR, B_CASA2_MENOR, B_CASA2_NAIPE, B_CASA3_MAIOR, B_CASA3_MENOR, B_CASA3_NAIPE, count(*)
(*
from LOTECA T2
where t2.A_CASA1_MAIOR = t1.A_CASA1_MAIOR AND t2.A_CASA1_MENOR = t1.A_CASA1_MENOR AND t2.A_CASA1_NAIPE = t1.A_CASA1_NAIPE AND
      t2.A_CASA2_MAIOR = t1.A_CASA2_MAIOR AND t2.A_CASA2_MENOR = t1.A_CASA2_MENOR AND t2.A_CASA2_NAIPE = t1.A_CASA2_NAIPE AND
      t2.A_CASA3_MAIOR = t1.A_CASA3_MAIOR AND t2.A_CASA3_MENOR = t1.A_CASA3_MENOR AND t2.A_CASA3_NAIPE = t1.A_CASA3_NAIPE AND
      t2.B_CASA1_MAIOR = t1.B_CASA1_MAIOR AND t2.B_CASA1_MENOR = t1.B_CASA1_MENOR AND t2.B_CASA1_NAIPE = t1.B_CASA1_NAIPE AND
      t2.B_CASA2_MAIOR = t1.B_CASA2_MAIOR AND t2.B_CASA2_MENOR = t1.B_CASA2_MENOR AND t2.B_CASA2_NAIPE = t1.A_CASA2_NAIPE AND
      t2.B_CASA3_MAIOR = t1.B_CASA3_MAIOR AND t2.B_CASA3_MENOR = t1.B_CASA3_MENOR AND t2.B_CASA3_NAIPE = t1.A_CASA3_NAIPE
group by A_CASA1_MAIOR, A_CASA1_MENOR, A_CASA1_NAIPE, A_CASA2_MAIOR, A_CASA2_MENOR, A_CASA2_NAIPE, A_CASA3_MAIOR, A_CASA3_MENOR, A_CASA3_NAIPE,
B_CASA1_MAIOR, B_CASA1_MENOR, B_CASA1_NAIPE, B_CASA2_MAIOR, B_CASA2_MENOR, B_CASA2_NAIPE, B_CASA3_MAIOR, B_CASA3_MENOR, B_CASA3_NAIPE
having count(*)(* > 1
ORDER BY A_CASA1_MAIOR, A_CASA1_MENOR, A_CASA1_NAIPE, A_CASA2_MAIOR, A_CASA2_MENOR, A_CASA2_NAIPE, A_CASA3_MAIOR, A_CASA3_MENOR, A_CASA3_NAIPE,
B_CASA1_MAIOR, B_CASA1_MENOR, B_CASA1_NAIPE, B_CASA2_MAIOR, B_CASA2_MENOR, B_CASA2_NAIPE, B_CASA3_MAIOR, B_CASA3_MENOR, B_CASA3_NAIPE)
ORDER BY A_CASA1_MAIOR, A_CASA1_MENOR, A_CASA1_NAIPE, A_CASA2_MAIOR, A_CASA2_MENOR, A_CASA2_NAIPE, A_CASA3_MAIOR, A_CASA3_MENOR, A_CASA3_NAIPE,
B_CASA1_MAIOR, B_CASA1_MENOR, B_CASA1_NAIPE, B_CASA2_MAIOR, B_CASA2_MENOR, B_CASA2_NAIPE, B_CASA3_MAIOR, B_CASA3_MENOR, B_CASA3_NAIPE
                 *)
            readln(arq, linha); // Lê uma linha do arquivo
            //Memo1.Lines.Add(linha);
            lsSQL := 'insert into LOTECA values ('+IntToStr(FDQuery1.FieldByName('MAIOR').AsInteger+1)+', ';
            //para campos nulos
            //lsSQL := 'insert into LOTECA values ('+IntToStr(FDQuery1.FieldByName('MAIOR').AsInteger+1)+', null';

            lsSQL := lsSQL + linha+')';

            FDQuery1.Close;
            FDQuery1.SQL.Clear;
            FDQuery1.SQL.Add(lsSQL);
            FDQuery1.ExecSQL;
         except
            DM.FDConnection1.Rollback;
            ShowMessage(IntToStr(liLin));
         end;
         DM.FDConnection1.Commit;
      end;

      CloseFile(arq); // Fecha o arquivo texto aberto
      ShowMessage('Acabou!');
   end;
end;

procedure TFAuxiliar.FormShow(Sender: TObject);
begin
   FileListBox1.Directory := ExtractFilePath(Application.ExeName)+'timeimg';
end;

procedure TFAuxiliar.btnArcMenorClick(Sender: TObject);
var arq: TextFile; { declarando a variável "arq" do tipo arquivo texto }
    linha: string;
    lsSQL: string;
begin
   // Associa a variável do programa "arq" ao arquivo externo "tabuada.txt"
   // na unidade de disco "d"
   AssignFile(arq, 'E:\DESENV\SISTEMAS\PREVISOES\CREATE_BD\CARGA_ARCANOS_MENORES.txt');

   {$I-}         // desativa a diretiva de Input
   Reset(arq);   // Abre o arquivo texto para leitura
   {$I+}         // ativa a diretiva de Input

   if (IOResult <> 0) then// verifica o resultado da operação de abertura
      ShowMessage('Erro na abertura do arquivo !!!')
   else
   begin
      // verifica se o ponteiro de arquivo atingiu a marca de final de arquivo
      while (not eof(arq)) do
      begin
         try
            DM.FDConnection1.StartTransaction;
            readln(arq, linha); // Lê uma linha do arquivo
            //Memo1.Lines.Add(linha);
            lsSQL := 'insert into ARCANOS_MENORES values ('+linha+');';
            FDQuery1.Close;
            FDQuery1.SQL.Clear;
            FDQuery1.SQL.Add(lsSQL);
            FDQuery1.ExecSQL;
         except
            DM.FDConnection1.Rollback;
         end;
         DM.FDConnection1.Commit;
      end;

      CloseFile(arq); // Fecha o arquivo texto aberto
      ShowMessage('Acabou!');
   end;
end;

end.

