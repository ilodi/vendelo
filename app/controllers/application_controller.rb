class ApplicationController < ActionController::Base
    #dar de alta en la app el paginatin
    include Pagy::Backend
    #
    #en cada accion cambia el idioma
    around_action :switch_locale

    def switch_locale(&action)
        I18n.with_locale(locale_from_header, &action)
    end

    private
    def locale_from_header
        #el agregar el & agrega un if para cobrobar 
        request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first 
    end
end
