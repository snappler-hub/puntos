module CommentsHelper
 
  def comment_widget(url)
    content_tag :div, '', class: 'comments_widget', data: { path: url } 
  end
  
end
