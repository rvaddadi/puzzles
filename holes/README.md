Solução para o seguinte problema, proposto por Guilherme Branco na lista de e-mails do GaroaHC:

# Problema

Se você pensar em um papel como um plano e uma letra como uma marcação neste plano, então estas letras dividem o plano em regiões. Por exemplo, as letras A, D e O dividem o plano em 2 pois possuem um espaço confinado em seu desenho, ou um “buraco”. Outras letras como B possuem 2 buracos e letras como C e E não possuem buracos. Portanto, o número de buracos em um texto é igual a soma dos buracos nas palavras de um texto.

# Regras

## Entrada

A entrada deverá esperar um inteiro simples T (<=40) seguido de “:” que representa o número de casos de teste. Em seguida há T casos de teste, separados por “;”. O limite do texto é 100 caracteres. Cada palavra do texto é composta de letras no alfabeto português.

## Saída

Imprimir uma única linha contendo o número de buracos em cada texto correspondente, separados por “;”.

## Exemplo

### Entrada

```
3:paralelepipedo;hello; this is spartaaa;
```

### Saída

```
10;2;5
```

## Restrições

1. Qualquer linguagem de script em shell será aceita;
2. O tempo de execução deverá ser no máximo 15s;
3. O arquivo deverá conter no máximo 5KB.

# Executando a solução

## Rodar os testes

```bash
$ rake test
```

## Executar o programa

```bash
$ ruby lib/holes.rb <<< '3:paralelepipedo;hello; this is spartaaa;'
```
