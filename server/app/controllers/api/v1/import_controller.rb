module Api
  module V1
    class ImportController < ApiController
      skip_before_action :auth_with_token!, only: [:index]

      def index
        import = ItemsImport.new
        import.import
      end

      private

      def note_params
        params.require(:note).permit(:title, :content)
      end
    end
  end
end
