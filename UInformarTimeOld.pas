unit UInformarTime;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.UITypes,
  Vcl.ComCtrls;

type
  TFInformarTime = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edTimeA: TEdit;
    Label3: TLabel;
    edTimeB: TEdit;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    Label4: TLabel;
    DateTimePicker1: TDateTimePicker;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FInformarTime: TFInformarTime;

implementation

{$R *.dfm}

procedure TFInformarTime.btnOkClick(Sender: TObject);
//var ldNow: TDate;
begin
//   ldNow := Now;
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

   if (DateTimePicker1.Date < StrToDate(DateToStr(Now))) then
   begin
      MessageDlg('Data não pode ser menor do que hoje!!',mtWarning,[mbOk],0);
      DateTimePicker1.SetFocus;
      ModalResult := mrNone;
      Exit;
   end;
end;

procedure TFInformarTime.FormCreate(Sender: TObject);
begin
   FormatSettings.ShortDateFormat := 'DD/MM/YYYY';
end;

procedure TFInformarTime.FormShow(Sender: TObject);
begin
   edTimeA.Clear;
   edTimeB.Clear;
   DateTimePicker1.DateTime := Now;
   edTimeA.SetFocus;
end;

end.
