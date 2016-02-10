class Item < ActiveRecord::Base
  belongs_to :paper
  accepts_nested_attributes_for :paper
  validates_presence_of :name

  def self.split_multi_params(params)
    if params[:name_list].nil?
      throw '`name_list` is required.'
    end

    paper_id = (if params[:paper_id].nil? then '' else params[:paper_id] end)
    orderer = (if params[:orderer].nil? then '' else params[:orderer] end)

    result = []
    params[:name_list].split("\r\n").each do |line|
      wedge = / x \w+$/ =~ line
      if wedge.nil?
        name = line
        quantity = ''
      else
        name = line.slice(0, wedge)
        quantity = line.slice(wedge+3, line.size)
      end
      result.push({
        paper_id: paper_id,
        name: name,
        quantity: quantity,
        orderer: orderer
      })
    end
    result
  end
end
