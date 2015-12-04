class Pdf::VoucherDocument < Pdf::GeneralDocument

  require "prawn/table"


  def initialize(reward_order)
    super({})


    y_position = cursor

    stroke do
      rectangle [0, y_position], 540, 100 
    end

    bounding_box([0, y_position], width: 440, height: 92) do
      move_down 35
      indent(10) do
        text "Pedido <b>#{reward_order.code}</b>", size: 20, inline_format: true
        text "Proveedor <b>#{reward_order.supplier}</b>", size: 12, inline_format: true
      end
    end
    bounding_box([449, y_position], width: 90, height: 92) do
      move_down 1
      image(image_path(reward_order.qr_code.remote_url), width: 90 , height: 90 )
    end


    y_position -= 120



    #-----------------------------------------------------------------------
    #------------------------------------------------------------ TABLE

    #------------------------------------------------ HEAD
    bounding_box([0, y_position], width: 330, height: 50) do
      move_down 20
      indent(10) do
        text '<b>Premio</b>', size: 14, align: :center, inline_format: true
      end
    end
    bounding_box([330, y_position], width: 70, height: 50) do
      move_down 20
      text '<b>Puntos</b>', size: 14, align: :center, inline_format: true
    end
    bounding_box([400, y_position], width: 70, height: 50) do
      move_down 20
      text '<b>Cantidad</b>', size: 14, align: :center, inline_format: true
    end
    bounding_box([470, y_position], width: 70, height: 50) do
      move_down 20
      text '<b>Subtotal</b>', size: 14, align: :center, inline_format: true
    end

    y_position -= 50


    #------------------------------------------------ ITEMS
    odd_pair = ['EEEEEE', 'FFFFFF']
    reward_order.reward_order_items.each_with_index do |item, index|
      reward = item.reward

      stroke_horizontal_rule
      fill do
        fill_color odd_pair[(index%2)]
        rectangle [0, y_position], 540, 50 
      end  

      fill_color '000000'

      bounding_box([0, y_position], width: 50, height: 50) do
        image(image_path(reward.image.remote_url), width: 50, height: 50 )
      end
      bounding_box([60, y_position], width: 270, height: 50) do
        move_down 20
        text reward.name
      end
      bounding_box([330, y_position], width: 70, height: 50) do
        move_down 20
        text item.need_points.to_s, align: :center
      end
      bounding_box([400, y_position], width: 70, height: 50) do
        move_down 20
        stroke_bounds
        text item.amount.to_s, align: :center
      end
      bounding_box([470, y_position], width: 70, height: 50) do
        move_down 20
        stroke_bounds
        text item.total_need_points.to_s, align: :center
      end

      
      y_position -= 50

    end


    #------------------------------------------------ TOTAL
    stroke_horizontal_rule
    fill do
      fill_color 'EEFFEE'
      rectangle [0, y_position], 540, 50 
    end  

    fill_color '000000'

    bounding_box([0, y_position], width: 400, height: 50) do
      move_down 20
      stroke_bounds
      indent(10) do
        text '<b>Totales</b>', size: 14, align: :center, inline_format: true
      end
    end
    bounding_box([400, y_position], width: 70, height: 50) do
      move_down 20
      stroke_bounds
      text "<b>#{reward_order.total_amount}</b>", size: 14, align: :center, inline_format: true
    end
    bounding_box([470, y_position], width: 70, height: 50) do
      move_down 20
      stroke_bounds
      text "<b>#{reward_order.total_need_points}</b>", size: 14, align: :center, inline_format: true
    end
    stroke_horizontal_rule

    y_position -= 50









  end

end