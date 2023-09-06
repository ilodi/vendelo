class ProductsController < ApplicationController
    def index
      @categories = Category.all
        #consula a la base de datos
      @products = Product.all.with_attached_photo.order(created_at: :desc)
        
    end
    def show
        product
    end
    def new
        #crea una instancia con todo nill
        @product = Product.new
    end
    def create
        @product = Product.new(
            product_params
        )
        #para mostrar por pantalla una variable usas pp
        #es como el console.log() js.
        #pp @product
        if @product.save
            #si todo bien te manda a la lista de productos
            redirect_to products_path, 
            notice: t('.created')
        else 
            #si algo sale mal se limpia 
            #status: :unprocessable_entity mandara un error 422 de que no se puedo
            render :new, 
            status: :unprocessable_entity
        end
    end
   
    def edit
        product
    end
    def update
        #si todo salio bien, o si hay un deta
        if product.update(product_params)
            redirect_to products_path,
            notice: t('.updated')
        else
            #:unprocessable_entity  = 422
            render :edit, status: :unprocessable_entity 
        end
    end
    def destroy
        #buacar producto
        product.destroy
        redirect_to products_path,
        notice: t('.distroyed'),
        #303 reddit sin historial
        status: :see_other
    end
     #funcion privada/local
    #permitri que solo eso se
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
    #refactorizar
    def product
        #en ruby no se necesita el return, ya esta implisito 
        @product = Product.find(
            params[:id]
        )
    end
end