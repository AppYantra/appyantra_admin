module AppyantraAdmin
  module Utils
    # generates a random password
    def random_password(size=10)
      chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
      (1..size).collect{|a| chars[rand(chars.size)] }.join
    end

    # returns the list of available page layouts
    def list_page_layouts(layouts=[])
      if layouts.empty?
        layouts_path = Rails.root + "app/views/layouts"
        if Dir.exists? layouts_path
          Dir.foreach(layouts_path) do |file_name|
            if file_name.include? '.html.haml'
              layouts << File.basename(file_name,'.html.haml')
            elsif file_name.include? '.html.erb'
              layouts << File.basename(file_name,'.html.erb')
            end
          end
        end
        layouts << 'application' if layouts.empty?
      end
      layouts
    end
  end
end
