unit UInformarTimeB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.UITypes,
  Vcl.ComCtrls, Vcl.Mask, Vcl.ExtCtrls, uDM;

type
  TFInformarTimeB = class(TForm)
    PanelTimeA: TPanel;
    listBoxTime: TListBox;
    Label1: TLabel;
    btnOkA: TBitBtn;
    btnCancelA: TBitBtn;
    ComboBox1: TComboBox;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelAClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    function TimeSelecionado: string;
    function ImagemSelecionada: string;
    function IndiceSelecionado: integer;
  end;

var
  FInformarTimeB: TFInformarTimeB;

const ap = Chr(39);

implementation

{$R *.dfm}

procedure TFInformarTimeB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TFInformarTimeB.FormShow(Sender: TObject);
begin
   //popular os combobox
   listBoxTime.Items.Clear;

   DM.FDQuery1.Close;
   DM.FDQuery1.SQL.Clear;
   DM.FDQuery1.SQL.Add('select Time, ImgTime from TIMES order by IdTime');
   DM.FDQuery1.Open;

   while not DM.FDQuery1.Eof do
   begin
      listBoxTime.Items.Add(DM.FDQuery1.FieldByName('Time').AsString);
      ComboBox1.Items.Add(DM.FDQuery1.FieldByName('ImgTime').AsString);
      DM.FDQuery1.Next;
   end;
end;

procedure TFInformarTimeB.btnCancelAClick(Sender: TObject);
begin
   PanelTimeA.Visible := False;
end;

procedure TFInformarTimeB.btnOkClick(Sender: TObject);
begin
(*
      if (Trim(edTimeB.Text) = '') then
      begin
         MessageDlg('Informe o nome do Time B!',mtWarning,[mbOk],0);
         edTimeB.SetFocus;
         ModalResult := mrNone;
         Exit;
      end;
  *)
end;

function TFInformarTimeB.TimeSelecionado: string;
begin
   result := listBoxTime.Items[listBoxTime.ItemIndex];
end;

function TFInformarTimeB.ImagemSelecionada: string;
begin
   result   :=  ComboBox1.Items[listBoxTime.ItemIndex];
end;

function TFInformarTimeB.IndiceSelecionado: integer;
begin
   result := listBoxTime.ItemIndex+1;
end;

end.
