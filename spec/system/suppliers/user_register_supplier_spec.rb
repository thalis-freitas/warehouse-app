require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir do menu' do 

    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'

    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'E-mail'
  end

  it 'com sucesso' do
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'

    fill_in 'Nome Fantasia' , with: 'Spark'
    fill_in 'Razão Social', with: 'Spark Industries Brasil LTDA'
    fill_in 'CNPJ', with: '44037925000122'
    fill_in 'Endereço', with: 'Torre da Indústria, 10'
    fill_in 'Cidade', with: 'Teresina'
    fill_in 'Estado', with: 'Pi'
    fill_in 'E-mail', with: 'vendas@spark.com.br'
    click_on 'Criar Fornecedor'

    expect(page).to have_content 'Fornecedor cadastrado com sucesso'
    expect(page).to have_content 'Spark Industries Brasil LTDA'
    expect(page).to have_content 'Documento: 44.037.925/0001-22'
    expect(page).to have_content 'E-mail: vendas@spark.com.br'
    expect(page).to have_content 'Endereço: Torre da Indústria, 10 - Teresina - PI'
  end

  it 'com dados incompletos' do 
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Criar Fornecedor'

    expect(page).to have_content 'Fornecedor não cadastrado'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end

  it 'com dado exclusivo que já está em uso' do 
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'CNPJ', with: '34472163000102'
    click_on 'Criar Fornecedor'

    expect(page).to have_content 'CNPJ já está em uso'
  end

  it 'com dados inválidos' do 
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'CNPJ', with: '344721'
    fill_in 'E-mail', with: 'vendasspark.com.br'
    click_on 'Criar Fornecedor'

    expect(page).to have_content 'CNPJ não é válido'
    expect(page).to have_content 'E-mail não é válido'
  end
end