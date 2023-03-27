class Paste::Fork::Create < BrowserAction
  post "/p/:hashed_id/fork" do
    redirect to: Paste::Index.with(fork_of: hashed_id)
  end
end
