require 'swagger_helper'

describe 'Users API' do

  path '/api/v1/users' do

    get 'Retrieves a paginated list of users' do
      tags 'Users'
      produces 'application/json'
      parameter name: :page, in: :query, required: false, schema: { type: :string }, description: 'The page number in a list of paginated results'
      parameter name: :per_page, in: :query, required: false, schema: { type: :string }, description: 'The number of results per page'
      parameter name: :filters, in: :query, required: false, schema: {
        type: :object,
        properties: {
          by_timezone: { type: :string },
          with_skill: { type: :string },
          by_global_admin: { type: :boolean },
          by_receive_marketing: { type: :boolean }
        }
      }, description: 'Filter results by chosen fields. Filterable options are `by_timezone`, `with_skill`, `by_global_admin`, `by_receive_marketing`.'
      parameter name: :search, in: :query, required: false, schema: { type: :string }, description: 'Search for records with `email`, `name`, `timezone`, `external_id`, or `skills` matching your specified criteria.'

      response '200', 'Users found' do
        before { create_list(:user, 2) }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        run_test!
      end
    end

    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json', 'application/xml'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          name: { type: :string },
          global_admin: { type: :boolean },
          timezone: { type: :string },
          receive_marketing: { type: :boolean },
          external_id: { type: :string },
          skills: {
            type: :array,
            items: { type: :string }
          },
        }
      }

      response '201', 'user created' do
        let(:user) do
          {
            email: Faker::Internet.email,
            name: Faker::FunnyName.name,
            global_admin: false,
            timezone: 'EST',
            receive_marketing: false,
            external_id: Faker::Alphanumeric.alphanumeric(10),
            skills: [
              Faker::Verb.ing_form,
              Faker::Verb.ing_form
            ].uniq
          }
        end

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { title: 'foo' } }

        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do

    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'user found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            email: { type: :string, 'x-nullable': true },
            name: { type: :string, 'x-nullable': true },
            global_admin: { type: :boolean },
            timezone: { type: :string, 'x-nullable': true },
            receive_marketing: { type: :boolean },
            external_id: { type: :string, 'x-nullable': true },
            skills: {
              type: :array,
              items: { type: :string }
            },
          },
          required: ['id']

        let(:id) { create(:user).id }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }

        run_test!
      end
    end

    delete 'Deletes a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      produces 'application/json'

      response '204', 'Destroy the user' do
        let(:id) { create(:user).id }

        run_test!
      end
    end

  end
end
