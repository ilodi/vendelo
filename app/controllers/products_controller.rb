class ProductsController < ApplicationController
    def index
        #consula a la base de datos
        @products = Product.all
    end
end