unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  dcefb_Browser, dcef3_ceflib;

type
  TForm1 = class(TForm)
    DcefBrowser1: TDcefBrowser;
    Panel1: TPanel;
    AddressEdit: TEdit;
    AddButton: TButton;
    Panel2: TPanel;
    Button4: TButton;
    Button1: TButton;
    procedure AddressEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DcefBrowser1LoadEnd(const PageIndex: Integer;
      const browser: ICefBrowser; const frame: ICefFrame;
      httpStatusCode: Integer);
    procedure FormCreate(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateStates;
    procedure DoPageChanged(Sender: TObject);
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AddButtonClick(Sender: TObject);
begin
  DcefBrowser1.AddPage();
  AddressEdit.Text := 'about:blank';
end;

procedure TForm1.AddressEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    DcefBrowser1.Load(AddressEdit.Text);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  DcefBrowser1.GoForward;
  UpdateStates;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  DcefBrowser1.GoBack;
  UpdateStates;
end;

procedure TForm1.DcefBrowser1LoadEnd(const PageIndex: Integer;
  const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
var
  I: Integer;
begin
  UpdateStates;
  if DcefBrowser1.ActivePageIndex = PageIndex then
    Caption := DcefBrowser1.ActivePage.title;
end;

procedure TForm1.DoPageChanged(Sender: TObject);
begin
  Caption := DcefBrowser1.ActivePage.title;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DcefBrowser1.TabVisible := True;
  DcefBrowser1.OnPageChanged := DoPageChanged;
end;

procedure TForm1.UpdateStates;
begin
  Button4.Enabled := DcefBrowser1.canGoBack;
  Button1.Enabled := DcefBrowser1.canGoForward;
end;

//demo create by swish

end.
