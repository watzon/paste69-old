class Paste::Show < BrowserAction
  param raw : Bool = false

  get "/p/:hashed_id" do
    id = Hashids.instance.decode(hashed_id).first
    paste = PasteQuery.find(id)
    if raw
      plain_text paste.contents
    else
      html Paste::ShowPage, paste: paste
    end
  end
end
