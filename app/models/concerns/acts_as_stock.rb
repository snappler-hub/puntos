module ActsAsStock

  extend ActiveSupport::Concern

  included do

    has_many :stocks, class_name: 'Stock::Stock', as: :stockable, dependent: :destroy
    after_create :generate_stock

    def generate_stock
      Stock::Stock.create(stockable: self)
    end


    def stock_hard_down(hash)
      stock = get_stock
      stock.stock_hard_down(hash) unless (stock.nil?)
    end

    def stock_hard_up(hash)
      stock = get_stock
      stock.stock_hard_up(hash) unless (stock.nil?)
    end

    def stock_soft_down(hash)
      stock = get_stock
      stock.stock_soft_down(hash) unless (stock.nil?)
    end

    def stock_soft_up(hash)
      stock = get_stock
      stock.stock_soft_up(hash) unless (stock.nil?)
    end

    def get_stock_for_date(date=nil)
      stock = get_stock
      stock.get_stock_for_date(date) unless (stock.nil?)
    end

    def print
      stock = get_stock
      stock.print unless (stock.nil?)
    end

    def real_stock
      stock = get_stock
      stock.real_stock unless (stock.nil?)
    end


    def get_stock
      stocks.first
    end

  end

end