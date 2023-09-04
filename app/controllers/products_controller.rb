class ProductsController < ApplicationController
    def index
        #consula a la base de datos
        @products = Product.all
    end
    def show
        @product = Product.find(
            params[:id]
        )
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
            notice: 'Tu producto esta creado'
        else 
            #si algo sale mal se limpia 
            #status: :unprocessable_entity mandara un error 422 de que no se puedo
            render :new, 
            status: :unprocessable_entity
        end
    end
    #funcion privada/local
    #permitri que solo eso se
    def product_params
        params
        .require(
            :product
        )
        .permit(
            :title, 
            :description, 
            :price
        )
    end
end