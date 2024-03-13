unit KhipoAPI.Produto.Controller;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  MVCFramework.Logger,
  MVCFramework.Swagger.Commons,
  System.SysUtils,
  KhipoAPI.Produto.Model;

type
  [MVCPath('/api')]
  TAPIController = class(TMVCController)
  public
    [MVCSwagSummary('API', 'Verificação Status', 'Index')]
    [MVCSwagResponses(HTTP_STATUS.OK, 'Status')]
    [MVCPath('/status')]
    [MVCHTTPMethod([httpGET])]
    procedure Index;
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;
  end;

  [MVCPath('/api/produto')]
  TProdutoController = class(TMVCController)
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;
  public
    [MVCSwagSummary('Produtos', 'Lista todos os Produtos', 'getProduto')]
    [MVCSwagResponses(HTTP_STATUS.OK, 'Produtos', TProdutoList, True)]
    [MVCSwagResponses(HTTP_STATUS.BadRequest, 'Requisição Inválida', TMVCErrorResponse)]
    [MVCSwagResponses(HTTP_STATUS.NotFound, 'Registro não Encontrado', TMVCErrorResponse)]
    [MVCRequiresAuthentication]
    [MVCPath('/')]
    [MVCHTTPMethod([httpGET])]
    function GetProduto: TProdutoList; overload;

    [MVCSwagSummary('Produto', 'Lista um dos Produtos baseado no Identificador', 'getProdutoByID')]
    [MVCSwagParam(plPath, 'ID', 'Identificador Produto', ptInteger, True)]
    [MVCSwagResponses(HTTP_STATUS.OK, 'Produto', TProduto)]
    [MVCSwagResponses(HTTP_STATUS.BadRequest, 'Requisição Inválida', TMVCErrorResponse)]
    [MVCSwagResponses(HTTP_STATUS.NotFound, 'Registro não Encontrado', TMVCErrorResponse)]
    [MVCRequiresAuthentication]
    [MVCPath('/($ID)')]
    [MVCHTTPMethod([httpGET])]
    function GetProdutoByID(ID: Integer): TProduto; overload;

    [MVCSwagSummary('Produto', 'Cria um Produto', 'createProduto')]
    [MVCSwagParam(plBody, 'Produtos', 'Produto JSON Object', TProduto)]
    [MVCSwagResponses(HTTP_STATUS.Created, 'Produto Criado')]
    [MVCSwagResponses(HTTP_STATUS.BadRequest, 'Requisição Inválida', TMVCErrorResponse)]
    [MVCRequiresAuthentication]
    [MVCPath('/')]
    [MVCHTTPMethod([httpPOST])]
    function CreateProduto([MVCFromBody] Produto: TProduto): IMVCResponse;

    [MVCSwagSummary('Produto', 'Atualiza um Produto', 'updateProduto')]
    [MVCSwagParam(plBody, 'Produto', 'Produto JSON Object', TProduto, ptNotDefined, True)]
    [MVCSwagParam(plPath, 'ID', 'ID do Produto para Atualização', ptInteger, True)]
    [MVCSwagResponses(HTTP_STATUS.NoContent, 'No Content')]
    [MVCSwagResponses(HTTP_STATUS.BadRequest, 'Requisição Inválida', TMVCErrorResponse)]
    [MVCSwagResponses(HTTP_STATUS.NotFound, 'Registro não Encontrado', TMVCErrorResponse)]
    [MVCRequiresAuthentication]
    [MVCPath('/($ID)')]
    [MVCHTTPMethod([httpPUT])]
    function UpdateProduto(ID: Integer; [MVCFromBody] Produto: TProduto): IMVCResponse;

    [MVCSwagSummary('Produto', 'Deleta um Produto', 'deleteProduto')]
    [MVCSwagParam(plPath, 'ID', 'ID do Produto para Deleção', ptInteger, True)]
    [MVCSwagResponses(HTTP_STATUS.NoContent, 'No Content')]
    [MVCSwagResponses(HTTP_STATUS.BadRequest, 'Requisição Inválida', TMVCErrorResponse)]
    [MVCSwagResponses(HTTP_STATUS.NotFound, 'Registro não Encontrado', TMVCErrorResponse)]
    [MVCRequiresAuthentication]
    [MVCPath('/($ID)')]
    [MVCHTTPMethod([httpDELETE])]
    function DeleteProduto(ID: Integer): IMVCResponse;

  end;

  [MVCPath('/api/categoria')]
  TCategoriaController = class(TMVCController)
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;
  public
    [MVCSwagSummary('Categorias', 'Lista todas as Categorias', 'getCategoria')]
    [MVCSwagResponses(HTTP_STATUS.OK, 'Categorias', TCategoriaList, True)]
    [MVCSwagResponses(HTTP_STATUS.BadRequest, 'Requisição Inválida', TMVCErrorResponse)]
    [MVCSwagResponses(HTTP_STATUS.NotFound, 'Registro não Encontrado', TMVCErrorResponse)]
    [MVCRequiresAuthentication]
    [MVCPath('/')]
    [MVCHTTPMethod([httpGET])]
    function GetCategoria: TCategoriaList; overload;

    [MVCSwagSummary('Categoria', 'Lista uma Categoria por Identificador', 'getCategoriaByID')]
    [MVCSwagParam(plPath, 'ID', 'Identificador Categoria', ptInteger, True)]
    [MVCSwagResponses(HTTP_STATUS.OK, 'Categoria', TCategoria, True)]
    [MVCSwagResponses(HTTP_STATUS.BadRequest, 'Requisição Inválida', TMVCErrorResponse)]
    [MVCSwagResponses(HTTP_STATUS.NotFound, 'Registro não Encontrado', TMVCErrorResponse)]
    [MVCRequiresAuthentication]
    [MVCPath('/($ID)')]
    [MVCHTTPMethod([httpGET])]
    function GetCategoriaByID(ID: Integer): TCategoria;

    [MVCSwagSummary('Categoria', 'Cria uma Categoria', 'createCategoria')]
    [MVCSwagParam(plBody, 'Categoria', 'Categoria JSON Object', TCategoria)]
    [MVCSwagResponses(HTTP_STATUS.Created, 'Categoria Criada')]
    [MVCSwagResponses(HTTP_STATUS.BadRequest, 'Requisição Inválida', TMVCErrorResponse)]
    [MVCRequiresAuthentication]
    [MVCPath('/')]
    [MVCHTTPMethod([httpPOST])]
    function CreateCategoria([MVCFromBody] Categoria: TCategoria): IMVCResponse;

    [MVCSwagSummary('Categoria', 'Atualiza Categoria', 'updateCategoria')]
    [MVCSwagParam(plBody, 'Categoria', 'Categoria JSON Object', TCategoria, ptNotDefined, True)]
    [MVCSwagParam(plPath, 'ID', 'ID do Categoria para Atualização', ptInteger, True)]
    [MVCSwagResponses(HTTP_STATUS.NoContent, 'No Content')]
    [MVCSwagResponses(HTTP_STATUS.BadRequest, 'Requisição Inválida', TMVCErrorResponse)]
    [MVCSwagResponses(HTTP_STATUS.NotFound, 'Registro não Encontrado', TMVCErrorResponse)]
    [MVCRequiresAuthentication]
    [MVCPath('/($ID)')]
    [MVCHTTPMethod([httpPUT])]
    function UpdateCategoria(ID: Integer; [MVCFromBody] Categoria: TCategoria): IMVCResponse;

    [MVCSwagSummary('Categoria', 'Deleta um Categoria', 'deleteCategoria')]
    [MVCSwagParam(plPath, 'ID', 'ID do Categoria para Deleção', ptInteger, True)]
    [MVCSwagResponses(HTTP_STATUS.NoContent, 'No Content')]
    [MVCSwagResponses(HTTP_STATUS.BadRequest, 'Requisição Inválida', TMVCErrorResponse)]
    [MVCSwagResponses(HTTP_STATUS.NotFound, 'Registro não Encontrado', TMVCErrorResponse)]
    [MVCRequiresAuthentication]
    [MVCPath('/($ID)')]
    [MVCHTTPMethod([httpDELETE])]
    function DeleteCategoria(ID: Integer): IMVCResponse;

  end;


implementation

procedure TProdutoController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  inherited;
end;

procedure TProdutoController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  inherited;
end;

function TProdutoController.GetProduto: TProdutoList;
var
  lProduto: TProdutoList;
begin
  Result := nil;
  lProduto := TProdutoList.Create(True);
  try
    Result := lProduto;
  except
    Result.Free;
    raise;
  end;
end;

function TProdutoController.GetProdutoByID(ID: Integer): TProduto;
var
  lProduto: TProdutoList;
begin
  lProduto := GetProduto;
  try
    Result := lProduto.ExtractAt(ID mod lProduto.Count);
  finally
    lProduto.Free;
  end;
end;

function TProdutoController.CreateProduto([MVCFromBody] Produto: TProduto): IMVCResponse;
begin
  LogI('Criado Produto: ' + Produto.Nome + ' Categoria: ' + Produto.Categoria.Nome);
  Result := MVCResponseBuilder.StatusCode(HTTP_STATUS.Created)
                              .Body('Produto Criado')
                              .Build;
end;

function TProdutoController.UpdateProduto(ID: Integer; [MVCFromBody] Produto: TProduto): IMVCResponse;
begin
  LogI('Atualizado Produto: ' + Produto.Nome + ' Categoria: ' + Produto.Categoria.Nome);
  Result := MVCResponseBuilder.StatusCode(HTTP_STATUS.NoContent)
                              .Build;
end;

function TProdutoController.DeleteProduto(ID: Integer): IMVCResponse;
begin
  LogI('Deletado Produto: ' + ID.ToString);
  Result := MVCResponseBuilder.StatusCode(HTTP_STATUS.NoContent)
                              .Build;
end;

{ TCategoriaController }

function TCategoriaController.CreateCategoria([MVCFromBody] Categoria: TCategoria): IMVCResponse;
begin
  LogI('Criada Categoria: ' + Categoria.Nome);
  Result := MVCResponseBuilder.StatusCode(HTTP_STATUS.Created)
                              .Body('Produto Criado')
                              .Build;
end;

function TCategoriaController.DeleteCategoria(ID: Integer): IMVCResponse;
begin
  LogI('Deletada Categoria: ' + ID.ToString);
  Result := MVCResponseBuilder.StatusCode(HTTP_STATUS.NoContent)
                              .Build;
end;

function TCategoriaController.GetCategoria: TCategoriaList;
var
  lCategoria: TCategoriaList;
begin
  Result := nil;
  lCategoria := TCategoriaList.Create(True);
  try
    Result := lCategoria;
  except
    Result.Free;
    raise;
  end;
end;

function TCategoriaController.GetCategoriaByID(ID: Integer): TCategoria;
var
  lCategoria: TCategoriaList;
begin
  lCategoria := GetCategoria;
  try
    Result := lCategoria.ExtractAt(ID mod lCategoria.Count);
  finally
    lCategoria.Free;
  end;
end;

procedure TCategoriaController.OnAfterAction(Context: TWebContext;
  const AActionName: string);
begin
  inherited;

end;

procedure TCategoriaController.OnBeforeAction(Context: TWebContext;
  const AActionName: string; var Handled: Boolean);
begin
  inherited;

end;

function TCategoriaController.UpdateCategoria(ID: Integer;
  Categoria: TCategoria): IMVCResponse;
begin
  LogI('Atualizada Categoria: ' + Categoria.Nome);
  Result := MVCResponseBuilder.StatusCode(HTTP_STATUS.NoContent)
                              .Build;
end;

{ TAPIController }

procedure TAPIController.Index;
begin
  Render(MVCResponseBuilder.StatusCode(HTTP_STATUS.OK)
                           .Body('API Produto - Online')
                           .Build);
end;

procedure TAPIController.OnAfterAction(Context: TWebContext;
  const AActionName: string);
begin
  inherited;

end;

procedure TAPIController.OnBeforeAction(Context: TWebContext;
  const AActionName: string; var Handled: Boolean);
begin
  inherited;

end;

end.
