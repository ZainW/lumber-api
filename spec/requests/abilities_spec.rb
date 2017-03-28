require 'rails_helper'

RSpec.describe 'Abilities API' do
  # Initialize the test data
  let!(:hero) { create(:hero) }
  let!(:abilities) { create_list(:ability, 20, hero_id: hero.id) }
  let(:hero_id) { hero.name }
  let(:id) { abilities.first.id }

  # Test suite for GET /heroes/:hero_id/abilities
  describe 'GET /heroes/:hero_id/abilities' do
    before { get "/heroes/#{hero_id}/abilities" }

    context 'when hero exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all hero abilities' do
        expect(json.count).to eq(20)
      end
    end

    context 'when todo does not exist' do
      let(:hero_id) { "somthingsometing" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(JSON.parse(response.body)["error"]).to match(/Couldn't find Hero/)
      end
    end
  end

  # Test suite for GET /heroes/:hero_id/abilities/:id
  describe 'GET /heroes/:hero_id/abilities/:id' do
    before { get "/heroes/#{hero_id}/abilities/#{id}" }

    context 'when hero ability exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the ability' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when hero ability does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Ability/)
      end
    end
  end

  # Test suite for PUT /heroes/:hero_id/abilities
  describe 'POST /heroes/:hero_id/abilities' do
    let(:valid_attributes) { { name: 'ManaBreak' } }

    context 'when request attributes are valid' do
      before { post "/heroes/#{hero_id}/abilities", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

    end

    context 'when an invalid request' do
      before { post "/heroes/#{hero_id}/abilities", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(JSON.parse(response.body)).to match("name" => ["can't be blank"],)
      end
    end
  end

  # Test suite for PUT /heroes/:hero_id/abilities/:id does not work yet
  # describe 'PUT /heroes/:hero_id/abilities/:id' do
  #   let(:valid_attributes) { { name: 'Menes Break' } }

  #   before { put "/heroes/#{hero_id}/abilities/#{id}", params: valid_attributes }

  #   context 'when item exists' do
  #     it 'returns status code 204' do
  #       expect(response).to have_http_status(204)
  #     end

  #     it 'updates the ability' do
  #       updated_ability = Ability.find(id)
  #       expect(updated_ability.name).to match(/Menes Break/)
  #     end
  #   end

  #   context 'when the ability does not exist' do
  #     let(:id) { 0 }

  #     it 'returns status code 404' do
  #       expect(response).to have_http_status(404)
  #     end

  #     it 'returns a not found message' do
  #       expect(response.body).to match(/Couldn't find Ability/)
  #     end
  #   end
  # end

  # Test suite for DELETE /heroes/:id
  describe 'DELETE /heroes/:id' do
    before { delete "/heroes/#{hero_id}/abilities/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
