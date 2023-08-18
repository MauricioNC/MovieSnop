require 'swagger_helper'

RSpec.describe 'Movies API', type: :request do
  path "/movies" do
    get "Get all movies" do
      tags "List all movies"
      security [ { ApiKeyAuth: [] } ]
      produces "application/json"

      response "200", "OK" do
        schema "$ref" => "#/components/schemas/get_all_movies_resp"
        run_test!
      end

      response "422", "Something went wrong" do
        schema "$ref" => "#/components/schemas/error"
        run_test!
      end

      response "401", "Unauthorized" do
        schema "$ref" => "#/components/schemas/error"
        run_test!
      end
    end
  end

  path "/users/{user_id}/movies" do
    get "Get all movies from specific user" do
      tags "Movies - HTTP verbs"
      security [ { ApiKeyAuth: [] } ]
      parameter "$ref" => "#/components/parameters/user_id"
      produces "application/json"

      response "200", "OK" do
        schema "$ref" => "#/components/schemas/get_movies_from_user_resp"
        run_test!
      end

      response "422", "Record not found" do
        schema "$ref" => "#/components/schemas/error"
        run_test!
      end

      response "401", "Unauthorized" do
        schema "$ref" => "#/components/schemas/error"
        run_test!
      end
    end
  end

  path "/users/{user_id}/movies/{id}" do
    get "Show movie" do
      tags "Show specific movie from user"
      security [ { ApiKeyAuth: [] } ]
      parameter "$ref" => "#/components/parameters/user_id"
      parameter "$ref" => "#/components/parameters/movie_id"
      produces "application/json"

      response "200", "OK" do
        schema "$ref" => "#/components/schemas/get_movie"
        run_test!
      end
      
      response "422", "Unprocessable entity" do
        schema "$ref" => "#/components/schemas/error"
        run_test!
      end

      response "401", "Unauthorized" do
        schema "$ref" => "#/components/schemas/error"
        run_test!
      end
    end
  end
end
