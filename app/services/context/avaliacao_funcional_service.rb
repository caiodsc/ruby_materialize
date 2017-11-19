module ContextModule
  class AvaliacaoFuncionalService
    def initialize(action, params)
      # TODO: identify origin
      @action = action
      @params = params
      #@id = params["id"]
    end

    def call
      begin
      #rescue
      end
      case @action
        when 'minha_avaliacao'
          return "Funcionou!"
        else
          return "Não funcionou!"
      end
    end
  end
end
