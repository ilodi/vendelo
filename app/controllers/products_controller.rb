class ProductsController < ApplicationController
  def index
    
    # carga paralela ..load_async
    @categories = Category.order(name: :asc).load_async
    # consula a la base de datos
    @products = Product.with_attached_photo
    if params[:category_id]
        #cuando tu mandes un categori id este se filte con una consulta
        #del tipo where. se tiene que extender products para hacer el filtro
        @products = @products.where(category_id: params[:category_id])
    end
    if params[:min_price].present?
      #sobre escribir la Query con el valor que se paso
      @products = @products.where("price >= ?", params[:min_price])
    end
    if params[:max_price].present?
      #sobre escribir la Query con el valor que se paso
      @products = @products.where("price <= ?", params[:max_price])
    end
    #existe el order by
    #el & comprueba si el parametro existe
    #el segundo parametro de featch, por defecto si no encuentra nada
    #retona lo mas nuevo
    #para acceder a la constante el modelo se usan ::
    orders_by = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])
    

    #extender la query
    @products = @products.order(orders_by).load_async
    
  end

  def show
    product
  end

  def new
    # crea una instancia con todo nill
    @product = Product.new
  end

  def create
    @product = Product.new(
      product_params
    )
    # para mostrar por pantalla una variable usas pp
    # es como el console.log() js.
    # pp @product
    if @product.save
      # si todo bien te manda a la lista de productos
      redirect_to products_path,
                  notice: t('.created')
    else
      # si algo sale mal se limpia
      # status: :unprocessable_entity mandara un error 422 de que no se puedo
      render :new,
             status: :unprocessable_entity
    end
  end

  def edit
    product
  end

  def update
    # si todo salio bien, o si hay un deta
    if product.update(product_params)
      redirect_to products_path,
                  notice: t('.updated')
    else
      # :unprocessable_entity  = 422
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # buacar producto
    product.destroy
    redirect_to products_path,
                notice: t('.distroyed'),
                # 303 reddit sin historial
                status: :see_other
  end
  # funcion privada/local
  # permitri que solo eso se

  private

  def product_params
    params.require(
      :product
    ).permit(
      :title,
      :description,
      :price,
      :photo,
      :category_id
    )
  end

  # refactorizar
  def product
    # en ruby no se necesita el return, ya esta implisito
    @product = Product.find(
      params[:id]
    )
  end
end
