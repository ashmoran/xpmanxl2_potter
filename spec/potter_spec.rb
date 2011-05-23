require 'spec_helper'
require 'potter'

describe "Potter" do
  before(:each) do
    @price = 0
    @book_1 = nil
    @books_bought = 0
  end

  def buy_book(book)
    discount = 0.05
    @price += 8
    if @books_bought == 0
      @books_bought = 1
    elsif @book_1 == book
    else
      @price *= (1 - discount)
    end
    @book_1 = book
  end

  context "three books" do
    it "it gives 5% off only the two different books" do
      buy_book(:one)
      buy_book(:two)
      buy_book(:two)
      @price.should eq 23.2
    end

    it "it gives 5% off only the two different books in any order" do
      buy_book(:one)
      buy_book(:two)
      buy_book(:one)
      @price.should eq 23.2
    end
  end

  it "lets you buy a book" do
    buy_book(:one)
    @price.should eq 8
  end

  it "lets you buy two books" do
    buy_book(:one)
    buy_book(:one)
    @price.should eq 16
  end

  context "two books" do
    it "gives you 5% off for :one and :two" do
      buy_book(:one)
      buy_book(:two)
      @price.should eq 15.2
    end

    it "gives you 5% off for :one and :three" do
      buy_book(:one)
      buy_book(:three)
      @price.should eq 15.2
    end    

    it "gives you 5% off for :two and :three" do
      buy_book(:two)
      buy_book(:three)
      @price.should eq 15.2
    end
  end
end