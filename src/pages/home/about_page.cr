class Home::AboutPage < MainLayout
  def page_title
    "About"
  end

  def content
    div class: "flex flex-col h-screen justify-between" do
      mount Shared::Navbar
      div class: "w-full flex-grow text-gray-800 bg-gray-200 dark:bg-gray-700 dark:text-gray-200" do
        div class: "container mx-auto py-12" do
          h2 "About", class: "font-bold text-4xl mb-4"
        end
      end
      mount Shared::Footer
    end
  end
end
