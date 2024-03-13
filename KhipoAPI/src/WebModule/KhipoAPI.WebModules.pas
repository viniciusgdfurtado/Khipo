unit KhipoAPI.WebModules;

interface

uses 
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  MVCFramework;

type
  TKhipoAPIWebModule = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
  private
    FMVC: TMVCEngine;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TKhipoAPIWebModule;

implementation

{$R *.dfm}

uses 
  KhipoAPI.Produto.Controller,
  KhipoAPI.RoleAuthHandler.Controller,

  System.IOUtils,
  MVCFramework.Commons,
  MVCFramework.Middleware.Authentication.RoleBasedAuthHandler,
  MVCFramework.Middleware.Compression,
  MVCFramework.Middleware.Swagger,
  MVCFramework.Swagger.Commons,
  MVCFramework.Middleware.CORS,
  MVCFramework.Middleware.StaticFiles;

procedure TKhipoAPIWebModule.WebModuleCreate(Sender: TObject);
var
  lSwagInfo: TMVCSwaggerInfo;
begin
  FMVC := TMVCEngine.Create(Self,
    procedure(Config: TMVCConfig)
    begin
      Config.dotEnv := dotEnv; 
      // session timeout (0 means session cookie)
      Config[TMVCConfigKey.SessionTimeout] := dotEnv.Env('dmvc.session_timeout', '0');
      //default content-type
      Config[TMVCConfigKey.DefaultContentType] := dotEnv.Env('dmvc.default.content_type', TMVCConstants.DEFAULT_CONTENT_TYPE);
      //default content charset
      Config[TMVCConfigKey.DefaultContentCharset] := dotEnv.Env('dmvc.default.content_charset', TMVCConstants.DEFAULT_CONTENT_CHARSET);
      //unhandled actions are permitted?
      Config[TMVCConfigKey.AllowUnhandledAction] := dotEnv.Env('dmvc.allow_unhandled_actions', 'false');
      //enables or not system controllers loading (available only from localhost requests)
      Config[TMVCConfigKey.LoadSystemControllers] := dotEnv.Env('dmvc.load_system_controllers', 'true');
      //default view file extension
      Config[TMVCConfigKey.DefaultViewFileExtension] := dotEnv.Env('dmvc.default.view_file_extension', 'html');
      //view path
      Config[TMVCConfigKey.ViewPath] := dotEnv.Env('dmvc.view_path', 'templates');
      //Max Record Count for automatic Entities CRUD
      Config[TMVCConfigKey.MaxEntitiesRecordCount] := dotEnv.Env('dmvc.max_entities_record_count', IntToStr(TMVCConstants.MAX_RECORD_COUNT));
      //Enable Server Signature in response
      Config[TMVCConfigKey.ExposeServerSignature] := dotEnv.Env('dmvc.expose_server_signature', 'false');
      //Enable X-Powered-By Header in response
      Config[TMVCConfigKey.ExposeXPoweredBy] := dotEnv.Env('dmvc.expose_x_powered_by', 'true');
      // Max request size in bytes
      Config[TMVCConfigKey.MaxRequestSize] := dotEnv.Env('dmvc.max_request_size', IntToStr(TMVCConstants.DEFAULT_MAX_REQUEST_SIZE));
    end);

  FMVC.AddController(TProdutoController)
      .AddController(TCategoriaController);

  lSwagInfo.Title := 'KhipoAPI Swagger';
  lSwagInfo.Version := 'v1';
  lSwagInfo.Description := '';
  lSwagInfo.ContactName := 'Vinicius Furtado';
  lSwagInfo.ContactEmail := 'viniciusfranzzone92@gmail.com';
  lSwagInfo.ContactUrl := 'https://www.linkedin.com/in/vinicius-furtado-papodevdelphi/';
  lSwagInfo.LicenseName := 'Apache v2';
  lSwagInfo.LicenseUrl := 'https://www.apache.org/licenses/LICENSE-2.0';

  FMVC.AddMiddleware(TMVCCORSMiddleware.Create)
      .AddMiddleware(TMVCStaticFilesMiddleware.Create('/swagger', { StaticFilesPath }
                                                      'bin\www', { DocumentRoot }
                                                      'index.html' { IndexDocument }))
      .AddMiddleware(TMVCSwaggerMiddleware.Create(FMVC, lSwagInfo,
                                                  '/api/swagger.json',
                                                  'Method for authentication using JSON Web Token (JWT)'))
      .AddMiddleware(TMVCRoleBasedAuthMiddleware.Create(TCustomRoleAuth.Create,
                                                        '/system/users/logged'));
end;

procedure TKhipoAPIWebModule.WebModuleDestroy(Sender: TObject);
begin
  FMVC.Free;
end;

end.
