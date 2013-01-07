require 'test_helper'

class RepublicasControllerTest < ActionController::TestCase
  setup do
    @republica = republicas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:republicas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create republica" do
    assert_difference('Republica.count') do
      post :create, republica: { ano_de_fundacao: @republica.ano_de_fundacao, descricao: @republica.descricao, endereco: @republica.endereco, nome: @republica.nome, password_digest: @republica.password_digest, telefone: @republica.telefone, tipo: @republica.tipo, username: @republica.username }
    end

    assert_redirected_to republica_path(assigns(:republica))
  end

  test "should show republica" do
    get :show, id: @republica
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @republica
    assert_response :success
  end

  test "should update republica" do
    put :update, id: @republica, republica: { ano_de_fundacao: @republica.ano_de_fundacao, descricao: @republica.descricao, endereco: @republica.endereco, nome: @republica.nome, password_digest: @republica.password_digest, telefone: @republica.telefone, tipo: @republica.tipo, username: @republica.username }
    assert_redirected_to republica_path(assigns(:republica))
  end

  test "should destroy republica" do
    assert_difference('Republica.count', -1) do
      delete :destroy, id: @republica
    end

    assert_redirected_to republicas_path
  end
end
