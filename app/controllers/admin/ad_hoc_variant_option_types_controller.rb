class Admin::AdHocVariantOptionTypesController < Admin::ResourceController

  before_filter :load_product, :only => [:selected]

  def selected
    @option_types = @product.ad_hoc_variant_option_types
  end

  def remove
    @product=@ad_hoc_variant_option_type.product
    @ad_hoc_variant_option_type.destroy
    flash.notice = I18n.t("notice_messages.option_type_removed")
    redirect_to selected_admin_product_ad_hoc_variant_option_types_url(@product)
  end

  protected
    def location_after_save
      if @ad_hoc_variant_option_type.created_at == @ad_hoc_variant_option_type.updated_at
        selected_admin_product_ad_hoc_variant_option_types_url(@ad_hoc_variant_option_type.product)
      else
        # removed 'product' from below...correct? product_
        # admin_product_ad_hoc_variant_option_types_url(@product) # TODO: is this right?
        admin_ad_hoc_variant_option_types_url # TODO: is this right?
      end
    end

  private
    def load_product
      @product = Product.find_by_param!(params[:product_id])
    end

end
