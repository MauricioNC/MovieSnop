require 'swagger_helper'

RSpec.describe 'api/authorization', type: :request do
  path "/auth/login" do
    post "Generates JWT token" do
      tags "Authorization with JWT token"
      parameter name: :auth, in: :query, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }
      produces "application/json"

      response "200", "Valid credentials" do
        let(:auth) { { email: "mauricio@gmail.com", password: "123456" } }


        schema  type: :object,
                properties: {
                  token: { type: :string },
                  time: { type: :string },
                  username: { type: :string },
                }

        run_test!
      end

      response "401", "Unauthorized" do
        let(:Authorization) { "SGsdfgsgss" }
        let(:auth) { { email: "ma11uricio@gmail.com", password: "123456dfgdf" } }
        run_test!
      end
    end
  end
end
