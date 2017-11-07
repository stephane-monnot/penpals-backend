require 'rails_helper'

RSpec.describe 'Messages API', type: :request do
  # message owner
  let(:user) { create(:user) }
  # other test user
  let(:another_user) { create(:user) }
  # initialize test data
  let!(:messages) { create_list(:message, 10, created_by: user.id) }
  let(:message_id) { messages.first.id }
  # authorize request
  let(:headers) { valid_headers }
  # authorize request
  let(:another_user_headers) { valid_headers_of_another_user }

  # Test suite for GET /messages
  describe 'GET /messages'  do
    # make HTTP get requests before each example
    before { get '/messages', params: {}, headers: headers }

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
    before { get "/messages/#{message_id}", params: {}, headers: headers }

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
      { title: 'Looking for pen pals', content: 'Hi, I\'m looking for pen pals', created_by: user.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/messages', params: valid_attributes, headers: headers }

      it 'creates a message' do
        expect(json['title']).to eq('Looking for pen pals')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:valid_attributes) { { title: nil }.to_json }
      before { post '/messages', params: valid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Title can't be blank, Content can't be blank/)
      end
    end
  end

  # Test suite for PUT /messages/:id
  describe 'PUT /messages/:id' do
    let(:valid_attributes) { { title: 'Looking for a girlfriend' }.to_json }

    context 'when the record exists' do
      before { put "/messages/#{message_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record could not be updated by current user' do
      before { put "/messages/#{message_id}", params: valid_attributes, headers: another_user_headers }

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end

      it 'returns failure message' do
        expect(json['message'])
            .to match(/Forbidden request/)
      end
    end

  end

  # Test suite for DELETE /messages/:id
  describe 'DELETE /messages/:id' do

    context 'when the record can be delete' do
      before { delete "/messages/#{message_id}", headers: headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record could not be deleted by current user' do
      before { delete "/messages/#{message_id}", headers: another_user_headers }

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end

      it 'returns failure message' do
        expect(json['message'])
            .to match(/Forbidden request/)
      end
    end
  end
end
