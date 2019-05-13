unit UJogoCartas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.StdCtrls, System.UITypes, Vcl.ComCtrls, uDM, uInclusao;

type
  TFJogoCartas = class(TForm)
    btnEmbaralhar: TButton;
    PanelBaralho: TPanel;
    PanelArcanosMaiores: TPanel;
    imgArcMaior00: TImage;
    Edit1: TEdit;
    PanelArcanosMenores: TPanel;
    imgArcMenor00: TImage;
    imgArcMenor28: TImage;
    Edit2: TEdit;
    btnLimpar: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    Panel2: TPanel;
    imgCasa1BMaior: TImage;
    imgCasa1BMenor: TImage;
    imgCasa2BMaior: TImage;
    imgCasa2BMenor: TImage;
    imgCasa3BMaior: TImage;
    imgCasa3BMenor: TImage;
    Panel1: TPanel;
    imgCasa1AMaior: TImage;
    imgCasa1AMenor: TImage;
    imgCasa2AMaior: TImage;
    imgCasa2AMenor: TImage;
    imgCasa3AMaior: TImage;
    imgCasa3AMenor: TImage;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    LabelCasa1AMaior: TLabel;
    LabelCasa1AMenor: TLabel;
    LabelCasa2AMaior: TLabel;
    LabelCasa2AMenor: TLabel;
    LabelCasa3AMaior: TLabel;
    LabelCasa3AMenor: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    LabelCasa1BMaior: TLabel;
    LabelCasa1BMenor: TLabel;
    LabelCasa2BMaior: TLabel;
    LabelCasa2BMenor: TLabel;
    LabelCasa3BMaior: TLabel;
    LabelCasa3BMenor: TLabel;
    PanelCasa1A: TPanel;
    PanelCasa2A: TPanel;
    LabelCasa2A: TLabel;
    PanelCasa3A: TPanel;
    LabelCasa3A: TLabel;
    LabelCasa1A: TLabel;
    PanelCasa1B: TPanel;
    LabelCasa1B: TLabel;
    PanelCasa2B: TPanel;
    LabelCasa2B: TLabel;
    PanelCasa3B: TPanel;
    LabelCasa3B: TLabel;
    btnGravar: TButton;
    btnAnalisar: TButton;
    LabelMsg: TLabel;
    procedure ImageCartaMaiorClick(Sender: TObject);
    procedure ImageCartaMenorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEmbaralharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAnalisarClick(Sender: TObject);
  private
    { Private declarations }
    gsDir: string; //diret�rio da aplica��o
    //vari�veis de controle para saber quantos arcanos maiores e menores o Yub selecionou depois de embaralhar
    //s� podem ser 6 de cada (3 para cada time)
    giQtdJogos: longint;
    giContMaior, giContMenor: integer;
    gbJogou, gbGravouPartida: Boolean;
    procedure CriarImagesMaior(imgBase: TImage; sName: string; iNum, iCont: integer);
    procedure CriarImagesMenor(imgBase: TImage; sName: string; iNum, iCont: integer);
    procedure EmbaralharCartas;
  public
    { Public declarations }
    //strings contendo os nomes dos times que foram informados na tela anterior
    giPartida: longint;
    gsTimeA, gsTimeB, gsData: string;
  end;

  //objeto record contendo um array para os 22 arcanos maiores e fun��es d embaralhar e Selecionar as cartas embaralhadas
  TDeckMaior = class(Tobject)
    DeckObj:array [0..21] of integer;
    NextCard:integer;
    constructor create(Aowner:TComponent);
    Procedure shuffle;
    function GetNextCard(var sCard:string; var iNumCard: integer):boolean;
  end;

  //objeto record contendo um array para os 56 arcanos menores e fun��es d embaralhar e Selecionar as cartas embaralhadas
  TDeckMenor = class(Tobject)
    DeckObj:array [0..55] of integer;
    NextCard:integer;
    constructor create(Aowner:TComponent);
    Procedure shuffle;
    function GetNextCard(var sCard:string; var iNumCard: integer):boolean;
  end;

  TCardsArcMenor = record
      descricao: array[00..55] of string;
      numero   : array[00..55] of string;
      naipe    : array[00..55] of string;
  end;
  //Constantes usadas para colocar o nome por extenso dos arcanos maiores e menores nas cartas (objeto Label) que foram tiradas pelo Yub
  Const
     ap = Chr(39);
     CardsArcMaior: array[00..21] of string = ('Louco', 'Mago', 'Sacerdotisa', 'Imperatriz', 'Imperador', 'Papa', 'Enamorado',
                                               'Carro', 'Justi�a', 'Eremita', 'Roda da Fortuna', 'For�a', 'Pendurado', 'Morte',
                                               'Temperan�a', 'Diabo', 'Torre', 'Estrela', 'Lua', 'Sol', 'Julgamento', 'Mundo');
     CardsArcMenor: TCardsArcMenor = (descricao:('�s Paus', 'Dois Paus', 'Tr�s de Paus', 'Quatro de Paus', 'Cinco de Paus', 'Seis de Paus', 'Sete de Paus',
                                                 'Oito de Paus', 'Nove de Paus', 'Dez de Paus', 'Pajem de Paus', 'Cavaleiro de Paus', 'Rainha de Paus',
                                                 'Rei de Paus', '�s de Copas', 'Dois de Copas', 'Tr�s de Copas', 'Quatro de Copas', 'Cinco de Copas',
                                                 'Seis de Copas', 'Sete de Copas', 'Oito de Copas', 'Nove de Copas', 'Dez de Copas', 'Pajem de Copas',
                                                 'Cavaleiro de Copas', 'Rainha de Copas', 'Rei de Copas', '�s de Espadas', 'Dois de Espadas', 'Tr�s de Espadas',
                                                 'Quatro de Espadas', 'Cinco de Espadas', 'Seis de Espadas', 'Sete de Espadas', 'Oito de Espadas',
                                                 'Nove de Espadas', 'Dez de Espadas', 'Pajem de Espadas', 'Cavaleiro de Espadas', 'Rainha de Espadas',
                                                 'Rei de Espadas', '�s de Ouros', 'Dois de Ouros', 'Tr�s de Ouros',	'Quatro de Ouros', 'Cinco de Ouros',
                                                 'Seis de Ouros', 'Sete de Ouros', 'Oito de Ouros', 'Nove de Ouros', 'Dez de Ouros', 'Pajem de Ouros',
                                                 'Cavaleiro de Ouros', 'Rainha de Ouros', 'Rei de Ouros');
                                       numero:  ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'P', 'C', 'D', 'R',
                                                 '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'P', 'C', 'D', 'R',
                                                 '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'P', 'C', 'D', 'R',
                                                 '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'P', 'C', 'D', 'R');
                                       naipe:   ('P', 'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P',
                                                 'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C',
                                                 'E', 'E', 'E', 'E', 'E', 'E', 'E', 'E', 'E', 'E', 'E', 'E', 'E', 'E',
                                                 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O'));

var
  FJogoCartas: TFJogoCartas;
  DeckMaior: TDeckMaior;
  DeckMenor: TDeckMenor;

implementation

{$R *.dfm}

{******************* Deck methods ********************}
//----------------------------------------------------
// Esse m�todo inicializa os arrays de forma ordenada,
// com os arcanos maiores de 00 a 22
//----------------------------------------------------
constructor TDeckMaior.create;
var i:integer;
begin
   inherited create;
   for i:= 0 to 21 do deckobj[i] := i; {initialize the deck}
end;

//----------------------------------------------------
// Esse m�todo inicializa os arrays de forma ordenada,
// com os arcanos menores de 23 a 77 que correspondem
//ao nome das cartas no diretorio (foram ordenadas sequencialmente
//ap�s os arcanos maiores
//----------------------------------------------------
constructor TDeckMenor.create;
var i:integer;
begin
   inherited create;
   for i:= 0 to 55 do deckobj[i] := i; {initialize the deck}
end;

//----------------------------------------------------
// Embaralha as cartas
//----------------------------------------------------
procedure tDeckMaior.shuffle;
var i,j:integer;
    swap:integer;
begin
   randomize;
   for i:= 21 downto 1 do
   begin
      j:=random(i+1{22});  {get a random card}
      {exchange the current card with the randomly selected card}
      swap:=deckobj[i];
      deckobj[i]:=deckobj[j];
      deckobj[j]:=swap;
   end;
   Nextcard:=0; {Set nextcard to first card}
end;

//----------------------------------------------------
// Embaralha as cartas
//----------------------------------------------------
procedure tDeckMenor.shuffle;
var i,j:integer;
    swap:integer;
begin
   randomize;
   for i:= 55 downto 1 do
   begin
      j:=random(i+1{56});  {get a random card}
      {exchange the current card with the randomly selected card}
      swap:=deckobj[i];
      deckobj[i]:=deckobj[j];
      deckobj[j]:=swap;
   end;
   Nextcard:=0; {Set nextcard to first card}
end;

//----------------------------------------------------
// Pega a pr�xima carta na sequ�ncia
// Usada para montar a tela com o baralho voltado para baixo
// pega as cartas j� embaralhadas e coloca na tela
//----------------------------------------------------
function TDeckMaior.GetNextCard(var sCard:string; var iNumCard: integer):boolean;
{pass a string beck representing next card}
begin
   if (nextcard <= 21) then
   begin
      sCard:= CardsArcMaior[Deckobj[nextcard]];
      //no diret�rio de imagens estao todos os arcanos, maiores e menores
      iNumCard := (Deckobj[nextcard]);
      result:=true;
      inc(nextcard);
   end
   else result:=false;
end;

//----------------------------------------------------
// Pega a pr�xima carta na sequ�ncia
// Usada para montar a tela com o baralho voltado para baixo
// pega as cartas j� embaralhadas e coloca na tela
//----------------------------------------------------
function TDeckMenor.GetNextCard(var sCard:string; var iNumCard: integer):boolean;
{pass a string beck representing next card}
begin
   if (nextcard <= 55) then
   begin
      sCard:= CardsArcMenor.descricao[Deckobj[nextcard]];
      //no diret�rio de imagens estao todos os arcanos, maiores e menores
      iNumCard := (Deckobj[nextcard]+22);
      result:=true;
      inc(nextcard);
   end
   else result:=false;
end;

//----------------------------------------------------
// Inicializa as vari�veis
//----------------------------------------------------
procedure TFJogoCartas.FormCreate(Sender: TObject);
begin
   giContMaior := 0;
   giContMenor := 0;
   gbJogou     := False;
   gbGravouPartida := False;
   DeckMaior := TDeckMaior.create(self);
   DeckMenor := TDeckMenor.create(self);
end;

//----------------------------------------------------
// Os objetos de imagem que representam aS cartas na
// tela s�o criadas em tempo de execu��o do programa
//----------------------------------------------------
procedure TFJogoCartas.FormShow(Sender: TObject);
var liCont: integer;
begin
   gsDir := ExtractFilePath(Application.ExeName)+'/cardimg/';
   btnLimparClick(Sender);
   //criar as cartas dinamicamente - existe a op��o de edixar o objeto j� criado no Delphi, mas para nomear os objetos mais rapidamente,
   //e alinhar corretamente, preferi criar dinamicamente
   for liCont := 1 to 21 do
      CriarImagesMaior(imgArcMaior00,'imgArcMaior', liCont, liCont);
   for liCont := 1 to 27 do
      CriarImagesMenor(imgArcMenor00,'imgArcMenor', liCont, liCont);
   for liCont := 29 to 55 do
      CriarImagesMenor(imgArcMenor28,'imgArcMenor', liCont, liCont-28);

   PageControl1.ActivePageIndex := 0;
   LabelCasa1A.Caption := 'Casa 1 do time A: o que est� prop�cio de ocorrer ao '+gsTimeA+ ' nesta partida contra o '+gsTimeB+'?';
   LabelCasa2A.Caption := 'Casa 2 do time A (qual ser� o maior obst�culo para o '+gsTimeA+' nesta partida contra o '+gsTimeB+'?';
   LabelCasa3A.Caption := 'Casa 3 do time A (qual ser� o resultado a ser alcan�ado pelo '+gsTimeA+' nesta partida contra o '+gsTimeB+'?';
   LabelCasa1B.Caption := 'Casa 1 do time B: o que est� prop�cio de ocorrer ao '+gsTimeB+ ' nesta partida contra o '+gsTimeA+'?';
   LabelCasa2B.Caption := 'Casa 2 do time B (qual ser� o maior obst�culo para o '+gsTimeB+' nesta partida contra o '+gsTimeA+'?';
   LabelCasa3B.Caption := 'Casa 3 do time B (qual ser� o resultado a ser alcan�ado pelo '+gsTimeB+' nesta partida contra o '+gsTimeA+'?';

   //se j� existir a partida, verificar quantos jogos j� possui
   if (giPartida = 0) then
      giQtdJogos := 0
   else
   begin
      //encontra a quantidade de jogos
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add('SELECT COUNT(idJogo) as QTD FROM JOGOS_PARTIDAS where idPartida = '+IntToStr(giPartida));
      DM.FDQuery1.Open;
      giQtdJogos := DM.FDQuery1.FieldByName('QTD').AsInteger;
   end;
   LabelMsg.Caption := 'Quantia de jogos nesta partida: '+IntToStr(giQtdJogos);
end;

//----------------------------------------------------
// Limpar todos os controles e objetos
//----------------------------------------------------
procedure TFJogoCartas.btnGravarClick(Sender: TObject);
var lsSQL: string;
    liIdJogo: longint;
begin
   if not(gbJogou) then
   begin
      MessageDlg('Efetue um novo jogo de tar�!',mtWarning,[mbOk],0);
      Exit;
   end;

   try
      Screen.Cursor := crSQLWait;
      DM.FDConnection1.StartTransaction;
      //primeiro grava a partida e seta a vari�vel para n�o gravar nos pr�ximos jogos. Guarda o Id
      if not(gbGravouPartida) then
      begin
         DM.FDQuery1.Close;
         //verifica se o jogo j� existe
         if (giPartida = 0) then
         begin
            //encontra o �ltimo Id de partida da tabela
            DM.FDQuery1.Close;
            DM.FDQuery1.SQL.Clear;
            DM.FDQuery1.SQL.Add('SELECT MAX(IdPartida) as Id FROM PARTIDAS');
            DM.FDQuery1.Open;
            if (DM.FDQuery1.FieldByName('Id').IsNull) then
               giPartida := 1
            else
               giPartida := DM.FDQuery1.FieldByName('Id').AsInteger + 1;

            //grava a partida
            DM.FDQuery1.Close;
            DM.FDQuery1.SQL.Clear;
            DM.FDQuery1.SQL.Add('INSERT INTO PARTIDAS values('+IntToStr(giPartida)+
                                ', '+AP+gsData+AP+', '+AP+gsTimeA+AP+', '+AP+gsTimeB+AP+')');
            DM.FDQuery1.ExecSQL;
         end;
      end;

      //grava o jogo de tar� atual
      //pega o �ltimo n�mero da tabela
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add('select MAX(Id) as MAIOR from LOTECA');
      DM.FDQuery1.Open;
      liIdJogo := DM.FDQuery1.FieldByName('MAIOR').AsInteger+1;

      //prepara o SQL
      lsSQL := 'INSERT INTO LOTECA (Id, VITORIA, A_CASA1_MAIOR, A_CASA1_MENOR, A_CASA1_NAIPE, '+
               'A_CASA2_MAIOR, A_CASA2_MENOR, A_CASA2_NAIPE, A_CASA3_MAIOR, A_CASA3_MENOR, A_CASA3_NAIPE, '+
               'B_CASA1_MAIOR, B_CASA1_MENOR, B_CASA1_NAIPE, B_CASA2_MAIOR, B_CASA2_MENOR, B_CASA2_NAIPE, '+
               'B_CASA3_MAIOR, B_CASA3_MENOR, B_CASA3_NAIPE) '+
               'VALUES '+
               '('+IntToStr(liIdJogo)+', null, ';
      lsSQL := lsSQL + AP+imgCasa1AMaior.Hint+AP+', ';
      lsSQL := lsSQL + AP+CardsArcMenor.numero[StrToInt(imgCasa1AMenor.Hint)-22]+AP+', ';
      lsSQL := lsSQL + AP+CardsArcMenor.naipe[StrToInt(imgCasa1AMenor.Hint)-22] +AP+', ';
      lsSQL := lsSQL + AP+imgCasa2AMaior.Hint+AP+', ';
      lsSQL := lsSQL + AP+CardsArcMenor.numero[StrToInt(imgCasa2AMenor.Hint)-22]+AP+', ';
      lsSQL := lsSQL + AP+CardsArcMenor.naipe[StrToInt(imgCasa2AMenor.Hint)-22] +AP+', ';
      lsSQL := lsSQL + AP+imgCasa3AMaior.Hint+AP+', ';
      lsSQL := lsSQL + AP+CardsArcMenor.numero[StrToInt(imgCasa3AMenor.Hint)-22]+AP+', ';
      lsSQL := lsSQL + AP+CardsArcMenor.naipe[StrToInt(imgCasa3AMenor.Hint)-22] +AP+', ';
      lsSQL := lsSQL + AP+imgCasa1BMaior.Hint+AP+', ';
      lsSQL := lsSQL + AP+CardsArcMenor.numero[StrToInt(imgCasa1BMenor.Hint)-22]+AP+', ';
      lsSQL := lsSQL + AP+CardsArcMenor.naipe[StrToInt(imgCasa1BMenor.Hint)-22] +AP+', ';
      lsSQL := lsSQL + AP+imgCasa2BMaior.Hint+AP+', ';
      lsSQL := lsSQL + AP+CardsArcMenor.numero[StrToInt(imgCasa2BMenor.Hint)-22]+AP+', ';
      lsSQL := lsSQL + AP+CardsArcMenor.naipe[StrToInt(imgCasa2BMenor.Hint)-22] +AP+', ';
      lsSQL := lsSQL + AP+imgCasa3BMaior.Hint+AP+', ';
      lsSQL := lsSQL + AP+CardsArcMenor.numero[StrToInt(imgCasa3BMenor.Hint)-22]+AP+', ';
      lsSQL := lsSQL + AP+CardsArcMenor.naipe[StrToInt(imgCasa3BMenor.Hint)-22] +AP+')';
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add(lsSQL);
      DM.FDQuery1.ExecSQL;

      //por �ltimo grava o relacionamento entre o jogo de tar� e a partida
      DM.FDQuery1.Close;
      DM.FDQuery1.SQL.Clear;
      DM.FDQuery1.SQL.Add('INSERT INTO JOGOS_PARTIDAS VALUES('+IntToStr(giPartida)+', '+IntToStr(liIdJogo)+')');
      DM.FDQuery1.ExecSQL;
      inc(giQtdJogos);
      LabelMsg.Caption := 'Quantia de jogos nesta partida: '+IntToStr(giQtdJogos);
   except
      Screen.Cursor := crDefault;
      DM.FDConnection1.Rollback;
      MessageDlg('Erro na grava��o do jogo de tar�.',mtError,[mbOk],0);
      Exit;
   end;
   gbJogou := False;
   gbGravouPartida := True;
   DM.FDConnection1.Commit;
   Screen.Cursor := crDefault;
   btnEmbaralharClick(Sender);
//   MessageDlg('Jogo gravado com sucesso!',mtInformation,[mbOk],0);
end;

procedure TFJogoCartas.btnLimparClick(Sender: TObject);
var iIndice, iNumCard: integer;
    sName: string;
begin
   giContMaior := 0;
   giContMenor := 0;
   gbJogou     := False;

   for iIndice := 0 to ComponentCount - 1 do
   begin
      sName := Components[iIndice].Name;
      if (Copy(sName, 1, 11) = 'imgArcMaior') then
      begin
         (FindComponent(sName) as TImage).Picture.LoadFromFile(gsDir + 'card-back.png');
         (FindComponent(sName) as TImage).Hint:= '';
         (FindComponent(sName) as TImage).Tag := 0;
         (FindComponent(sName) as TImage).Top := 24;
      end;
   end;

   for iIndice := 0 to ComponentCount - 1 do
   begin
      sName := Components[iIndice].Name;
      if (Copy(sName, 1, 11) = 'imgArcMenor') then
      begin
         iNumCard := StrToInt(Copy(sName,length(sName)-1,2));
         (FindComponent(sName) as TImage).Picture.LoadFromFile(gsDir + 'card-back.png');
         (FindComponent(sName) as TImage).Hint:= '';
         (FindComponent(sName) as TImage).Tag := 0;
         if (iNumCard <= 27) then
            (FindComponent(sName) as TImage).Top := 24
         else
            (FindComponent(sName) as TImage).Top := 77;
      end;
   end;

   imgCasa1AMaior.Picture.LoadFromFile(gsDir +'card-back.png');
   imgCasa1AMenor.Picture.LoadFromFile(gsDir +'card-back.png');
   imgCasa2AMaior.Picture.LoadFromFile(gsDir +'card-back.png');
   imgCasa2AMenor.Picture.LoadFromFile(gsDir +'card-back.png');
   imgCasa3AMaior.Picture.LoadFromFile(gsDir +'card-back.png');
   imgCasa3AMenor.Picture.LoadFromFile(gsDir +'card-back.png');
   imgCasa1BMaior.Picture.LoadFromFile(gsDir +'card-back.png');
   imgCasa1BMenor.Picture.LoadFromFile(gsDir +'card-back.png');
   imgCasa2BMaior.Picture.LoadFromFile(gsDir +'card-back.png');
   imgCasa2BMenor.Picture.LoadFromFile(gsDir +'card-back.png');
   imgCasa3BMaior.Picture.LoadFromFile(gsDir +'card-back.png');
   imgCasa3BMenor.Picture.LoadFromFile(gsDir +'card-back.png');
   //
   imgCasa1AMaior.Visible := False;
   imgCasa1AMenor.Visible := False;
   imgCasa2AMaior.Visible := False;
   imgCasa2AMenor.Visible := False;
   imgCasa3AMaior.Visible := False;
   imgCasa3AMenor.Visible := False;
   imgCasa1BMaior.Visible := False;
   imgCasa1BMenor.Visible := False;
   imgCasa2BMaior.Visible := False;
   imgCasa2BMenor.Visible := False;
   imgCasa3BMaior.Visible := False;
   imgCasa3BMenor.Visible := False;

   LabelCasa1AMaior.Visible := False;
   LabelCasa1AMenor.Visible := False;
   LabelCasa2AMaior.Visible := False;
   LabelCasa2AMenor.Visible := False;
   LabelCasa3AMaior.Visible := False;
   LabelCasa3AMenor.Visible := False;
   LabelCasa1BMaior.Visible := False;
   LabelCasa1BMenor.Visible := False;
   LabelCasa2BMaior.Visible := False;
   LabelCasa2BMenor.Visible := False;
   LabelCasa3BMaior.Visible := False;
   LabelCasa3BMenor.Visible := False;
   PageControl1.ActivePageIndex := 0;
end;

//----------------------------------------------------
// Cria dinamicamente os objetos de magem das cartas
//----------------------------------------------------
procedure TFJogoCartas.CriarImagesMaior(imgBase: TImage; sName: string; iNum, iCont: integer);
var iNewImage: TImage;
begin
   iNewImage := TImage.Create(FJogoCartas);
   iNewImage.Visible    := True;
   iNewImage.Name       := sName + FormatFloat('00', iNum);
   iNewImage.Parent     := PanelArcanosMaiores;
   //cada carta fica a 38 pixels da anterior. Em rela��o � primeira, � s� multiplicar pela quantia de cartas ap�s a mesma
   iNewImage.Left       := imgBase.Left + (38 * iCont);
   iNewImage.Top        := imgBase.Top;
   iNewImage.Width      := imgBase.Width;
   iNewImage.Height     := imgBase.Height;
   iNewImage.Stretch    := True;
   iNewImage.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'/'+'cardimg/card-back.png');
   iNewImage.OnClick    := imgBase.OnClick;
end;

//----------------------------------------------------
// Cria dinamicamente os objetos de magem das cartas
//----------------------------------------------------
procedure TFJogoCartas.CriarImagesMenor(imgBase: TImage; sName: string; iNum, iCont: integer);
var iNewImage: TImage;
begin
   iNewImage := TImage.Create(FJogoCartas);
   iNewImage.Visible    := True;
   iNewImage.Name       := sName + FormatFloat('00', iNum);
   iNewImage.Parent     := PanelArcanosMenores;
   //cada carta fica a 38 pixels da anterior. Em rela��o � primeira, � s� multiplicar pela quantia de cartas ap�s a mesma
   iNewImage.Left       := imgBase.Left + (38 * iCont);
   iNewImage.Top        := imgBase.Top;
   iNewImage.Width      := imgBase.Width;
   iNewImage.Height     := imgBase.Height;
   iNewImage.Stretch    := True;
   iNewImage.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'/'+'cardimg/card-back.png');
   iNewImage.OnClick    := imgBase.OnClick;
end;

//--------------------------------------------------------
// Arcanos maiores
// Quando clicar em uma imagem, destacar a imagem na tela
//--------------------------------------------------------
procedure TFJogoCartas.ImageCartaMaiorClick(Sender: TObject);
begin
   if ((Sender as TImage).Hint = '') then
   begin
      MessageDlg('Embaralhe as cartas primeiro!',mtWarning,[mbOk],0);
      Exit;
   end;

   if (giContMaior < 6) then //s�o apenas 6 cartas para sortear, 3 do time A e 3 do time B
   begin
      if ((Sender as TImage).Tag = 0) then //carta foi selecionada, antes n�o estava
      begin
         if not(giContMaior = giContMenor) then
         begin
            MessageDlg('Selecione o arcano menor da casa atual primeiro!',mtWarning,[mbOk],0);
            Exit;
         end;
         inc(giContMaior);
         (Sender as TImage).Picture.LoadFromFile(gsDir+'card-back-choosen.png');
         (Sender as TImage).Top := (Sender as TImage).Top - 20;
         (Sender as TImage).Tag := 1;

         case giContMaior of
            1: begin
               imgCasa1AMaior.Picture.LoadFromFile(gsDir+(Sender as TImage).Hint+'.jpg');
               imgCasa1AMaior.Hint := (Sender as TImage).Hint;
               imgCasa1AMaior.Visible := True;
               LabelCasa1AMaior.Caption := CardsArcMaior[StrToInt((Sender as TImage).Hint)];
               LabelCasa1AMaior.Visible := True;
               PageControl1.ActivePageIndex := 0;
            end;
            2: begin
               imgCasa2AMaior.Picture.LoadFromFile(gsDir+(Sender as TImage).Hint+'.jpg');
               imgCasa2AMaior.Hint := (Sender as TImage).Hint;
               imgCasa2AMaior.Visible := True;
               LabelCasa2AMaior.Caption := CardsArcMaior[StrToInt((Sender as TImage).Hint)];
               LabelCasa2AMaior.Visible := True;
               PageControl1.ActivePageIndex := 1;
            end;
            3: begin
               imgCasa3AMaior.Picture.LoadFromFile(gsDir+(Sender as TImage).Hint+'.jpg');
               imgCasa3AMaior.Hint := (Sender as TImage).Hint;
               imgCasa3AMaior.Visible := True;
               LabelCasa3AMaior.Caption := CardsArcMaior[StrToInt((Sender as TImage).Hint)];
               LabelCasa3AMaior.Visible := True;
               PageControl1.ActivePageIndex := 2;
            end;
            4: begin
               imgCasa1BMaior.Picture.LoadFromFile(gsDir+(Sender as TImage).Hint+'.jpg');
               imgCasa1BMaior.Hint := (Sender as TImage).Hint;
               imgCasa1BMaior.Visible := True;
               LabelCasa1BMaior.Caption := CardsArcMaior[StrToInt((Sender as TImage).Hint)];
               LabelCasa1BMaior.Visible := True;
               PageControl1.ActivePageIndex := 3;
            end;
            5: begin
               imgCasa2BMaior.Picture.LoadFromFile(gsDir+(Sender as TImage).Hint+'.jpg');
               imgCasa2BMaior.Hint := (Sender as TImage).Hint;
               imgCasa2BMaior.Visible := True;
               LabelCasa2BMaior.Caption := CardsArcMaior[StrToInt((Sender as TImage).Hint)];
               LabelCasa2BMaior.Visible := True;
               PageControl1.ActivePageIndex := 4;
            end;
            6: begin
               imgCasa3BMaior.Picture.LoadFromFile(gsDir+(Sender as TImage).Hint+'.jpg');
               imgCasa3BMaior.Hint := (Sender as TImage).Hint;
               imgCasa3BMaior.Visible := True;
               LabelCasa3BMaior.Caption := CardsArcMaior[StrToInt((Sender as TImage).Hint)];
               LabelCasa3BMaior.Visible := True;
               PageControl1.ActivePageIndex := 5;
            end;
         end;
      end;
   end;
end;

//--------------------------------------------------------
// Arcanos menores
// Quando clicar em uma imagem, destacar a imagem na tela
//--------------------------------------------------------
procedure TFJogoCartas.ImageCartaMenorClick(Sender: TObject);
begin
   if ((Sender as TImage).Hint = '') then
   begin
      MessageDlg('Embaralhe as cartas primeiro!',mtWarning,[mbOk],0);
      Exit;
   end;

   if (giContMenor < 6) then //s�o apenas 6 cartas para sortear, 3 do time A e 3 do time B
   begin
      if ((Sender as TImage).Tag = 0) then //carta foi selecionada, antes n�o estava
      begin
         if (giContMaior = 0) or (giContMaior <= giContMenor) then
         begin
            MessageDlg('Selecione o arcano maior da casa atual primeiro!',mtWarning,[mbOk],0);
            Exit;
         end;

         (Sender as TImage).Picture.LoadFromFile(gsDir+'card-back-choosen.png');
         (Sender as TImage).Top := (Sender as TImage).Top - 20;
         (Sender as TImage).Tag := 1;
         inc(giContMenor);

         case giContMenor of
            1: begin
               imgCasa1AMenor.Picture.LoadFromFile(gsDir+(Sender as TImage).Hint+'.jpg');
               imgCasa1AMenor.Hint := (Sender as TImage).Hint;
               imgCasa1AMenor.Visible := True;
               LabelCasa1AMenor.Caption := CardsArcMenor.descricao[StrToInt((Sender as TImage).Hint)-22];
               LabelCasa1AMenor.Visible := True;
               PageControl1.ActivePageIndex := 1;
            end;
            2: begin
               imgCasa2AMenor.Picture.LoadFromFile(gsDir+(Sender as TImage).Hint+'.jpg');
               imgCasa2AMenor.Hint := (Sender as TImage).Hint;
               imgCasa2AMenor.Visible := True;
               LabelCasa2AMenor.Caption := CardsArcMenor.descricao[StrToInt((Sender as TImage).Hint)-22];
               LabelCasa2AMenor.Visible := True;
               PageControl1.ActivePageIndex := 2;
            end;
            3: begin
               imgCasa3AMenor.Picture.LoadFromFile(gsDir+(Sender as TImage).Hint+'.jpg');
               imgCasa3AMenor.Hint := (Sender as TImage).Hint;
               imgCasa3AMenor.Visible := True;
               LabelCasa3AMenor.Caption := CardsArcMenor.descricao[StrToInt((Sender as TImage).Hint)-22];
               LabelCasa3AMenor.Visible := True;
               PageControl1.ActivePageIndex := 3;
            end;
            4: begin
               imgCasa1BMenor.Picture.LoadFromFile(gsDir+(Sender as TImage).Hint+'.jpg');
               imgCasa1BMenor.Hint := (Sender as TImage).Hint;
               imgCasa1BMenor.Visible := True;
               LabelCasa1BMenor.Caption := CardsArcMenor.descricao[StrToInt((Sender as TImage).Hint)-22];
               LabelCasa1BMenor.Visible := True;
               PageControl1.ActivePageIndex := 4;
            end;
            5: begin
               imgCasa2BMenor.Picture.LoadFromFile(gsDir+(Sender as TImage).Hint+'.jpg');
               imgCasa2BMenor.Hint := (Sender as TImage).Hint;
               imgCasa2BMenor.Visible := True;
               LabelCasa2BMenor.Caption := CardsArcMenor.descricao[StrToInt((Sender as TImage).Hint)-22];
               LabelCasa2BMenor.Visible := True;
               PageControl1.ActivePageIndex := 5;
            end;
            6: begin
               imgCasa3BMenor.Picture.LoadFromFile(gsDir+(Sender as TImage).Hint+'.jpg');
               imgCasa3BMenor.Hint := (Sender as TImage).Hint;
               imgCasa3BMenor.Visible := True;
               LabelCasa3BMenor.Caption := CardsArcMenor.descricao[StrToInt((Sender as TImage).Hint)-22];
               LabelCasa3BMenor.Visible := True;
               PageControl1.ActivePageIndex := 6;
               gbJogou:= True;
            end;
         end;
      end;
   end;
end;

//--------------------------------------------------------
// Embaralhar as cartas e setar os objetos de imagem com
// a carta correspondente
//--------------------------------------------------------
procedure TFJogoCartas.btnAnalisarClick(Sender: TObject);
begin
   FInclusao := TFInclusao.Create(Self);
   FInclusao.BitBtnInserir.Enabled := False;
   FInclusao.gs1AMaior := imgCasa1AMaior.Hint;
   FInclusao.gs1AMenor := CardsArcMenor.numero[StrToInt(imgCasa1AMenor.Hint)-22];
   FInclusao.gs1ANaipe := CardsArcMenor.naipe[StrToInt(imgCasa1AMenor.Hint)-22];
   FInclusao.gs2AMaior := imgCasa2AMaior.Hint;
   FInclusao.gs2AMenor := CardsArcMenor.numero[StrToInt(imgCasa2AMenor.Hint)-22];
   FInclusao.gs2ANaipe := CardsArcMenor.naipe[StrToInt(imgCasa2AMenor.Hint)-22];
   FInclusao.gs3AMaior := imgCasa3AMaior.Hint;
   FInclusao.gs3AMenor := CardsArcMenor.numero[StrToInt(imgCasa3AMenor.Hint)-22];
   FInclusao.gs3ANaipe := CardsArcMenor.naipe[StrToInt(imgCasa3AMenor.Hint)-22];
   FInclusao.gs1BMaior := imgCasa1BMaior.Hint;
   FInclusao.gs1BMenor := CardsArcMenor.numero[StrToInt(imgCasa1BMenor.Hint)-22];
   FInclusao.gs1BNaipe := CardsArcMenor.naipe[StrToInt(imgCasa1BMenor.Hint)-22];
   FInclusao.gs2BMaior := imgCasa2BMaior.Hint;
   FInclusao.gs2BMenor := CardsArcMenor.numero[StrToInt(imgCasa2BMenor.Hint)-22];
   FInclusao.gs2BNaipe := CardsArcMenor.naipe[StrToInt(imgCasa2BMenor.Hint)-22];
   FInclusao.gs3BMaior := imgCasa3BMaior.Hint;
   FInclusao.gs3BMenor := CardsArcMenor.numero[StrToInt(imgCasa3BMenor.Hint)-22];
   FInclusao.gs3BNaipe := CardsArcMenor.naipe[StrToInt(imgCasa3BMenor.Hint)-22];
   FInclusao.CarregarCombos;
   FInclusao.ShowModal;
end;

procedure TFJogoCartas.btnEmbaralharClick(Sender: TObject);
var iCont, iNumCard: integer;
    sCard, sName:string;
begin
   //limpar a sele��o anterior
   btnLimparClick(Sender);
   //primeiro - parte de embaralhar as cartas nos objetos DeckMaior e DeckMenor
   DeckMaior.shuffle; {shuffle the deck}
   DeckMenor.shuffle; {shuffle the deck}

   //segundo - distribui as cartas em cada objeto de imagem
   for iCont:= 0 to 21 do   {Add shuffled cards to display}
   begin
      if (DeckMaior.getnextcard(sCard, iNumCard)) then
      begin
         sName := 'imgArcMaior'+FormatFloat('00',iCont);
         (FindComponent(sName) as TImage).Hint := FormatFloat('00',iNumCard);
      end;
   end;
   DeckMaior.nextcard:=0;

   for iCont:= 0 to 55 do   {Add shuffled cards to display}
   begin
      if (DeckMenor.getnextcard(sCard, iNumCard)) then
      begin
         sName := 'imgArcMenor'+FormatFloat('00',iCont);
         (FindComponent(sName) as TImage).Hint := FormatFloat('00',iNumCard);
      end;
   end;
   DeckMenor.nextcard:=0;

   //terceiro - efeito visual de embaralhamento na tela
   EmbaralharCartas;
end;

//--------------------------------------------------------
// Efeito visual do embaralhamento de cartas
//--------------------------------------------------------
procedure TFJogoCartas.EmbaralharCartas;
var iCont, iIndice, iNumCard: integer;
    sName:string;
begin
   //arcanos maiores
   for iCont := 0 to 21 do
   begin
      //varre todos os componentes do formul�rio
      for iIndice := 0 to ComponentCount - 1 do
      begin
         sName := Components[iIndice].Name;
         //se o componente for uma imagem com o in�cio do nome abaxio (o restante � a numera��o da imagem)
         //ent�o � um objeto de imagem para ARcano Maior
         if (Copy(sName, 1, 11) = 'imgArcMaior') then
         begin
            iNumCard := StrToInt(Copy(sName,length(sName)-1,2));
            //Se for a imagem com o n�mero escolhido, muda a imagem de fundo e muda a posi��o da carta na tela,
            //depois volta ao normal
            if (iNumCard = iCont) then
            begin
               (FindComponent(sName) as TImage).Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'/'+'cardimg/card-back-choosen.png');
               (FindComponent(sName) as TImage).Top := (FindComponent(sName) as TImage).Top - 20;
               Sleep(10);
               Application.ProcessMessages; ;
               (FindComponent(sName) as TImage).Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'/'+'cardimg/card-back.png');
               (FindComponent(sName) as TImage).Top := (FindComponent(sName) as TImage).Top + 20;
               Sleep(10);
               Application.ProcessMessages; ;
            end;
         end;
      end;
   end;
   //arcanos menores

   for iCont := 0 to 55 do
   begin
      for iIndice := 0 to ComponentCount - 1 do
      begin
         sName := Components[iIndice].Name;
         if (Copy(sName, 1, 11) = 'imgArcMenor') then
         begin
            iNumCard := StrToInt(Copy(sName,length(sName)-1,2));
            if (iNumCard = iCont) then
            begin
               (FindComponent(sName) as TImage).Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'/'+'cardimg/card-back-choosen.png');
               (FindComponent(sName) as TImage).Top := (FindComponent(sName) as TImage).Top - 20;
               Sleep(10);
               Application.ProcessMessages; ;
               (FindComponent(sName) as TImage).Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'/'+'cardimg/card-back.png');
               (FindComponent(sName) as TImage).Top := (FindComponent(sName) as TImage).Top + 20;
               Sleep(10);
               Application.ProcessMessages; ;
            end;
         end;
      end;
   end;
end;

end.
