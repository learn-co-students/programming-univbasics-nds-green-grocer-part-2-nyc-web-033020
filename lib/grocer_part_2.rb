require 'pry'

require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  cart_w_coupons_applied = []
  cart_index = 0
  while cart_index < cart.size do
    current_item = cart[cart_index]
    coupons_index = 0
    while coupons_index < coupons.size do
      current_coupon = coupons[coupons_index]
      
      if current_coupon[:item] == current_item[:item] && current_coupon[:num] <= current_item[:count]
        item_price_w_coupon_applied = current_coupon[:cost] / current_coupon[:num]
        item_count_w_coupon_applied = current_coupon[:num] * (current_item[:count] / current_coupon[:num])

        cart << {
          :item => "#{current_item[:item]} W/COUPON",
          :price => item_price_w_coupon_applied,
          :clearance => current_item[:clearance],
          :count => item_count_w_coupon_applied
        }

        current_item[:count] -= item_count_w_coupon_applied
      end
      coupons_index += 1
    end
    cart_index += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart_index = 0
  while cart_index < cart.size do
    item = cart[cart_index] 
    if item[:clearance] == true
      item[:price] = (item[:price] - item[:price] * 0.2).round(2)
    end
    cart_index += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers

  final_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  total = 0
  final_cart_index = 0
  while final_cart_index < final_cart.size do
    item = final_cart[final_cart_index]
    total += item[:price] * item[:count] 
    final_cart_index += 1
  end
  if total > 100
    total *= 0.9
  end
  total.round(2)
end