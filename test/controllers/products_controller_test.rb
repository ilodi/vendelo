require 'test_helper'

class ProductsControlllerTest < ActionDispatch::IntegrationTest
    test 'render a list of products' do
        get products_path 
        assert_response :success
        #trae todo lo de la base de datos?
        #fictures/products.yml
        #ve a la clase '.', trae 2 productos
        assert_select '.product', 3

    end

    test 'render a detailed product page' do
        #ya tenemos acceso a la base de datos
        get product_path(products(:switch))
        #comprueba que todo se cumpla
        assert_response :success
        #comprueba que se muestre lo siguiente
        assert_select '.title', 'Nintendo'
        assert_select '.descrption', 'es el switch'
        assert_select '.price', '$149'
    end

    test 'render a new product form' do
        get new_product_path
        assert_response :success
        assert_select 'form'
    end

    test 'allows to create a new product' do
        post products_path, params: {
            product: {
                title: 'Nintendo 64',
                description: 'Le faltan los cables',
                price: 45,
                category_id: categories(:videogames).id
            }
        }
        assert_redirected_to products_path
        assert_equal flash[:notice],
        'Tu producto esta creado'
    end

    test 'does not allows to create a new product with empty  fields' do
        post products_path, params: {
            product: {
                title: '',
                description: 'Le faltan los cables',
                price: 45
            }
        }
        assert_response :unprocessable_entity
    end
    
    test 'render an edit product form' do
        get edit_product_path(products(:switch))
        assert_response :success
        assert_select 'form'
    end

    test 'allows to update a new product' do
        patch product_path(products(:switch)), params: {
            product: {
                price: 145
            }
        }
        assert_redirected_to products_path
        assert_equal flash[:notice], 
        'Tu producto esta actualizado'
    end

    test 'does not allow to update a new with an invalid field' do
        patch product_path(products(:switch)), params: {
            product: {
                price: nil
            }
        }
        assert_response :unprocessable_entity
    end

    test 'can delete products' do
        #busquemos diferencias para que al borrar veamos que 
        #la diferencia esque uno se elimino
        assert_difference('Product.count', -1) do
            delete product_path(products(:switch))
        end
        #si todo bien te mando a la ruta principal
        assert_redirected_to products_path
        #te muestro un mensaje
        assert_equal flash[:notice], 
        'Tu producto esta eliminado'
    end
end

