require 'test_helper'

class MoradoresControllerTest < ActionController::TestCase
  setup do
    @morador = moradores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:moradores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create morador" do
    assert_difference('Morador.count') do
      post :create, morador: { ano_de_ingresso: @morador.ano_de_ingresso, curso: @morador.curso, nome: @morador.nome, ra: @morador.ra, republica_id: @morador.republica_id, sobrenome: @morador.sobrenome, universidade: @morador.universidade }
    end

    assert_redirected_to morador_path(assigns(:morador))
  end

  test "should show morador" do
    get :show, id: @morador
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @morador
    assert_response :success
  end

  test "should update morador" do
    put :update, id: @morador, morador: { ano_de_ingresso: @morador.ano_de_ingresso, curso: @morador.curso, nome: @morador.nome, ra: @morador.ra, republica_id: @morador.republica_id, sobrenome: @morador.sobrenome, universidade: @morador.universidade }
    assert_redirected_to morador_path(assigns(:morador))
  end

  test "should destroy morador" do
    assert_difference('Morador.count', -1) do
      delete :destroy, id: @morador
    end

    assert_redirected_to moradores_path
  end
end
