import 'package:assincrona/data/http/exceptions.dart';
import 'package:assincrona/data/models/produto_model.dart';
import 'package:assincrona/data/repositories/produto_repository.dart';
import 'package:flutter/cupertino.dart';

class ProdutoStore{

  final IProdutoRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<ProdutoModel>> state = ValueNotifier<List<ProdutoModel>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  ProdutoStore({required this.repository});

  getProdutos() async {
    isLoading.value = true;

    try {
      final result = await repository.getProdutos();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}