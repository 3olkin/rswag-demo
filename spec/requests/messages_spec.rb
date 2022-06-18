require 'swagger_helper'

RSpec.describe 'messages', type: :request do
  path '/messages' do
    get 'list messages' do
      produces 'application/json'
      security [{}, { bearer_auth: [] }]

      response 200, 'successful' do
        schema type: :object, properties: {
          data: {
            type: :array,
            items: { '$ref' => '#/components/schemas/message' }
          }
        }

        run_test!
      end
    end

    post 'create message' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          body: { type: :string }
        },
        required: %w[title]
      }
      security [bearer_auth: []]

      let(:payload) { attributes_for(:message) }

      response 201, 'successful' do
        schema type: :object, properties: { data: { '$ref' => '#/components/schemas/message' } }

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

  path '/messages/{id}' do
    parameter name: :id, in: :path, type: :integer

    let(:user) { create(:user) }
    let(:message) { create(:message, user_id: user.id) }
    let(:id) { message.id }

    put 'update message' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          body: { type: :string }
        }
      }
      security [bearer_auth: []]

      let(:payload) { attributes_for(:message) }

      response 200, 'successful' do
        let(:Authorization) { access_token_for(user) }
        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) {}
        run_test!
      end
    end

    delete 'delete message' do
      security [bearer_auth: []]

      response 204, 'successful' do
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
