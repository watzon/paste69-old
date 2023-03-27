class Home::About < BrowserAction
  get "/about" do
    html Home::AboutPage
  end
end
