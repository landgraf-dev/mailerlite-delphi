unit MailerLiteService;

interface

uses
  Bcl.Json.Attributes,
  Bcl.Json.NamingStrategies,
  Aurelius.Mapping.Attributes,
  Sparkle.Http.Engine,
{$IFDEF MSWINDOWS}
  Sparkle.WinHttp.Engine,
{$ENDIF}
  XData.Client,
  XData.Aurelius.Model,
  XData.Service.Common,
  XData.Model.Classes,
  XData.Types.Converters;

const
  MailerLiteModel = 'MailerLite';

type
  [JsonNamingStrategy(TSnakeCaseNamingStrategy)]
  [JsonInclude(TInclusionMode.NonDefault)]
  TSubscriber = class
  private
    FId: Int64;
    FEmail: string;
    FName: string;
    FType: string;
  public
    property Id: Int64 read FId write FId;
    property Email: string read FEmail write FEmail;
    property Name: string read FName write FName;
    property &Type: string read FType write FType;
  end;

  [JsonNamingStrategy(TSnakeCaseNamingStrategy)]
  [JsonInclude(TInclusionMode.NonDefault)]
  TListSubscribersRequest = class
  private
    FLimit: Integer;
    FOffset: Integer;
    FType: string;
  public
    property Offset: Integer read FOffset write FOffset;
    property Limit: Integer read FLimit write FLimit;
    property &Type: string read FType write FType;
  end;

  [JsonNamingStrategy(TSnakeCaseNamingStrategy)]
  [JsonInclude(TInclusionMode.NonDefault)]
  TAddSubscriberRequest = class
  private
    FEmail: string;
    FName: string;
  public
    property Email: string read FEmail write FEmail;
    property Name: string read FName write FName;
  end;

  [JsonNamingStrategy(TSnakeCaseNamingStrategy)]
  [JsonInclude(TInclusionMode.NonDefault)]
  TGroup = class
  private
    FId: string;
    FName: string;
  public
    property Id: string read FId write FId;
    property Name: string read FName write FName;
  end;

  [JsonNamingStrategy(TSnakeCaseNamingStrategy)]
  [JsonInclude(TInclusionMode.NonDefault)]
  TListGroupsRequest = class
  private
    FLimit: Integer;
    FOffset: Integer;
    FFilters: string;
  public
    property Offset: Integer read FOffset write FOffset;
    property Limit: Integer read FLimit write FLimit;
    property Filters: string read FFilters write FFilters;
  end;

  [JsonNamingStrategy(TSnakeCaseNamingStrategy)]
  [JsonInclude(TInclusionMode.NonDefault)]
  TAddGroupSubscriberRequest = class
  private
    FEmail: string;
    FName: string;
  public
    property Email: string read FEmail write FEmail;
    property Name: string read FName write FName;
  end;

  [ServiceContract, Model(MailerLiteModel)]
  [Route('subscribers')]
  ISubscriberService = interface(IInvokable)
  ['{202D9A56-8551-4ACF-80EB-045AEACA3578}']
    [HttpGet, Route('')] function ListSubscribers(Request: TListSubscribersRequest): TArray<TSubscriber>;
    [HttpPost, Route('')] function AddSubscriber(Request: TAddSubscriberRequest): TSubscriber;
  end;

  [ServiceContract, Model(MailerLiteModel)]
  [Route('groups')]
  IGroupService = interface(IInvokable)
  ['{202D9A56-8551-4ACF-80EB-045AEACA3578}']
    [HttpGet, Route('')] function ListGroups(Request: TListGroupsRequest): TArray<TGroup>;
    [HttpPost, Route('{Id}/subscribers')] function AddGroupSubscriber(const Id: string; Request: TAddGroupSubscriberRequest): TSubscriber;
  end;

  TMailerLiteClient = class(TXDataClient)
  private
    FApiKey: string;
  public
    constructor Create; reintroduce;
    property ApiKey: string read FApiKey write FApiKey;
    function Subscribers: ISubscriberService;
    function Groups: IGroupService;
  end;

implementation

procedure InitModel(Model: TXDataAureliusModel);
var
  StringType: TXDataScalarType;
begin
  StringType := Model.DefaultSchema.FindScalarType('String');
  StringType.UrlConverter.Free;
  StringType.UrlConverter := TXDataUnquotedStringConverter.Create;
end;

{ TMailerLiteClient }

constructor TMailerLiteClient.Create;
begin
  inherited Create(TXDataAureliusModel.Get(MailerLiteModel));
  Uri := 'https://api.mailerlite.com/api/v2/';
  HttpClient.OnSendingRequest :=
    procedure(Req: THttpRequest)
    begin
      Req.Headers.SetValue('X-MailerLite-ApiKey', ApiKey);
    end;
{$IFDEF MSWINDOWS}
  TWinHttpEngine(HttpClient.Engine).ProxyMode := THttpProxyMode.Auto;
{$ENDIF}
  RawSerialization := True;
  IgnoreUnknownProperties := True;
end;

function TMailerLiteClient.Groups: IGroupService;
begin
  Result := Service<IGroupService>;
end;

function TMailerLiteClient.Subscribers: ISubscriberService;
begin
  Result := Service<ISubscriberService>;
end;

initialization
  RegisterServiceType(TypeInfo(ISubscriberService));
  InitModel(TXDataAureliusModel.Get(MailerLiteModel));
end.
