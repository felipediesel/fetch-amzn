class ParsePageService
  attr_reader :page

  def initialize(html)
    @page = Nokogiri::HTML(html)
  end

  def dimensions
    page.css('#prodDetails .col1 tr:nth-child(2) > td.value').text
  end

  def ranking
    ranking = []

    first_ranking = page.css('#SalesRank > td.value').children[0]&.text&.strip&.split

    return [] unless first_ranking

    ranking[0] = {
      position: clean_position(first_ranking[0]),
      categories: [first_ranking[2]]
    }

    page.css('#SalesRank > td.value .zg_hrsr_rank').each.with_index do |node, index|
      ranking[index + 1] ||= {}
      ranking[index + 1][:position] = clean_position(node.text)
    end

    page.css('#SalesRank > td.value .zg_hrsr_ladder').each.with_index do |node, index|
      ranking[index + 1] ||= {}
      ranking[index + 1][:categories] = node.text[3..-1].split('>').collect(&:strip)
    end

    ranking
  end

  def categories
    page.css('#wayfinding-breadcrumbs_feature_div li a').collect do |category|
      category.text.strip
    end
  end

  private
    def clean_position(position)
      position[1..-1].gsub(',', '').to_i
    end
end
