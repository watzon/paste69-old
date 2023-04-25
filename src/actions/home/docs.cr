class Home::Docs < BrowserAction
  get "/docs" do
    html Home::DocsPage
  end
end
