require 'swagger_helper'

RSpec.describe 'auth', type: :request do
  path '/login' do
    post 'authenticate user with credentials' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      let(:user) { create(:user, password: 'password') }

      response 200, 'successful' do
        schema type: :object, properties: {
          data: {
            type: :object,
            properties: { token: { type: :string } }
          }
        }

        let(:payload) { { email: user.email, password: 'password' } }
        run_test!
      end

      response 401, 'wrong credentials' do
        let(:payload) { { email: user.email, password: 'wrong_password' } }
        run_test!
      end
    end
  end

  path '/register' do
    post 'register new user' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[name email password password_confirmation]
      }

      response 201, 'successful' do
        schema type: :object, properties: { data: { '$ref' => '#/components/schemas/user' } }

        let(:payload) { attributes_for(:user, password: 'password', password_confirmation: 'password') }
        run_test!
      end
    end
  end
end
