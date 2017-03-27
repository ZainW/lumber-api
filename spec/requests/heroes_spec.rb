require 'rails_helper'

RSpec.describe 'Heroes API', type: :request do

  let!(:heroes) { create_list(:hero, 10) }
  let(:hero_id) { heroes.first.name }

  describe 'GET /heroes' do
    before { get '/heroes' }

    it 'returns heroes' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns code 200 response' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /heroes/:id' do
    before { get "/heroes/#{hero_id}" }

    context 'when the record exists' do
      it 'returns the hero' do
        expect(json).not_to be_empty
        expect(json['name']).to eq(hero_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:hero_id) { "Anti-Mago" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(JSON.parse(response.body)["error"]).to match(/Couldn't find Hero/)
      end
    end
  end
  describe 'POST /heroes' do

    let(:valid_attributes) { { name: "Mage", base_str: 22, base_agi: 22, base_int: 15, add_str: 1.2, add_agi: 2.8, add_int: 1.8, profile_url: "someurl", move_speed: 315, attack_type: "Melee", turn_rate: 0.6,hero_type: "Agility", attack_range: 350 } }

    context 'when the request is valid' do
      before { post '/heroes', params: valid_attributes}

      it 'creates a hero' do
        expect(JSON.parse(response.body)["name"]).to eq('Mage')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/heroes', params: { name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"base_str\":[\"can't be blank\"],\"base_agi\":[\"can't be blank\"],\"base_int\":[\"can't be blank\"],\"add_str\":[\"can't be blank\"],\"add_agi\":[\"can't be blank\"],\"add_int\":[\"can't be blank\"],\"move_speed\":[\"can't be blank\"],\"turn_rate\":[\"can't be blank\"],\"attack_type\":[\"can't be blank\"],\"hero_type\":[\"can't be blank\"],\"attack_range\":[\"can't be blank\"]}")
      end
    end
  end

  describe 'PUT /heroes/:id' do
    let(:valid_attributes) { { name: 'Anti Maggus' } }

    context 'when the record exists' do
      before { put "/heroes/#{hero_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /hero/:id' do
    before { delete "/heroes/#{hero_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
