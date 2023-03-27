class Paste::Index < BrowserAction
  param fork_of : String?

  get "/" do
    if hashed_id = fork_of
      paste = PasteQuery.from_hashed_id(hashed_id)
    end
    html Paste::IndexPage, fork_of: paste
  end
end
