class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update destroy]

  def index
    @products = current_account.products.order(:category, :name)
  end

  def new
    @product = current_account.products.new
  end

  def create
    @product = current_account.products.new(product_attributes)
    if @product.save
      redirect_to products_path, notice: "Producto creado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_attributes)
      redirect_to products_path, notice: "Producto actualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Producto eliminado."
  end

  private

  def set_product
    @product = current_account.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :category, :unit, :base_price_colones)
  end

  def product_attributes
    attrs = product_params.to_h
    colones = attrs.delete("base_price_colones")
    attrs["base_price_cents"] = colones.to_i * 100 if colones.present?
    attrs
  end
end
