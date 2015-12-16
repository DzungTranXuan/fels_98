words       = @data[:words]
categories  = @data[:categories]
filters     = @data[:filters]

count = (words.count + 1) / 2
word_list_first_half = words[0..(count-1)]
word_list_second_half = words[count..-1]

category_name = categories.detect {|category| category.id == @data[:selected_category_id]}.name
filter_name = filters.detect {|filter| filter[:id] == @data[:selected_filter_id]}[:key]

prawn_document do |pdf|
  pdf.text category_name, size: 20, align: :center, style: :bold
  pdf.move_down 5

  pdf.text I18n.t("label.#{filter_name}"), align: :center
  pdf.move_down 70

  @data[:words].each_with_index do |word, i|
    pdf.draw_text word.text, at: [0, pdf.y]
    pdf.draw_text word.text, at: [280, pdf.y]
    pdf.move_down 20
    pdf.start_new_page if pdf.y <= 0
  end
end