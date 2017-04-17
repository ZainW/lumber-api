class Item < ApplicationRecord
  validates_presence_of :name
  searchkick
  def search_data
    {
      name: name
    }
  end
end
