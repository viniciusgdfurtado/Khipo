unit KhipoAPI.RoleAuthHandler.Controller;

interface

uses
  MVCFramework.Commons,
  MVCFramework,
  MVCFramework.Swagger.Commons,
  System.Generics.Collections,
  MVCFramework.Middleware.Authentication.RoleBasedAuthHandler;

type
  TCustomRoleAuth = class(TRoleBasedAuthHandler)
  public
    procedure OnAuthentication(const AContext: TWebContext;
      const UserName: string;
      const Password: string;
      UserRoles: TList<System.string>;
      var IsValid: Boolean;
      const SessionData: TDictionary<string,string>); override;
  end;

implementation

{ TCustomRoleAuth }

procedure TCustomRoleAuth.OnAuthentication(const AContext: TWebContext; const UserName: string; const Password: string;
      UserRoles: TList<System.string>; var IsValid: Boolean;
      const SessionData: System.Generics.Collections.TDictionary<System.string,
      System.string>);
begin
  IsValid := False;
  if (UserName = 'admin') and (Password = 'adminpass') then
  begin
    IsValid := True;
  end;
end;

end.
