class Letscookfrench

  def search(ingredient, difficulty_level)
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?s=#{ingredient}&type=all"
    file = open(url)  # or 'strawberry.html'
    doc = Nokogiri::HTML(File.open(file)) #, nil, )'utf-8')
    array_name = extract(doc, '.m_titre_resultat')

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

    array = array.select {|recipe| recipe[:difficulty] == difficulty_level} unless difficulty_level == "all"
  end

  def extract(doc, search_word)
      array = []
      doc.search(search_word).each do |element|
      array << element.text.strip
    end
    array
  end

end
