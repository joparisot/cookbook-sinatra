
require 'nokogiri'
require 'open-uri'

def test(ingredient)
  url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?s=#{ingredient}&type=all"
  file = open(url)  # or 'strawberry.html'
  doc = Nokogiri::HTML(File.open(file)) #, nil, 'utf-8')

  array_links = []
      doc.search('.m_titre_resultat > a').each do |element|
      array_links << "http://www.letscookfrench.com#{element.attribute('href').to_s}"
    end

  array = []
  array_links.each do |link|
  file = open(link)  # or 'strawberry.html'
  doc = Nokogiri::HTML(File.open(file))
  temp_hash = {}
    temp_hash[:cooking_time] = doc.search('.cooktime').text
    temp_hash[:name] = doc.search('.m_title > .item > .fn').text
    match_data = doc.search('.m_content_recette_breadcrumb').text.match(/(Easy|Very easy|Moderate|Difficult)/)
    temp_hash[:difficulty] = match_data[1]
    array << temp_hash
  end

  array
end

p test("apple")


# in controller, should it be in the controller class?
# in controller, you should call a view method displaying the next option"
# 1. which ingredient?
# 2 display the result
# 3. aks which one to add
