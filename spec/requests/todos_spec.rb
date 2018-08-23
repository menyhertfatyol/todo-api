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

      it 'returns a 404 status' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
