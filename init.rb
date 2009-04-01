# Include hook code here

require File.join( File.dirname(__FILE__), "lib", "states", "finished")
require File.join( File.dirname(__FILE__), "lib", "states", "payment_received")
require File.join( File.dirname(__FILE__), "lib", "states", "pending")
require File.join( File.dirname(__FILE__), "lib", "states", "waiting_for_payment")


Opensteam::Extension.register :order => :invoices do
  backend :sales
end


Opensteam::Models::Order.send( :include, OrderInvoiceExtension )
