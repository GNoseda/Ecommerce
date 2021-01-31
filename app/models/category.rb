class Category < ApplicationRecord
  has_and_belongs_to_many :products
  has_many :categories, class_name: 'Category'
  belongs_to :master, class_name: 'Category', optional: true

  def ancestry(ancestors = nil)
    ancestors ||= []
    if !self.category_id.nil?
      parent = self.category_id
      ancestors << parent
      ancestors =  Category.find(parent).ancestry(ancestors)
    end
    ancestors
  end

  def offspring(offsprings = nil)
    offsprings ||= []
    childrens = Category.where(category_id: self.id)
    childrens.each do |child|
      offsprings << child.id
      child.offspring(offsprings)
    end
    offsprings
  end

end
