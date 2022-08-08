unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MailerLiteService, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    edApiKey: TEdit;
    Label1: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Button1: TButton;
    Memo1: TMemo;
    TabSheet2: TTabSheet;
    Label2: TLabel;
    edName: TEdit;
    Label3: TLabel;
    edEmail: TEdit;
    btAddSusbcriber: TButton;
    TabSheet3: TTabSheet;
    Label4: TLabel;
    edGroup: TEdit;
    Label5: TLabel;
    edSubscriberToAdd: TEdit;
    btAddGroupSubscriber: TButton;
    btGetGroups: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure edApiKeyChange(Sender: TObject);
    procedure btAddSusbcriberClick(Sender: TObject);
    procedure btGetGroupsClick(Sender: TObject);
    procedure btAddGroupSubscriberClick(Sender: TObject);
  private
    Client: TMailerLiteClient;
    procedure Log(const Msg: string);
  public
  end;

var
  Form1: TForm1;

implementation

uses
  Bcl.Json;

{$R *.dfm}

procedure TForm1.btAddGroupSubscriberClick(Sender: TObject);
var
  Req: TAddGroupSubscriberRequest;
  Subscriber: TSubscriber;
begin
  Req := TAddGroupSubscriberRequest.Create;
  Client.ReturnedEntities.Add(Req);
  Req.Email := edSubscriberToAdd.Text;
  Subscriber := Client.Groups.AddGroupSubscriber(edGroup.Text, Req);
  Log(Format('Subscriber added to group with id: %d', [Subscriber.Id]));
end;

procedure TForm1.btAddSusbcriberClick(Sender: TObject);
var
  Req: TAddSubscriberRequest;
  Subscriber: TSubscriber;
begin
  Req := TAddSubscriberRequest.Create;
  Client.ReturnedEntities.Add(Req);
  Req.Email := edEmail.Text;
  Req.Name := edName.Text;
  Subscriber := Client.Subscribers.AddSubscriber(Req);
  Log(Format('Subscriber added with id: %d', [Subscriber.Id]));
end;

procedure TForm1.btGetGroupsClick(Sender: TObject);
var
  Req: TListGroupsRequest;
  Groups: TArray<TGroup>;
  Group: TGroup;
begin
  Req := TListGroupsRequest.Create;
  Client.ReturnedEntities.Add(Req);
  Groups := Client.Groups.ListGroups(Req);
  Log('Groups:');
  for Group in Groups do
    Log(Format('(%s) %s', [Group.Id, Group.Name]));
  Log('------------');
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Req: TListSubscribersRequest;
  Subscribers: TArray<TSubscriber>;
  Subscriber: TSubscriber;
begin
  Req := TListSubscribersRequest.Create;
  Client.ReturnedEntities.Add(Req);
  Subscribers := Client.Subscribers.ListSubscribers(Req);
  Log('Subscribers:');
  for Subscriber in Subscribers do
    Log(Format('(%d) %s, Name: %s', [Subscriber.Id, Subscriber.Email, Subscriber.Name]));
  Log('------------');
end;

procedure TForm1.edApiKeyChange(Sender: TObject);
begin
  Client.ApiKey := edApiKey.Text;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Client := TMailerLiteClient.Create;
  edApiKey.Text := GetEnvironmentVariable('MAILERLITE_APIKEY');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Client.Free;
end;

procedure TForm1.Log(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

end.
