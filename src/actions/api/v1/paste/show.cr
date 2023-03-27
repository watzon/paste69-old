class API::V1::Paste::Show < ApiAction
  get "/api/v1/paste/:hashed_id" do
    id = Hashids.instance.decode(hashed_id).first
    paste = PasteQuery.find(id)
    json PasteSerializer.new(paste)
  end
end
