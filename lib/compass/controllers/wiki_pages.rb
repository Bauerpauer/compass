class WikiPages
  
  attr_accessor :request, :response, :logger
  
  def show(path)
    page = WikiPage.get(path)

    if page
      response.render "wiki_pages/show", :page => page
    else
      response.render "wiki_pages/edit", :page => WikiPage.new
    end
  end
  
  def update(path, content)
    page = WikiPage.first_or_create(:url => path)

    page.content = content
    page.save!

    response.redirect(request.referrer)
  end
  
end