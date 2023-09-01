class ProductsController < ApplicationController
    def index
        #consula a la base de datos
        @products = Product.all
    end
    def show
        @product = Product.find(params[:id])
    end
    def new
        
    end
end