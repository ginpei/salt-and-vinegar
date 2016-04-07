class Item < ActiveRecord::Base
  belongs_to :paper
  has_and_belongs_to_many :taxes
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

  def tax_list
    unless @tax_list
      all_taxes = paper.book.taxes
      @tax_list = all_taxes.map do |tax|
        { id: tax.id, rate: tax.rate, checked: taxes.include?(tax) }
      end
    end
    @tax_list
  end

  def update_with_tax_ids(params)
    update_taxes_by_id(params[:tax_ids])
    update(params)
  end

  def update_taxes_by_id(selected_tax_ids)
    selected_tax_ids = [] unless selected_tax_ids

    # remove
    taxes.each do |tax|
      taxes.delete(tax) unless selected_tax_ids.include? tax.id
    end

    # add
    selected_tax_ids.each do |tax_id|
      taxes << Tax.find(tax_id)
    end
  end
end
