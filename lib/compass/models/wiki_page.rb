class WikiPage
  
  WIKI_WORD = /([A-Z][a-z0-9]+([A-Z][a-z0-9]+)+)/
  
  include DataMapper::Resource
  
  property :url, String, :size => 500, :key => true
  property :content, Text
  
  def self.format_text(root, text)
    text.gsub(WIKI_WORD) do |match|
      %Q{<a href="#{root}/#{match}">#{match}</a>}
    end
  end
  
end