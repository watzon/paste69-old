class API::V1::Paste::Delete < ApiAction
  param deletion_token : String

  delete "/api/v1/paste/:hashed_id" do
    id = Hashids.instance.decode(hashed_id).first
    paste = PasteQuery.find(id)
    if paste.deletion_token == deletion_token
      DeletePaste.delete!(paste)
      json({ success: true })
    else
      json ErrorSerializer.new(success: false, error: "Invalid deletion token", param: "deletion_token")
    end
  end
end
