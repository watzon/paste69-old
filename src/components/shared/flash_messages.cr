class Shared::FlashMessages < BaseComponent
  needs flash : Lucky::FlashStore

  def render
    flash.each do |flash_type, flash_message|
      div class: "#{type_to_tailwind_class(flash_type)} text-center py-2", flow_id: "flash" do
        raw flash_message
      end
    end
  end

  def type_to_tailwind_class(type)
    case type
    when :success
      "bg-green-100 border-green-400 text-green-700 dark:bg-green-900 dark:border-green-700 dark:text-green-100"
    when :failure
      "bg-red-100 border-red-400 text-red-700 dark:bg-red-900 dark:border-red-700 dark:text-red-100"
    when :notice
      "bg-blue-100 border-blue-400 text-blue-700 dark:bg-blue-900 dark:border-blue-700 dark:text-blue-100"
    else
      "bg-gray-100 border-gray-400 text-gray-700 dark:bg-gray-900 dark:border-gray-700 dark:text-gray-100"
    end
  end
end
