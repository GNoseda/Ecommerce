require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'Brings all ancestors categories' do
    category_1 = Category.create(name:'category_01')
    category_2 = Category.create(name:'category_02', category_id:1)
    expect(category_2.ancestry).to  eq([1])
  end

  it 'Brings all offsprings categories' do
    category_1 = Category.create(name:'category_01')
    category_2 = Category.create(name:'category_02', category_id:1)
    expect(category_1.ancestry).to  eq([2])
  end
end
