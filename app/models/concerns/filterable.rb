module Filterable
  extend ActiveSupport::Concern

  def self.included(base)
    base.extend(FilterProducts)
  end

  module FilterProducts
    def filter(filtering_params)
      results = Product.all
      if filtering_params.present?
        key = '%' + filtering_params[:criteria] + '%'
        results = results.where('name LIKE :search OR model LIKE :search OR adding_information LIKE :search',
                                search: key).order(:name)
        if filtering_params[:category].present?
          results = results.where(category_id: filtering_params[:category].to_i)
        end
       end
      results
    end


  end

end