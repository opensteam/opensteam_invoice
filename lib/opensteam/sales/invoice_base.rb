#	openSteam - http://www.opensteam.net
#  Copyright (C) 2009  DiamondDogs Webconsulting
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; version 2 of the License.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License along
#  with this program; if not, write to the Free Software Foundation, Inc.,
#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

module Opensteam::Sales

  # InvoiceBase Module
  # Holds information for order-invoices, like price, payment-address, order-items, etc
  # Mutliple invoice items can be created for an order object
  module InvoiceBase

    module States ; end
    
    
    def self.included(base) #:nodoc:
      
      Opensteam::Dependencies.set_invoice_model( base )
      
      
      base.send( :extend, ClassMethods )
      base.send( :include, InstanceMethods )
      
      base.class_eval do
        belongs_to :order, :class_name => 'Opensteam::Models::Order'
        belongs_to :customer, :class_name => 'User'
        belongs_to :address, :class_name => 'Opensteam::Models::Address'

        has_many :items, :class_name => 'Opensteam::Container::Item'
      
        named_scope :by_order, lambda { |order_id| { :include => :order, :conditions => { :order_id => order_id } } }
       
      end
    end


    module InstanceMethods

      # initializes new Invoice Object
      # address and customer for invoice are copied from order object
      def initialize(*args)
        super(*args)
        if order
          self.address = order.payment_address
          self.customer = order.customer
        end
      end


      # returns the amount in cents
      def amount_in_cents
        ( price * 100 ).to_i
      end

      # returns the order items
      def order_items ; items ; end


      # returns the order-id
      def order_id ; self.order ? self.order.id : nil ; end
    end


    module ClassMethods #:nodoc:

    end
    

  end


end
