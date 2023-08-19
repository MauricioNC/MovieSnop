# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000/api/v1',
          variables: {
            defaultHost: {
              default: 'localhost:3000/api/v1'
            }
          }
        }
      ],
      components: {
        securitySchemes: {
          ApiKeyAuth: {
            type: :apiKey,
            in: :header,
            name: :Authorization
          }
        },
        parameters: {
          user_id: {
            name: :user_id,
            in: :path,
            required: true,
            schema: { type: :string }
          },
          movie_id: {
            name: :movie_id,
            in: :path,
            required: true,
            schema: { type: :string }
          },
          movie_params: {
            name: :movie,
            in: :query,
            required: true,
            schema: {
              type: :object,
              properties: {
                movie: {
                  type: :object,
                  properties: {
                    title: { type: :string },
                    duration: { type: :string },
                    thriller_link: { type: :string },
                    public_date: { type: :string },
                    director_id: { type: :number }
                  }
                }
              }
            }
          }
        },
        schemas: {
          get_all_movies_resp: {
            type: :object,
            properties: {
              data: {
                type: :array,
                items: { type: :string }
              },
              status: { type: :integer }
            }
          },
          get_movies_from_user_resp: {
            type: :object,
            properties: {
              movies: {
                type: :array,
                items: { type: :string }
              },
              status: { type: :integer }
            }
          },
          get_movie: {
            type: :object,
            properties: {
              movie: { type: :string },
              status: { type: :integer }
            }
          },
          movie_message_response: {
            type: :object,
            properties: {
              message: { type: :string },
              status: { type: :integer }
            }
          },
          comment_response: {
            type: :object,
            properties: {
              movie: { type: :object },
              comment: { type: :object },
              status: { type: :integer }
            }
          },
          create_comment: {
            type: :object,
              properties: {
                comment: {
                  type: :object,
                  properties: {
                    comment: { type: :string },
                    rate: { type: :string },
                    user_id: { type: :integer },
                    commentable_type: { type: :string },
                    commentable_id: { type: :integer }
                  }
                }
              }
          },
          error: {
            type: :object,
            properties: {
              error: { type: :string },
              status: { type: :integer },
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
