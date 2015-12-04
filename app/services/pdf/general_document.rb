class Pdf::GeneralDocument < Prawn::Document

  def initialize(options = {})
    super(options)
  end

  def logo
    #image(
    #  image_path('logo.png'), width: 120
    #)
  end


  def separator
    stroke_horizontal_rule
    move_down 10
  end

  def image_path(name)
    File.join(Rails.root, 'public', name)
  end


end