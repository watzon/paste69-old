class Shared::Navbar < BaseComponent
  needs paste : Paste?

  def render
    nav class: "bg-gray-200 border-gray-200 py-2.5 dark:bg-gray-800" do
      div class: "flex flex-wrap justify-between items-center" do
        a class: "flex items-center px-4", href: ENV["APP_DOMAIN"] do
          span "Paste69", class: "self-center text-xl font-semibold whitespace-nowrap dark:text-white"
        end
        div class: "flex items-center px-4 justify-between lg:order-2" do
          if current_page?(Paste::Index)
            # Save button
            button id: "save-paste", type: "submit", class: "px-4 py-2 mr-4 rounded-md focus:outline-none focus:shadow-outline-blue dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700" do
              i class: "fas fa-save fa-lg"
            end

            # Programming language selector
            tag "select", id: "language-selector", name: "paste:language", class: "block w-full px-3 py-2 mr-4 text-base leading-6 text-gray-900 transition duration-150 ease-in-out border border-gray-300 rounded-md shadow-sm appearance-none focus:outline-none focus:shadow-outline-blue focus:border-blue-300 sm:text-sm sm:leading-5 dark:bg-gray-700 dark:text-white dark:border-gray-600 dark:focus:border-blue-500" do
              option "Choose a Language", value: "", selected: true
            end
          end

          if paste && current_page?(Paste::Show.with(hashed_id: paste.not_nil!.hashed_id))
            link to: Paste::Fork::Create.with(hashed_id: paste.not_nil!.hashed_id), class: "ml-4 px-4 py-2 rounded-md focus:outline-none focus:shadow-outline-blue dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700", title: "Fork this paste" do
              i class: "fas fa-code-fork fa-lg"
            end
          end

          # Theme toggle
          button id: "theme-toggle", class: "px-4 py-2 rounded-md focus:outline-none focus:shadow-outline-blue dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700", title: "Toggle theme" do
            span id: "light-icon", class: "hidden" do
              i class: "fas fa-sun fa-lg"
            end
            span id: "dark-icon" do
              i class: "fas fa-moon fa-lg"
            end
          end
        end
        div class: "hidden justify-between items-center w-full lg:flex lg:w-auto lg:order-1" do
          if paste && current_page?(Paste::Show.with(hashed_id: paste.not_nil!.hashed_id))
            div class: "flex justify-between items-center gap-4" do
              button type: "button", class: "px-4 py-2 rounded-md cursor-copy text-gray-600 dark:text-gray-400 focus:outline-none dark:text-gray-300 hover:text-gray-700 dark:hover:text-gray-300", onclick: "copyValue('#{paste.not_nil!.link}')", title: "Copy link" do
                span "/#{paste.not_nil!.hashed_id}", class: "text-lg font-medium mr-2"
                i class: "fas fa-copy fa-lg"
              end
            end
          elsif paste && current_page?(Paste::Index.with(fork_of: paste.not_nil!.hashed_id))
            div class: "flex justify-between items-center gap-4" do
              span class: "px-4 py-2 rounded-md text-gray-600 dark:text-gray-400", title: "Forking #{paste.not_nil!.hashed_id}" do
                i class: "fas fa-code-fork fa-lg mr-2"
                span "/#{paste.not_nil!.hashed_id}", class: "text-lg font-medium"
              end
            end
          end
        end
      end
    end
  end
end
