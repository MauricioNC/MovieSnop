require 'swagger_helper'

RSpec.describe 'Movies API', type: :request do
  path "/movies" do
    get "Get all movies" do
      tags "Movies - HTTP verbs"
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

  path "/users/{user_id}/movies/{movie_id}" do
    get "Show specific movie from user" do
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

    patch "Update single field from movie record" do
      security [ { ApiKeyAuth: [] } ]
      parameter "$ref" => "#/components/parameters/user_id"
      parameter "$ref" => "#/components/parameters/movie_id"
      parameter "$ref" => "#/components/parameters/movie_params"
      produces "application/json"

      response "200", "OK" do
        schema "$ref" => "#/components/schemas/movie_message_response"
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

    put "Update a completed record from movies" do
      security [ { ApiKeyAuth: [] } ]
      parameter "$ref" => "#/components/parameters/user_id"
      parameter "$ref" => "#/components/parameters/movie_id"
      parameter "$ref" => "#/components/parameters/movie_params"
      produces "application/json"

      response "200", "OK" do
        schema "$ref" => "#/components/schemas/movie_message_response"
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

    delete "Delete a movie" do
      security [ { ApiKeyAuth: [] } ]
      parameter "$ref" => "#/components/parameters/user_id"
      parameter "$ref" => "#/components/parameters/movie_id"

      produces "application/json"

      response "200", "OK" do
        schema "$ref" => "#/components/schemas/movie_message_response"
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
