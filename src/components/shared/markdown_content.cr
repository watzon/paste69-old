class Shared::MarkdownContent < BaseComponent
  def render
    div class: "w-full min-h-full flex-grow bg-[#eff1f5] dark:bg-[#1e1e2e] px-4 py-8" do
      div class: "prose dark:prose-invert lg:prose-xl" do
        yield
      end
    end
  end
end
