abstract class MainLayout
  include Lucky::HTMLPage

  abstract def content

  def page_title
    nil
  end

  def render
    html_doctype

    html lang: "en", class: "w-full h-full dark" do
      mount Shared::LayoutHead, page_title: page_title

      body class: "w-full h-full" do
        mount Shared::FlashMessages, context.flash
        content
        mount Shared::Tracking
      end
    end
  end
end
