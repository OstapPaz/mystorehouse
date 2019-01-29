module ApplicationHelper

  def show_avatar(product, size = '250x250', clas = 'default')
    if product.avatar.attached?
      image_tag product.avatar, size: size, class: clas
    else
      image_tag('question_top.jpg', size: size, class: clas)
    end
  end



end
