class Paste::Delete < BrowserAction
  param deletion_token : String

  get "/p/:hashed_id/delete" do
    id = Hashids.instance.decode(hashed_id).first
    paste = PasteQuery.find(id)
    if paste.deletion_token == deletion_token
      DeletePaste.delete!(paste)
      flash.success = "Paste deleted successfully."
    else
      flash.failure = "Invalid deletion token."
    end
    redirect to: Paste::Index
  end
end
