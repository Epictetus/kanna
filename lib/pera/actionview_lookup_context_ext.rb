class ActionView::LookupContext
  def formats=(values)
    if values
      values.concat(default_formats) if values.delete "*/*"
      values << :html if values == [:js]
      values << :html if values == [:pera]
    end
    super(values)
  end
end
