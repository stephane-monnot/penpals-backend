require 'rails_helper'

RSpec.describe 'Messages API', type: :request do
  # initialize test data
  let!(:messages) { create_list(:message, 10) }
  let(:message_id) { messages.first.id }

  # Test suite for GET /messages
  describe 'GET /messages'  do
    # make HTTP get requests before each example
    before { get '/messages' }

    it 'returns messages' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /messages/:id
  describe 'GET /messages/:id' do
    before { get "/messages/#{message_id}" }

    context 'when the record exists' do
      it 'returns the message' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(message_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:message_id) { 100 }

      it 'returns status code 400' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Message/)
      end
    end
  end

  # Test suite for POST /messages
  describe 'POST /messages' do
    # valid payload
    let(:valid_attributes) do
      { title: 'Looking for pen pals', content: 'Hi, I\'m looking for pen pals', created_by: '1' }
    end

    context 'when the request is valid' do
      before { post '/messages', params: valid_attributes }

      it 'creates a message' do
        expect(json['title']).to eq('Looking for pen pals')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/messages', params: { title: 'フーバー' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Content can't be blank, Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /messages/:id
  describe 'PUT /messages/:id' do
    let(:valid_attributes) { { title: 'Looking for a girlfriend' } }

    context 'when the record exists' do
      before { put "/messages/#{message_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /messages/:id
  describe 'DELETE /messages/:id' do
    before { delete "/messages/#{message_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
