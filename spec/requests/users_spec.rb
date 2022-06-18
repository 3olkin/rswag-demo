require 'swagger_helper'

RSpec.describe 'users', type: :request do
  path '/users/whoami' do
    get 'retrieve current user from jwt' do
      produces 'application/json'
      security [bearer_auth: []]

      response 200, 'successful' do
        schema type: :object, properties: { data: { '$ref' => '#/components/schemas/user' } }

        let(:user) { create(:user) }
        let(:Authorization) { access_token_for(user) }
        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) {}
        run_test!
      end
    end
  end
end
