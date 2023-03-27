class PasteQuery < Paste::BaseQuery
  def self.from_hashed_id(hashed_id)
    id = Hashids.instance.decode(hashed_id).first
    find(id)
  end
end
