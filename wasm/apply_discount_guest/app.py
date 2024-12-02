import apply_discount

class ApplyDiscount(apply_discount.ApplyDiscount):
  def apply_discount(self, order) -> apply_discount.Discount:
    if order.customer == "Bob":
      return apply_discount.Discount(description="Bobs Discount", amount=500)