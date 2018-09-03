require 'rails_helper'

RSpec.describe "Todo API", type: :request do
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  describe 'GET /todos' do
    before { get '/todos' }

    it 'returns todos' do
      expect(json_body).not_to be_empty
      expect(json_body.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}" }

    context "When the record exists" do
      it 'returns specific todo' do
        expect(json_body).not_to be_empty
        expect(json_body['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "When the record doesn't exist" do
      let(:todo_id) { 99 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns error message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'GET /todos/:status' do
    context "When status does exist" do
      before { get '/todos?status=incomplete' }

      it 'returns all incomplete todos' do
        expect(json_body.to_s).not_to match(/"status"=>"completed"/)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "When status does not exist" do
      before { get '/todos?status=active' }

      it 'returns empty array' do
        expect(json_body).to eq([])
      end
    end
  end

  describe 'POST /todos' do
    let(:valid_payload) { {name: "Wash the car", description: "The effects of the last off-road experiment's should be washed off...", status: "incomplete", due_at: "2018-09-23T18:00:00.000Z"} }

    context "When request is valid" do
      before { post '/todos', params: valid_payload }

      it 'creates new todo' do
        expect(json_body["name"]).to eq("Wash the car")
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context "When request is invalid" do
      before { post '/todos', params: {name: "Wake up"} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns validation error message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  describe 'PUT /todos/:id' do
    let(:valid_payload) { {name: "Read a book"} }

    context 'When request is valid' do
      before { put "/todos/#{todo_id}", params: valid_payload }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'returns an empty response' do
        expect(response.body).to be_empty
      end
    end
  end

  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
