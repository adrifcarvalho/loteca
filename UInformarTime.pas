unit UInformarTime;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.UITypes,
  Vcl.ComCtrls, Vcl.Mask, Vcl.ExtCtrls, uDM;

type
  TFInformarTime = class(TForm)
    PanelTimeA: TPanel;
    listBoxTime: TListBox;
    Label1: TLabel;
    btnOkA: TBitBtn;
    btnCancelA: TBitBtn;
    ComboBox1: TComboBox;
    edTime: TEdit;
    btnLimpar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnCancelAClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edTimeChange(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
    procedure PopularTimes;
  public
    { Public declarations }
    function TimeSelecionado: string;
    function ImagemSelecionada: string;
    function IndiceSelecionado: integer;
  end;

var
  FInformarTime: TFInformarTime;

const ap = Chr(39);

implementation

{$R *.dfm}

procedure TFInformarTime.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TFInformarTime.FormShow(Sender: TObject);
begin
   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add('select Time, ImgTime from TIMES order by IdTime');
   DM.FDQuery1.Open;
   PopularTimes;
end;

procedure TFInformarTime.PopularTimes;
begin
   //popular os combobox
   listBoxTime.Items.Clear;
   ComboBox1.Items.Clear;

   while not DM.FDQuery1.Eof do
   begin
      listBoxTime.Items.Add(DM.FDQuery1.FieldByName('Time').AsString);
      ComboBox1.Items.Add(DM.FDQuery1.FieldByName('ImgTime').AsString);
      DM.FDQuery1.Next;
   end;
end;

procedure TFInformarTime.btnCancelAClick(Sender: TObject);
begin
   PanelTimeA.Visible := False;
end;

procedure TFInformarTime.btnLimparClick(Sender: TObject);
begin
   edTime.Clear;
   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add('select Time, ImgTime from TIMES order by IdTime');
   DM.FDQuery1.Open;
   PopularTimes;
end;

procedure TFInformarTime.edTimeChange(Sender: TObject);
var lsSQL: string;
begin
   lsSQL := 'select * from times where upper(time) like ''%'+edTime.Text+'%''';
   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add(lsSQL);
   DM.FDQuery1.Open;
   PopularTimes;
end;

function TFInformarTime.TimeSelecionado: string;
begin
   result := listBoxTime.Items[listBoxTime.ItemIndex];
end;

function TFInformarTime.ImagemSelecionada: string;
begin
   result := ComboBox1.Items[listBoxTime.ItemIndex];
end;

function TFInformarTime.IndiceSelecionado: integer;
begin
   result := listBoxTime.ItemIndex+1;
end;

end.
