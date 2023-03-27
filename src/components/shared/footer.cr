class Shared::Footer < BaseComponent
  def render
    footer class: "bg-gray-200 border-gray-200 py-2.5 dark:bg-gray-800" do
      div class: "text-center text-gray-800 dark:text-gray-200" do
        text "Made with "
        span "❤️", class: "text-red-500"
        text " by "
        a "Chris Watson", href: "https://watzon.tech", class: "underline hover:text-gray-600 dark:hover:text-gray-400"
        text " | "
        link "Privacy Policy", to: Home::PrivacyPolicy, class: "underline hover:text-gray-600 dark:hover:text-gray-400 mr-2"
        # link "About", to: Home::About, class: "underline hover:text-gray-600 dark:hover:text-gray-400"
      end
    end
  end
end
