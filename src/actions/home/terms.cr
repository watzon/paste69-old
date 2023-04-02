class Home::Terms < BrowserAction
  get "/terms" do
    html Home::TermsPage
  end
end
