unit KhipoAPI.Produto.Model;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  System.Generics.Collections;

type
  [MVCNameCase(ncCamelCase)]
  TCategoria = class
  private
    FIdentificador : Integer;
    FNome: String;
    function getIdentificador: Integer;
    function getNome: String;
    procedure setIdentificador(const Value: Integer);
    procedure setNome(const Value: String);
  public
    property Identificador: Integer read getIdentificador write setIdentificador;
    property Nome: String read getNome write setNome;
  end;

  TCategoriaList = TObjectList<TCategoria>;

  [MVCNameCase(ncCamelCase)]
  TProduto = class
  private
    FIdentificador : Integer;
    FNome: String;
    FPreco: Currency;
    FQuantidade: Double;
    FCategoria: TCategoria;
    function getIdentificador: Integer;
    function getNome: String;
    function getPreco: Currency;
    function getQuantidade: Double;
    function getCategoria: TCategoria;
    procedure setIdentificador(const Value: Integer);
    procedure setNome(const Value: String);
    procedure setPreco(const Value: Currency);
    procedure setQuantidade(const Value: Double);
    procedure setCategoria(const Value: TCategoria);
  public
    constructor Create;
    property Identificador: Integer read getIdentificador write setIdentificador;
    property Nome: String read getNome write setNome;
    property Preco: Currency read getPreco write setPreco;
    property Quantidade: Double read getQuantidade write setQuantidade;
    property Categoria: TCategoria read getCategoria write setCategoria;
    destructor Destroy; override;
  end;

  TProdutoList = TObjectList<TProduto>;

implementation

{ TProduto }

constructor TProduto.Create;
begin
  inherited Create;
  FNome := '';
  FPreco := 0;
  FQuantidade := 0;
  FCategoria := TCategoria.Create;
end;

destructor TProduto.Destroy;
begin
  if Assigned(FCategoria) then
    FCategoria.Free;
  inherited;
end;

function TProduto.getCategoria: TCategoria;
begin
  result := FCategoria;
end;

function TProduto.getIdentificador: Integer;
begin
  result := FIdentificador;
end;

function TProduto.getNome: String;
begin
  result := FNome;
end;

function TProduto.getPreco: Currency;
begin
  result := FPreco;
end;

function TProduto.getQuantidade: Double;
begin
  result := FQuantidade;
end;

procedure TProduto.setCategoria(const Value: TCategoria);
begin
  FCategoria := Value;
end;

procedure TProduto.setIdentificador(const Value: Integer);
begin
  FIdentificador := Value;
end;

procedure TProduto.setNome(const Value: String);
begin
  FNome := Value;
end;

procedure TProduto.setPreco(const Value: Currency);
begin
  FPreco := Value;
end;

procedure TProduto.setQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

{ TCategoria }

function TCategoria.getIdentificador: Integer;
begin
  result := FIdentificador;
end;

function TCategoria.getNome: String;
begin
  result := FNome;
end;

procedure TCategoria.setIdentificador(const Value: Integer);
begin
  FIdentificador := Value;
end;

procedure TCategoria.setNome(const Value: String);
begin
  FNome := Value;
end;

end.
