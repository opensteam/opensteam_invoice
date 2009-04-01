module OrderInvoiceExtension

  def self.included(base)
    base.class_eval do
      has_many :invoices, :class_name => "Invoice", :extend => Opensteam::Sales::OrderBase::OrderExtension
    end
  end

end
